/*
 LiuZX CA 数据库表结构脚本

 版本: 4.1.3
 日期: 2026-04-13
 说明: 创建所有表结构（最新版本，包含 4.1.x 全部改进）

 执行方式:
 mysql -u root -p lcloud_ca_4 < 02_create_tables.sql

 注意: 执行前请确保已创建数据库 lcloud_ca_4
*/

USE `lcloud_ca_4`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================================
-- 核心表
-- ============================================================================

-- ----------------------------
-- 1. ca_root - 根证书表
-- ----------------------------
DROP TABLE IF EXISTS `ca_root`;
CREATE TABLE `ca_root` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `name` varchar(100) NOT NULL COMMENT 'CA名称',
    `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0正常 1停用',
    `next_crlno` bigint DEFAULT NULL COMMENT '下一个CRL序号',
    `cert` longtext NOT NULL COMMENT '根证书（PEM格式）',
    `signer_type` varchar(100) NOT NULL COMMENT '签名者类型',
    `signer_id` bigint DEFAULT NULL COMMENT '签名者ID',
    `signer_conf` longtext NOT NULL COMMENT '签名者配置（JSON格式）',
    `certchain` longtext DEFAULT NULL COMMENT '证书链（PEM格式）',
    `conf` longtext DEFAULT NULL COMMENT '配置（JSON格式）',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`),
    KEY `idx_status` (`status`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='根证书表';

-- ----------------------------
-- 2. ca_profile - 证书模板表
-- ----------------------------
DROP TABLE IF EXISTS `ca_profile`;
CREATE TABLE `ca_profile` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `name` varchar(100) NOT NULL COMMENT '模板名称',
    `profile_version` int NOT NULL DEFAULT '1' COMMENT '模板版本号',
    `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否激活 0未激活 1已激活',
    `description` varchar(500) DEFAULT NULL COMMENT '模板描述',
    `type` varchar(100) DEFAULT NULL COMMENT '模板类型',
    `profile_category` varchar(100) DEFAULT NULL COMMENT '模板分类',
    `paired_profile_id` bigint DEFAULT NULL COMMENT '配对模板ID',
    `conf` longtext DEFAULT NULL COMMENT '模板配置（JSON格式）',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name_version` (`name`, `profile_version`),
    KEY `idx_is_active` (`is_active`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='证书模板表';

-- ----------------------------
-- 3. ca_requestor - 请求者表
-- ----------------------------
DROP TABLE IF EXISTS `ca_requestor`;
CREATE TABLE `ca_requestor` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `name` varchar(100) NOT NULL COMMENT '请求者名称',
    `requestor_type` varchar(100) DEFAULT NULL COMMENT '请求者类型',
    `type` varchar(100) DEFAULT NULL COMMENT '请求者类型',
    `conf` longtext DEFAULT NULL COMMENT '配置（JSON格式）',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`),
    KEY `idx_type` (`type`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='请求者表';

-- ----------------------------
-- 4. ca_publisher - 发布者表
-- ----------------------------
DROP TABLE IF EXISTS `ca_publisher`;
CREATE TABLE `ca_publisher` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `name` varchar(100) NOT NULL COMMENT '发布者名称',
    `type` varchar(100) DEFAULT NULL COMMENT '发布者类型',
    `conf` longtext DEFAULT NULL COMMENT '配置（JSON格式）',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`),
    KEY `idx_type` (`type`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='发布者表';

-- ----------------------------
-- 5. ca_cert - 证书表
-- ----------------------------
DROP TABLE IF EXISTS `ca_cert`;
CREATE TABLE `ca_cert` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `key_source` varchar(20) NOT NULL DEFAULT 'CLIENT' COMMENT '密钥来源: CLIENT, KMC, LOCAL',
    `cert_type` varchar(20) NOT NULL DEFAULT 'END_ENTITY' COMMENT '证书类型 ROOT_CA, SUB_CA, END_ENTITY',
    `cert_status` varchar(20) NOT NULL DEFAULT 'VALID' COMMENT '证书状态 VALID, EXPIRED, REVOKED, SUSPENDED, PENDING',

    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `serial_number` varchar(40) NOT NULL COMMENT '证书序列号',
    `profile_id` bigint NOT NULL COMMENT '证书模板ID',
    `requestor_id` bigint DEFAULT NULL COMMENT '请求者ID',

    `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上次更新时间',
    `not_before` datetime NOT NULL COMMENT '证书生效时间',
    `not_after` datetime NOT NULL COMMENT '证书失效时间',

    `is_revoked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否吊销 0未吊销 1已吊销',
    `revocation_reason` tinyint(1) DEFAULT NULL COMMENT '吊销原因码',
    `revocation_time` datetime DEFAULT NULL COMMENT '吊销时间',
    `revocation_invalidity_time` datetime DEFAULT NULL COMMENT '吊销无效时间',

    `is_entity` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否终端证书 0终端证书 1非终端证书',
    `subject` varchar(500) NOT NULL COMMENT '证书主题',

    `key_usage` varchar(200) DEFAULT NULL COMMENT '密钥用途',
    `extended_key_usage` varchar(200) DEFAULT NULL COMMENT '扩展密钥用途',
    `san` varchar(1000) DEFAULT NULL COMMENT '主题备用名称（SAN）',
    `key_pair_id` bigint DEFAULT NULL COMMENT '关联的密钥对ID',
    `parent_cert_id` bigint DEFAULT NULL COMMENT '父证书ID（证书链）',
    `cert_pair_id` bigint DEFAULT NULL COMMENT '证书对ID',
    `cert_usage` varchar(100) DEFAULT NULL COMMENT '证书用途',

    `crl_scope` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'CRL范围',
    `request_subject` varchar(500) DEFAULT NULL COMMENT '证书请求主题',
    `cert` longtext NOT NULL COMMENT '证书内容（PEM格式）',
    `sha1` varchar(50) NOT NULL COMMENT '证书指纹（SHA1）',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_root_serial` (`root_id`, `serial_number`),
    KEY `idx_serial_number` (`serial_number`),
    KEY `idx_subject` (`subject`(255)),
    KEY `idx_sha1` (`sha1`),
    KEY `idx_not_after` (`not_after`),
    KEY `idx_is_revoked` (`is_revoked`),
    KEY `idx_cert_status` (`cert_status`),
    KEY `idx_cert_type` (`cert_type`),
    KEY `idx_root_id_status` (`root_id`, `cert_status`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='证书表';

-- ----------------------------
-- 6. ca_crl - CRL表
-- ----------------------------
DROP TABLE IF EXISTS `ca_crl`;
CREATE TABLE `ca_crl` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `crl_scope` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'CRL范围',
    `crl_no` varchar(40) NOT NULL COMMENT 'CRL序号',
    `this_update` datetime NOT NULL COMMENT '本次更新时间',
    `next_before` datetime NOT NULL COMMENT '下次更新时间',
    `delta_crl` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否增量CRL 0完整CRL 1增量CRL',
    `base_crl_no` bigint DEFAULT NULL COMMENT '基础CRL序号',
    `crl` longtext NOT NULL COMMENT 'CRL内容（PEM格式）',
    `sha1` varchar(50) NOT NULL COMMENT 'CRL指纹（SHA1）',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_root_crl_no` (`root_id`, `crl_no`),
    KEY `idx_crl_no` (`crl_no`),
    KEY `idx_root_id` (`root_id`),
    KEY `idx_this_update` (`this_update`),
    KEY `idx_next_before` (`next_before`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='证书吊销列表表';

-- ============================================================================
-- 关联表
-- ============================================================================

-- ----------------------------
-- 7. ca_root_profile - 根证书-模板关联表
-- ----------------------------
DROP TABLE IF EXISTS `ca_root_profile`;
CREATE TABLE `ca_root_profile` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `profile_id` bigint NOT NULL COMMENT '证书模板ID',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_root_profile` (`root_id`, `profile_id`),
    KEY `idx_root_id` (`root_id`),
    KEY `idx_profile_id` (`profile_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='根证书-模板关联表';

-- ----------------------------
-- 8. ca_root_requestor - 根证书-请求者关联表
-- ----------------------------
DROP TABLE IF EXISTS `ca_root_requestor`;
CREATE TABLE `ca_root_requestor` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `requestor_id` bigint NOT NULL COMMENT '请求者ID',
    `profiles` varchar(500) DEFAULT NULL COMMENT '允许的证书模板（JSON数组）',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_root_requestor` (`root_id`, `requestor_id`),
    KEY `idx_root_id` (`root_id`),
    KEY `idx_requestor_id` (`requestor_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='根证书-请求者关联表';

-- ----------------------------
-- 9. ca_root_publisher - 根证书-发布者关联表
-- ----------------------------
DROP TABLE IF EXISTS `ca_root_publisher`;
CREATE TABLE `ca_root_publisher` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `publisher_id` bigint NOT NULL COMMENT '发布者ID',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_root_publisher` (`root_id`, `publisher_id`),
    KEY `idx_root_id` (`root_id`),
    KEY `idx_publisher_id` (`publisher_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='根证书-发布者关联表';

-- ----------------------------
-- 10. ca_publish_queue - 证书发布队列表
-- ----------------------------
DROP TABLE IF EXISTS `ca_publish_queue`;
CREATE TABLE `ca_publish_queue` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `cert_id` bigint NOT NULL COMMENT '证书ID',
    `cert_type` varchar(50) DEFAULT NULL COMMENT '证书类型 SIGNING, ENCRYPTION',
    `publisher_id` bigint NOT NULL COMMENT '发布者ID',
    `status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT '发布状态 PENDING, PROCESSING, SUCCESS, FAILED',
    `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
    `error_message` varchar(500) DEFAULT NULL COMMENT '错误消息',
    `next_retry_time` datetime DEFAULT NULL COMMENT '下次重试时间',
    `last_attempt_time` datetime DEFAULT NULL COMMENT '上次尝试时间',
    `payload` longtext DEFAULT NULL COMMENT '证书内容快照',

    PRIMARY KEY (`id`),
    KEY `idx_cert_id` (`cert_id`),
    KEY `idx_publisher_id` (`publisher_id`),
    KEY `idx_root_id` (`root_id`),
    KEY `idx_status` (`status`),
    KEY `idx_tenant_id` (`tenant_id`),
    KEY `idx_next_retry_time` (`next_retry_time`),
    KEY `idx_last_attempt_time` (`last_attempt_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='证书发布队列表';

-- ============================================================================
-- 4.1.0 新增表
-- ============================================================================

-- ----------------------------
-- 11. ca_cert_request - 证书申请表
-- ----------------------------
DROP TABLE IF EXISTS `ca_cert_request`;
CREATE TABLE `ca_cert_request` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `request_id` varchar(64) NOT NULL COMMENT '请求ID（唯一标识）',
    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `profile_id` bigint NOT NULL COMMENT '证书模板ID',
    `requestor_id` bigint DEFAULT NULL COMMENT '请求者ID',

    `request_type` varchar(20) NOT NULL COMMENT '请求类型: NEW, RENEW, REKEY, UPDATE',
    `request_status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT '请求状态: PENDING, APPROVED, REJECTED, ISSUED, FAILED',

    `csr` longtext NOT NULL COMMENT '证书签名请求（PKCS#10 或 CRMF）',
    `csr_format` varchar(20) NOT NULL DEFAULT 'PKCS10' COMMENT 'CSR格式: PKCS10, CRMF',
    `subject_dn` varchar(500) NOT NULL COMMENT '证书主题DN',
    `public_key_algorithm` varchar(50) NOT NULL COMMENT '公钥算法',
    `signature_algorithm` varchar(50) NOT NULL COMMENT '签名算法',

    `cert_id` bigint DEFAULT NULL COMMENT '签发的证书ID（关联ca_cert表）',
    `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
    `approval_user` bigint DEFAULT NULL COMMENT '审批人',
    `approval_comment` varchar(500) DEFAULT NULL COMMENT '审批意见',
    `reject_reason` varchar(500) DEFAULT NULL COMMENT '拒绝原因',

    `not_before` datetime DEFAULT NULL COMMENT '证书有效期开始时间',
    `not_after` datetime DEFAULT NULL COMMENT '证书有效期结束时间',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_request_id` (`request_id`),
    KEY `idx_root_id` (`root_id`),
    KEY `idx_requestor_id` (`requestor_id`),
    KEY `idx_request_status` (`request_status`),
    KEY `idx_create_time` (`create_time`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='证书申请表';

-- ----------------------------
-- 12. ca_cmp_log - CMP 交易日志表
-- ----------------------------
DROP TABLE IF EXISTS `ca_cmp_log`;
CREATE TABLE `ca_cmp_log` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `ca_name` varchar(100) DEFAULT NULL COMMENT 'CA名称',
    `requestor_name` varchar(255) DEFAULT NULL COMMENT '请求者名称',
    `message_type` varchar(50) DEFAULT NULL COMMENT 'CMP消息类型',
    `protection_alg` varchar(100) DEFAULT NULL COMMENT '保护算法',
    `client_ip` varchar(64) DEFAULT NULL COMMENT '客户端IP',
    `request_size` int DEFAULT NULL COMMENT '请求大小',
    `response_size` int DEFAULT NULL COMMENT '响应大小',
    `status` varchar(20) DEFAULT NULL COMMENT '处理状态',
    `status_code` int DEFAULT NULL COMMENT '状态码',
    `status_message` varchar(1000) DEFAULT NULL COMMENT '状态说明',
    `duration_ms` bigint DEFAULT NULL COMMENT '耗时毫秒',

    PRIMARY KEY (`id`),
    KEY `idx_ca_name` (`ca_name`),
    KEY `idx_message_type` (`message_type`),
    KEY `idx_status` (`status`),
    KEY `idx_create_time` (`create_time`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='CMP交易日志表';

-- ----------------------------
-- 13. ca_cmp_transaction - CMP 事务表
-- ----------------------------
DROP TABLE IF EXISTS `ca_cmp_transaction`;
CREATE TABLE `ca_cmp_transaction` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `transaction_id` varchar(64) NOT NULL COMMENT 'CMP事务ID',
    `sender_nonce` varchar(64) NOT NULL COMMENT '发送方随机数',
    `recipient_nonce` varchar(64) DEFAULT NULL COMMENT '接收方随机数',

    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `requestor_id` bigint DEFAULT NULL COMMENT '请求者ID',

    `message_type` varchar(20) NOT NULL COMMENT 'CMP消息类型: IR, CR, KUR, P10CR, RR, GENM, etc.',
    `request_message` longtext NOT NULL COMMENT 'CMP请求消息（Base64编码）',
    `response_message` longtext DEFAULT NULL COMMENT 'CMP响应消息（Base64编码）',

    `status` varchar(20) NOT NULL DEFAULT 'PROCESSING' COMMENT '状态: PROCESSING, SUCCESS, FAILED',
    `status_code` int DEFAULT NULL COMMENT 'PKI状态码',
    `status_message` varchar(500) DEFAULT NULL COMMENT '状态消息',

    `cert_request_id` bigint DEFAULT NULL COMMENT '关联的证书申请ID',
    `cert_id` bigint DEFAULT NULL COMMENT '签发的证书ID',

    `client_ip` varchar(50) DEFAULT NULL COMMENT '客户端IP',
    `user_agent` varchar(200) DEFAULT NULL COMMENT '用户代理',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_transaction_id` (`transaction_id`),
    KEY `idx_root_id` (`root_id`),
    KEY `idx_message_type` (`message_type`),
    KEY `idx_status` (`status`),
    KEY `idx_create_time` (`create_time`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='CMP协议事务表';

-- ----------------------------
-- 14. ca_cert_history - 证书历史记录表
-- ----------------------------
DROP TABLE IF EXISTS `ca_cert_history`;
CREATE TABLE `ca_cert_history` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    `cert_id` bigint NOT NULL COMMENT '证书ID',
    `serial_number` varchar(40) NOT NULL COMMENT '证书序列号',
    `root_id` bigint NOT NULL COMMENT '根CA_ID',

    `operation_type` varchar(20) NOT NULL COMMENT '操作类型: ISSUE, RENEW, REVOKE, SUSPEND, RESUME',
    `operation_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `operation_user` bigint NOT NULL COMMENT '操作人',
    `operation_reason` varchar(500) DEFAULT NULL COMMENT '操作原因',

    `old_status` varchar(20) DEFAULT NULL COMMENT '旧状态',
    `new_status` varchar(20) DEFAULT NULL COMMENT '新状态',

    `related_cert_id` bigint DEFAULT NULL COMMENT '关联证书ID（续期时的新证书）',
    `old_not_before` datetime DEFAULT NULL COMMENT '续期前证书生效时间',
    `old_not_after` datetime DEFAULT NULL COMMENT '续期前证书失效时间',
    `new_not_before` datetime DEFAULT NULL COMMENT '续期后证书生效时间',
    `new_not_after` datetime DEFAULT NULL COMMENT '续期后证书失效时间',
    `old_cert` longtext DEFAULT NULL COMMENT '续期前证书PEM快照',
    `new_cert` longtext DEFAULT NULL COMMENT '续期后证书PEM快照',

    PRIMARY KEY (`id`),
    KEY `idx_cert_id` (`cert_id`),
    KEY `idx_serial_number` (`serial_number`),
    KEY `idx_operation_type` (`operation_type`),
    KEY `idx_operation_time` (`operation_time`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='证书历史记录表';

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================================
-- 4.1.3 新增表 - KMC 连接配置支持
-- ============================================================================

-- ----------------------------
-- 15. ca_signer - 签名者表(支持系统身份凭证)
-- ----------------------------
DROP TABLE IF EXISTS `ca_signer`;
CREATE TABLE `ca_signer` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    -- 基本信息
    `name` varchar(100) NOT NULL COMMENT '签名者名称',
    `type` varchar(100) NOT NULL COMMENT '签名者类型: PKCS12, SDF',
    `category` varchar(50) NOT NULL DEFAULT 'ISSUER' COMMENT '类别: ISSUER(签发者), SYSTEM_AUTH(系统身份)',

    -- 证书和密钥配置
    `cert` text COMMENT '签名者证书(PEM格式)',
    `alias` varchar(200) DEFAULT NULL COMMENT '密钥别名',
    `password` varchar(500) DEFAULT NULL COMMENT '密钥库密码(加密存储)',

    -- 配置信息
    `conf` longtext DEFAULT NULL COMMENT '配置(JSON格式)',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`),
    KEY `idx_type` (`type`),
    KEY `idx_category` (`category`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='签名者表';

-- ----------------------------
-- 16. ca_config - CA系统配置表
-- ----------------------------
DROP TABLE IF EXISTS `ca_config`;
CREATE TABLE `ca_config` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',

    -- 配置核心字段
    `type` varchar(50) NOT NULL COMMENT '配置类型: CA_IDENTITY, KMC_SERVER, ARCHIVE_POLICY',
    `config` longtext NOT NULL COMMENT '配置详情(JSON格式)',

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_type_tenant` (`type`, `tenant_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='CA系统配置表';

-- ============================================================================
-- 4.1.5 新增表
-- ============================================================================

-- ----------------------------
-- 17. ca_archive_cert - 归档证书表
-- ----------------------------
DROP TABLE IF EXISTS `ca_archive_cert`;
CREATE TABLE `ca_archive_cert` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
    `editor` bigint DEFAULT NULL COMMENT '编辑人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
    `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
    `source_cert_id` bigint NOT NULL COMMENT '原证书ID',
    `archive_reason` varchar(20) NOT NULL COMMENT '归档原因 EXPIRED, REVOKED',
    `archive_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '归档时间',
    `key_source` varchar(20) NOT NULL DEFAULT 'CLIENT' COMMENT '密钥来源: CLIENT, KMC, LOCAL',
    `cert_type` varchar(20) NOT NULL DEFAULT 'END_ENTITY' COMMENT '证书类型 ROOT_CA, SUB_CA, END_ENTITY',
    `cert_status` varchar(20) NOT NULL DEFAULT 'VALID' COMMENT '证书状态 VALID, EXPIRED, REVOKED, SUSPENDED, PENDING',
    `root_id` bigint NOT NULL COMMENT '根CA_ID',
    `serial_number` varchar(40) NOT NULL COMMENT '证书序列号',
    `profile_id` bigint NOT NULL COMMENT '证书模板ID',
    `requestor_id` bigint DEFAULT NULL COMMENT '请求者ID',
    `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上次更新时间',
    `not_before` datetime NOT NULL COMMENT '证书生效时间',
    `not_after` datetime NOT NULL COMMENT '证书失效时间',
    `is_revoked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否吊销 0未吊销 1已吊销',
    `revocation_reason` tinyint(1) DEFAULT NULL COMMENT '吊销原因码',
    `revocation_time` datetime DEFAULT NULL COMMENT '吊销时间',
    `revocation_invalidity_time` datetime DEFAULT NULL COMMENT '吊销无效时间',
    `is_entity` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否终端证书 0终端证书 1非终端证书',
    `subject` varchar(500) NOT NULL COMMENT '证书主题',
    `key_usage` varchar(200) DEFAULT NULL COMMENT '密钥用途',
    `extended_key_usage` varchar(200) DEFAULT NULL COMMENT '扩展密钥用途',
    `san` varchar(1000) DEFAULT NULL COMMENT '主题备用名称（SAN）',
    `key_pair_id` bigint DEFAULT NULL COMMENT '关联的密钥对ID',
    `parent_cert_id` bigint DEFAULT NULL COMMENT '父证书ID（证书链）',
    `crl_scope` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'CRL范围',
    `request_subject` varchar(500) DEFAULT NULL COMMENT '证书请求主题',
    `cert` longtext NOT NULL COMMENT '证书内容（PEM格式）',
    `sha1` varchar(50) NOT NULL COMMENT '证书指纹（SHA1）',
    `cert_pair_id` bigint DEFAULT NULL COMMENT '配对证书ID',
    `cert_usage` varchar(20) DEFAULT NULL COMMENT '证书用途：SIGNING/ENCRYPTION',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_source_cert_id` (`source_cert_id`),
    KEY `idx_root_serial` (`root_id`, `serial_number`),
    KEY `idx_archive_reason` (`archive_reason`),
    KEY `idx_archive_time` (`archive_time`),
    KEY `idx_root_revoked` (`root_id`, `is_revoked`),
    KEY `idx_tenant_id` (`tenant_id`),
    KEY `idx_cert_pair_id` (`cert_pair_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='归档证书表';

SET FOREIGN_KEY_CHECKS = 1;

-- 完成提示
SELECT '所有表结构创建成功！共 17 张表' as '状态';
