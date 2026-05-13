/*
 LiuZX NAS 数据库表结构脚本
*/

USE `lcloud_nas_4`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- 1. nas_migration_task - 迁移任务表
-- ----------------------------
DROP TABLE IF EXISTS `nas_migration_task`;
CREATE TABLE `nas_migration_task` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '10' COMMENT '租户ID',

    `name` varchar(100) NOT NULL COMMENT '任务名称',
    `description` varchar(500) DEFAULT NULL COMMENT '描述',
    `source_path` varchar(1024) NOT NULL COMMENT '源服务器路径',
    `target_path` varchar(1024) NOT NULL COMMENT '目标服务器路径',
    `status` varchar(50) NOT NULL DEFAULT 'PENDING' COMMENT '状态',
    `total_files` bigint NOT NULL DEFAULT '0' COMMENT '总文件数',
    `migrated_files` bigint NOT NULL DEFAULT '0' COMMENT '已迁移文件数',
    `last_processed_file` text DEFAULT NULL COMMENT '最后处理的文件路径',
    `message` text DEFAULT NULL COMMENT '消息',

    PRIMARY KEY (`id`),
    KEY `idx_status` (`status`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='文件迁移任务表';
