/*
 LiuZX KMC 数据库表结构脚本

 版本: 4.1.2
 说明: 创建 KMC 业务库 lcloud_kmc_4 表结构（已吸收 m-of-n 字段）
*/

USE `lcloud_kmc_4`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================================
-- 密钥池表
-- ============================================================================

-- 1. kmc_pool_strategy - 备用密钥池策略表
DROP TABLE IF EXISTS `kmc_pool_strategy`;
CREATE TABLE `kmc_pool_strategy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `alg_type` varchar(50) NOT NULL COMMENT '算法类型，如 SM2、RSA2048',
  `key_usage` varchar(50) NOT NULL COMMENT '密钥用途 SIGN/ENCRYPT',
  `low_watermark` int NOT NULL DEFAULT '0' COMMENT '低水位阈值',
  `high_watermark` int NOT NULL DEFAULT '0' COMMENT '高水位阈值',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 0停用 1启用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_alg_usage` (`tenant_id`, `alg_type`, `key_usage`),
  KEY `idx_status` (`status`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='备用密钥池策略表';

-- 2. kmc_pool_key - 备用密钥池明细表
DROP TABLE IF EXISTS `kmc_pool_key`;
CREATE TABLE `kmc_pool_key` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `strategy_id` bigint NOT NULL DEFAULT '0' COMMENT '策略ID',
  `key_type` varchar(50) NOT NULL COMMENT '密钥类型',
  `key_bits` int NOT NULL DEFAULT '0' COMMENT '密钥比特数',
  `secret_key_ciphertext` longtext DEFAULT NULL COMMENT '对称密钥密文',
  `private_key_ciphertext` longtext DEFAULT NULL COMMENT '私钥密文或数字信封',
  `public_key_base64` longtext DEFAULT NULL COMMENT '公钥明文(Base64)',
  `key_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分配状态 0空闲 1已分配',
  PRIMARY KEY (`id`),
  KEY `idx_strategy_status` (`strategy_id`, `key_status`, `del_flag`, `create_time`),
  KEY `idx_key_type` (`key_type`),
  KEY `idx_key_status` (`key_status`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='备用密钥池明细表';

-- 3. kmc_pool_generation_job - 备用密钥生成任务表
DROP TABLE IF EXISTS `kmc_pool_generation_job`;
CREATE TABLE `kmc_pool_generation_job` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `job_name` varchar(100) NOT NULL COMMENT '任务名称',
  `strategy_id` bigint NOT NULL COMMENT '密钥池策略ID',
  `execute_type` varchar(32) NOT NULL COMMENT '执行策略 IMMEDIATE/CRON/FIXED_INTERVAL',
  `cron_expression` varchar(120) DEFAULT NULL COMMENT 'Cron表达式',
  `fixed_interval_seconds` int DEFAULT NULL COMMENT '固定间隔秒数',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 0停用 1启用',
  `run_status` varchar(32) NOT NULL DEFAULT 'IDLE' COMMENT '运行状态',
  `last_run_time` datetime DEFAULT NULL COMMENT '最近运行时间',
  `next_run_time` datetime DEFAULT NULL COMMENT '下次运行时间',
  `success_count` int NOT NULL DEFAULT '0' COMMENT '成功次数',
  `failure_count` int NOT NULL DEFAULT '0' COMMENT '失败次数',
  `last_failure_reason` varchar(1000) DEFAULT NULL COMMENT '最近失败原因',
  PRIMARY KEY (`id`),
  KEY `idx_strategy_id` (`strategy_id`),
  KEY `idx_status_execute` (`status`, `execute_type`, `del_flag`),
  KEY `idx_next_run_time` (`next_run_time`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='备用密钥生成任务表';

-- 4. kmc_pool_generation_job_log - 备用密钥生成任务日志表
DROP TABLE IF EXISTS `kmc_pool_generation_job_log`;
CREATE TABLE `kmc_pool_generation_job_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `job_id` bigint NOT NULL COMMENT '任务ID',
  `strategy_id` bigint NOT NULL COMMENT '密钥池策略ID',
  `trigger_type` varchar(32) NOT NULL COMMENT '触发类型 IMMEDIATE/SCHEDULE/MANUAL',
  `requested_count` int NOT NULL DEFAULT '0' COMMENT '请求生成数量',
  `actual_count` int NOT NULL DEFAULT '0' COMMENT '实际生成数量',
  `status` varchar(32) NOT NULL COMMENT '执行结果',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `failure_reason` varchar(1000) DEFAULT NULL COMMENT '失败原因',
  PRIMARY KEY (`id`),
  KEY `idx_job_id` (`job_id`, `create_time`),
  KEY `idx_strategy_id` (`strategy_id`, `create_time`),
  KEY `idx_status` (`status`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='备用密钥生成任务日志表';

-- ============================================================================
-- 密钥生命周期表
-- ============================================================================

-- 5. kmc_used_key - 在用密钥表
DROP TABLE IF EXISTS `kmc_used_key`;
CREATE TABLE `kmc_used_key` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `ca_id` bigint NOT NULL DEFAULT '0' COMMENT 'CA机构ID',
  `key_type` varchar(50) NOT NULL COMMENT '密钥类型',
  `key_bits` int NOT NULL DEFAULT '0' COMMENT '密钥比特数',
  `secret_key_ciphertext` longtext DEFAULT NULL COMMENT '对称密钥密文',
  `private_key_ciphertext` longtext DEFAULT NULL COMMENT '私钥密文或数字信封',
  `public_key_base64` longtext DEFAULT NULL COMMENT '公钥明文(Base64)',
  `serial_number` varchar(64) NOT NULL COMMENT '证书序列号',
  `subject` varchar(500) DEFAULT NULL COMMENT '证书主题',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `expir_time` datetime DEFAULT NULL COMMENT '到期时间',
  `status` varchar(20) NOT NULL DEFAULT '0' COMMENT '状态 0在用 1注销 2冻结 4过期',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `integrity_hash` varchar(255) DEFAULT NULL COMMENT '行数据完整性校验值',
  PRIMARY KEY (`id`),
  KEY `idx_ca_id` (`ca_id`),
  KEY `idx_serial_number` (`serial_number`),
  KEY `idx_subject` (`subject`(255)),
  KEY `idx_status` (`status`),
  KEY `idx_expir_time` (`expir_time`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='在用密钥表';

-- 6. kmc_archive_key - 归档密钥表
DROP TABLE IF EXISTS `kmc_archive_key`;
CREATE TABLE `kmc_archive_key` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `ca_id` bigint NOT NULL DEFAULT '0' COMMENT 'CA机构ID',
  `key_type` varchar(50) NOT NULL COMMENT '密钥类型',
  `key_bits` int NOT NULL DEFAULT '0' COMMENT '密钥比特数',
  `secret_key_ciphertext` longtext DEFAULT NULL COMMENT '对称密钥密文',
  `private_key_ciphertext` longtext DEFAULT NULL COMMENT '私钥密文或数字信封',
  `public_key_base64` longtext DEFAULT NULL COMMENT '公钥明文(Base64)',
  `serial_number` varchar(64) NOT NULL COMMENT '证书序列号',
  `subject` varchar(500) DEFAULT NULL COMMENT '证书主题',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `expir_time` datetime DEFAULT NULL COMMENT '到期时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `archive_time` datetime DEFAULT NULL COMMENT '归档时间',
  `integrity_hash` varchar(255) DEFAULT NULL COMMENT '行数据完整性校验值',
  PRIMARY KEY (`id`),
  KEY `idx_ca_id` (`ca_id`),
  KEY `idx_serial_number` (`serial_number`),
  KEY `idx_subject` (`subject`(255)),
  KEY `idx_archive_time` (`archive_time`),
  KEY `idx_expir_time` (`expir_time`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='归档密钥表';

-- ============================================================================
-- 策略与审批表
-- ============================================================================

-- 7. kmc_ca - CA机构表
DROP TABLE IF EXISTS `kmc_ca`;
CREATE TABLE `kmc_ca` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `name` varchar(100) NOT NULL COMMENT 'CA机构名称',
  `type` varchar(50) DEFAULT NULL COMMENT 'CA类型',
  `status` varchar(20) NOT NULL DEFAULT '0' COMMENT '状态',
  `communication_cert_pem` text DEFAULT NULL COMMENT '与KMC通信的CA身份证书PEM',
  `cert_subject` varchar(500) DEFAULT NULL COMMENT '通信证书主题',
  `cert_issuer` varchar(500) DEFAULT NULL COMMENT '通信证书颁发者',
  `cert_serial_number` varchar(128) DEFAULT NULL COMMENT '通信证书序列号',
  `cert_not_before` datetime DEFAULT NULL COMMENT '通信证书生效时间',
  `cert_not_after` datetime DEFAULT NULL COMMENT '通信证书失效时间',
  `cert_fingerprint_sha256` varchar(128) DEFAULT NULL COMMENT '通信证书SHA-256指纹',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_name` (`tenant_id`, `name`),
  KEY `idx_cert_fingerprint` (`cert_fingerprint_sha256`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='CA机构表';

-- 8. kmc_judge - 司法取证/密钥恢复审批主记录表
DROP TABLE IF EXISTS `kmc_judge`;
CREATE TABLE `kmc_judge` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `target_id` bigint NOT NULL COMMENT '审批目标对象ID，如归档密钥ID',
  `target_type` varchar(50) NOT NULL COMMENT '审批目标对象类型',
  `decision` varchar(50) NOT NULL DEFAULT 'PENDING' COMMENT '审批决定 APPROVED/REJECTED/PENDING',
  `reason` text DEFAULT NULL COMMENT '审批原因/说明与审计摘要',
  `operator` varchar(100) NOT NULL COMMENT '审批操作人账号',
  `operator_ip` varchar(50) DEFAULT NULL COMMENT '审批人终端IP地址',
  `operator_ukey_sn` varchar(100) DEFAULT NULL COMMENT '审批人UKEY硬件序列号',
  `recovery_scene` varchar(50) DEFAULT NULL COMMENT '密钥恢复场景',
  `case_no` varchar(100) DEFAULT NULL COMMENT '关联案件编号',
  `applicant_org` varchar(200) DEFAULT NULL COMMENT '申请单位',
  `contact` varchar(100) DEFAULT NULL COMMENT '联系方式',
  `authorization_material` varchar(1000) DEFAULT NULL COMMENT '授权材料引用或说明',
  `required_approvers` int DEFAULT NULL COMMENT '最少签名人数m',
  `total_approvers` int DEFAULT NULL COMMENT '候选司法取证员总数n',
  `expires_at` datetime DEFAULT NULL COMMENT '签名有效期截止时间',
  `recovered_time` datetime DEFAULT NULL COMMENT '恢复完成时间',
  `recovery_result_json` text DEFAULT NULL COMMENT '恢复执行结果JSON',
  `status` varchar(20) NOT NULL DEFAULT '0' COMMENT '状态 0待审批 1已审批 2已拒绝 3已取消',
  PRIMARY KEY (`id`),
  KEY `idx_target` (`target_id`, `target_type`),
  KEY `idx_decision` (`decision`),
  KEY `idx_status` (`status`),
  KEY `idx_operator` (`operator`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='审批与恢复主记录表';

-- 9. kmc_judge_approval_record - 审批记录明细表
DROP TABLE IF EXISTS `kmc_judge_approval_record`;
CREATE TABLE `kmc_judge_approval_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `judge_id` bigint NOT NULL COMMENT '审批流程ID',
  `step` int NOT NULL COMMENT '审批步骤',
  `status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT '审批状态 PENDING/APPROVED/REJECTED',
  `approver_id` bigint NOT NULL COMMENT '审批人ID',
  `approver_name` varchar(100) NOT NULL COMMENT '审批人姓名',
  `approver_ip` varchar(50) DEFAULT NULL COMMENT '审批人IP',
  `approver_ukey_sn` varchar(100) DEFAULT NULL COMMENT '审批人UKEY SN',
  `comment` varchar(500) DEFAULT NULL COMMENT '审批意见',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `required` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否必须审批',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_judge_step` (`judge_id`, `step`),
  KEY `idx_judge_id` (`judge_id`),
  KEY `idx_approver_id` (`approver_id`),
  KEY `idx_status` (`status`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='审批记录明细表';

-- ============================================================================
-- 开发辅助表
-- ============================================================================

-- 10. kmc_test - 测试表
DROP TABLE IF EXISTS `kmc_test`;
CREATE TABLE `kmc_test` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `test_name` varchar(100) NOT NULL COMMENT '测试名称',
  `test_value` varchar(500) DEFAULT NULL COMMENT '测试值',
  PRIMARY KEY (`id`),
  KEY `idx_test_name` (`test_name`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='测试表';

SET FOREIGN_KEY_CHECKS = 1;
