#!/bin/bash
set -euo pipefail

# 配置部分
CONTAINER_NAME="kafka"
TOPIC_NAME="test-topic"
KAFKA_BIN="/opt/kafka/bin" # 官方镜像路径

echo ">>> Kafka 冒烟测试开始（容器: $CONTAINER_NAME）"

# 1. 创建 topic
# 使用 grep 检查是否存在，比 || true 更优雅，能看到真实错误
if docker exec "$CONTAINER_NAME" "$KAFKA_BIN/kafka-topics.sh" --list --bootstrap-server "$CONTAINER_NAME:9092" | grep -q "$TOPIC_NAME"; then
    echo ">>> Topic $TOPIC_NAME 已存在，跳过创建"
else
    echo ">>> 创建 Topic: $TOPIC_NAME"
    docker exec "$CONTAINER_NAME" "$KAFKA_BIN/kafka-topics.sh" \
      --create --topic "$TOPIC_NAME" --bootstrap-server "$CONTAINER_NAME:9092" \
      --partitions 1 --replication-factor 1
fi

# 2. 等待 topic leader 就绪 (关键修复)
echo ">>> 等待 Topic Leader 选举..."
LEADER_READY=false
for i in {1..20}; do
  # 获取 describe 输出
  OUTPUT=$(docker exec "$CONTAINER_NAME" "$KAFKA_BIN/kafka-topics.sh" \
    --describe --bootstrap-server "$CONTAINER_NAME:9092" --topic "$TOPIC_NAME")

  # 提取 Leader 值。匹配 "Leader: <数字/-1>"
  # 使用 sed 提取 Leader 后的值，兼容性更好
  LEADER=$(echo "$OUTPUT" | grep -o "Leader: [0-9-]*" | awk '{print $2}' | head -n 1)

  if [[ -n "$LEADER" && "$LEADER" != "-1" && "$LEADER" != "none" ]]; then
    echo ">>> Leader 就绪: Node $LEADER"
    LEADER_READY=true
    break
  fi

  echo ">>> 当前 Leader: ${LEADER:-未找到} (尝试 $i/20)..."
  sleep 2
done

if [ "$LEADER_READY" = false ]; then
  echo "❌ 错误: Leader 选举超时，集群状态可能异常"
  exit 1
fi

# 3. 发送测试消息
MSG="Hello_Kafka_$(date +%s)"
echo ">>> 发送消息: $MSG"
# 添加 -e 确保 echo 不处理特殊字符，直接传给管道
echo "$MSG" | docker exec -i "$CONTAINER_NAME" "$KAFKA_BIN/kafka-console-producer.sh" \
  --bootstrap-server "$CONTAINER_NAME:9092" --topic "$TOPIC_NAME"

# 4. 消费消息
echo ">>> 尝试消费消息（timeout 10s）"
# --max-messages 1 让它读到一条就自动退出，比纯超时更干净
CONSUMED_MSG=$(docker exec -i "$CONTAINER_NAME" "$KAFKA_BIN/kafka-console-consumer.sh" \
  --bootstrap-server "$CONTAINER_NAME:9092" --topic "$TOPIC_NAME" \
  --from-beginning --max-messages 1 --timeout-ms 10000 2>/dev/null)

echo ">>> 消费结果: $CONSUMED_MSG"

# 5. 验证结果
if [[ "$CONSUMED_MSG" == *"$MSG"* ]]; then
  echo "✅ 测试通过！Kafka 读写正常。"
else
  echo "❌ 测试失败：消费到的内容与发送不一致或为空。"
  exit 1
fi
