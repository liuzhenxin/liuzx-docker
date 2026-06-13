/*
 LiuZX NAS 数据库表结构脚本

 说明: 创建 NAS 业务库 lcloud_nas_4 表结构
 执行方式:
 mysql -u root -p lcloud_nas_4 < 01_nas_4_schema.sql

 注意: 执行前请确保已创建数据库 lcloud_nas_4
*/

USE `lcloud_nas_4`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================================
-- 文件迁移表
-- ============================================================================

-- ----------------------------
-- 1. nas_migration_task - 文件迁移任务表
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
    `last_processed_file` text COMMENT '最后处理的文件路径',
    `message` text COMMENT '消息',

    PRIMARY KEY (`id`),
    KEY `idx_status` (`status`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='文件迁移任务表';

-- ----------------------------
-- 2. nas_migration_failure_record - 迁移失败记录表
-- ----------------------------
DROP TABLE IF EXISTS `nas_migration_failure_record`;
CREATE TABLE `nas_migration_failure_record` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '10' COMMENT '租户ID',

    `task_id` bigint NOT NULL COMMENT '迁移任务ID',
    `relative_path` varchar(1024) NOT NULL COMMENT '源相对路径',
    `source_path` varchar(2048) NOT NULL COMMENT '源绝对路径',
    `target_path` varchar(2048) NOT NULL COMMENT '目标绝对路径',
    `failure_code` varchar(64) NOT NULL COMMENT '失败编码',
    `failure_reason` varchar(500) NOT NULL COMMENT '失败原因',
    `failed_file_size` bigint NOT NULL DEFAULT '0' COMMENT '失败时文件大小',
    `failed_last_modified_time` datetime DEFAULT NULL COMMENT '失败时文件修改时间',
    `status` varchar(50) NOT NULL DEFAULT 'PENDING' COMMENT '状态',
    `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
    `last_retry_time` datetime DEFAULT NULL COMMENT '最后重试时间',
    `retry_message` text COMMENT '重试消息',

    PRIMARY KEY (`id`),
    KEY `idx_migration_failure_task_id` (`task_id`),
    KEY `idx_migration_failure_status` (`status`),
    KEY `idx_migration_failure_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='迁移失败记录表';

SET FOREIGN_KEY_CHECKS = 1;
