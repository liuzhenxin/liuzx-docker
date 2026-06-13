/*
 LiuZX RA 数据库表结构脚本

 说明: 创建 RA 业务库 lcloud_ra_4 表结构
 执行方式:
 mysql -u root -p lcloud_ra_4 < 01_ra_4_schema.sql

 注意: 执行前请确保已创建数据库 lcloud_ra_4
*/

USE `lcloud_ra_4`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
-- ----------------------------
-- ra_alert_history
-- ----------------------------
DROP TABLE IF EXISTS `ra_alert_history`;
CREATE TABLE `ra_alert_history` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `rule_id` bigint NOT NULL COMMENT '告警规则ID',
  `alert_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '告警类型',
  `alert_level` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '告警级别',
  `trigger_time` datetime NOT NULL COMMENT '触发时间',
  `trigger_value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '触发值',
  `business_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务类型',
  `business_id` bigint DEFAULT NULL COMMENT '业务ID',
  `alert_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '告警消息',
  `handle_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '处理状态（0待处理 1处理中 2已处理 3已忽略）',
  `handler_id` bigint DEFAULT NULL COMMENT '处理人ID',
  `handler_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理人姓名',
  `handle_time` datetime DEFAULT NULL COMMENT '处理时间',
  `handle_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '处理意见',
  `notify_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '通知状态（0未通知 1已通知 2通知失败）',
  `notify_time` datetime DEFAULT NULL COMMENT '通知时间',
  `recovery_time` datetime DEFAULT NULL COMMENT '恢复时间',
  `is_resolved` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已解决（0未解决 1已解决）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_rule_id` (`rule_id`),
  KEY `idx_alert_type` (`alert_type`),
  KEY `idx_trigger_time` (`trigger_time`),
  KEY `idx_handle_status` (`handle_status`),
  KEY `idx_business` (`business_type`,`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='告警历史表';
-- ----------------------------
-- ra_alert_rule
-- ----------------------------
DROP TABLE IF EXISTS `ra_alert_rule`;
CREATE TABLE `ra_alert_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `rule_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '规则名称',
  `alert_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '告警类型（cert_expire:证书过期, cert_revoke:证书吊销, system_error:系统错误, performance:性能告警）',
  `alert_level` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '告警级别（info:信息, warning:警告, error:错误, critical:严重）',
  `trigger_condition` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发条件（JSON格式）',
  `threshold_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '阈值',
  `notification_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知方式（email:邮件, sms:短信, webhook:webhook）',
  `notification_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '通知配置（JSON格式）',
  `cool_down_minutes` int NOT NULL DEFAULT '30' COMMENT '冷静期（分钟）',
  `rule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '规则状态（0禁用 1启用）',
  `effective_time` datetime DEFAULT NULL COMMENT '生效时间',
  `expire_time` datetime DEFAULT NULL COMMENT '失效时间',
  `description` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规则描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_alert_rule_name` (`rule_name`,`tenant_id`),
  KEY `idx_alert_type` (`alert_type`),
  KEY `idx_rule_status` (`rule_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='告警规则表';
-- ----------------------------
-- ra_apply
-- ----------------------------
DROP TABLE IF EXISTS `ra_apply`;
CREATE TABLE `ra_apply` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户ID',
  `profile_id` bigint NOT NULL DEFAULT '0' COMMENT '模板ID',
  `request_subject` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '证书请求主题',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态标识（0新申请 1审核通过 2审核拒绝）',
  `conf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '扩展数据',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书申请表';
-- ----------------------------
-- ra_audit_log
-- ----------------------------
DROP TABLE IF EXISTS `ra_audit_log`;
CREATE TABLE `ra_audit_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `operation_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作类型（cert_apply:证书申请, cert_approve:证书审批, cert_issue:证书签发, cert_revoke:证书吊销, cert_renewal:证书续期, cert_update:证书更新）',
  `operator_id` bigint NOT NULL COMMENT '操作人ID',
  `operator_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人姓名',
  `operation_time` datetime NOT NULL COMMENT '操作时间',
  `business_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务类型',
  `business_id` bigint DEFAULT NULL COMMENT '业务ID',
  `business_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务键',
  `operation_result` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作结果（success:成功, failed:失败）',
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误信息',
  `request_ip` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求IP',
  `user_agent` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'User-Agent',
  `before_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '操作前数据（JSON格式）',
  `after_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '操作后数据（JSON格式）',
  `description` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作描述',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_operation_type` (`operation_type`),
  KEY `idx_operator_id` (`operator_id`),
  KEY `idx_operation_time` (`operation_time`),
  KEY `idx_business` (`business_type`,`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='审计日志表';
-- ----------------------------
-- ra_cert
-- ----------------------------
DROP TABLE IF EXISTS `ra_cert`;
CREATE TABLE `ra_cert` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `apply_id` bigint NOT NULL DEFAULT '0' COMMENT '申请_ID',
  `root_id` bigint NOT NULL DEFAULT '0' COMMENT '根CA_ID',
  `serial_number` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '序列号',
  `profile_id` bigint NOT NULL DEFAULT '0' COMMENT '模板_ID',
  `requestor_id` bigint DEFAULT NULL COMMENT '请求者_ID',
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上次更新时间',
  `not_before` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '不早于',
  `not_after` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '不晚于',
  `is_revoked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '注销标识 0未注销 1已注销',
  `revocation_reason` tinyint(1) NOT NULL DEFAULT '0' COMMENT '吊销原因 0:unspecified 1:keyCompromise 2:cACompromise 3:affiliationChanged 4:superseded 5:cessationOfOperation 6:certificateHold 8:removeFromCRL 9:privilegeWithdrawn 10:aACompromise',
  `revocation_time` datetime DEFAULT NULL COMMENT '注销时间',
  `revocation_invalidity_time` datetime DEFAULT NULL COMMENT '注销有效时间',
  `subject` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书主题',
  `crl_scope` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'CRL范围，预留以备将来使用',
  `request_subject` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '证书请求主题',
  `cert` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书',
  `sha1` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书指纹',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_apply_id` (`apply_id`),
  KEY `idx_root_id` (`root_id`),
  KEY `idx_serial_number` (`serial_number`),
  KEY `idx_profile_id` (`profile_id`),
  KEY `idx_requestor_id` (`requestor_id`),
  KEY `idx_not_after` (`not_after`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书表';
-- ----------------------------
-- ra_cert_backup
-- ----------------------------
DROP TABLE IF EXISTS `ra_cert_backup`;
CREATE TABLE `ra_cert_backup` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `cert_id` bigint NOT NULL COMMENT '证书ID',
  `backup_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书备份内容',
  `backup_reason` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备份原因',
  `backup_time` datetime DEFAULT NULL COMMENT '备份时间',
  `backup_location` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备份位置',
  `restore_count` int NOT NULL DEFAULT '0' COMMENT '恢复次数',
  `last_restore_time` datetime DEFAULT NULL COMMENT '最后恢复时间',
  `is_restored` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已恢复（0否 1是）',
  `backup_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备份类型（manual:手动, auto:自动, scheduled:定时）',
  `retention_days` int NOT NULL DEFAULT '365' COMMENT '保留天数',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_cert_id` (`cert_id`),
  KEY `idx_backup_time` (`backup_time`),
  KEY `idx_backup_type` (`backup_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书备份表';
-- ----------------------------
-- ra_cert_operation_apply
-- ----------------------------
DROP TABLE IF EXISTS `ra_cert_operation_apply`;
CREATE TABLE `ra_cert_operation_apply` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `operation_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作类型（cert_revoke/cert_reissue/cert_freeze/cert_unfreeze）',
  `cert_id` bigint NOT NULL COMMENT '证书ID',
  `user_id` bigint NOT NULL COMMENT '证书用户ID',
  `reason` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '申请原因',
  `csr` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '补办CSR',
  `approval_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审批状态（0待审批 1已通过 2已拒绝）',
  `approver_id` bigint DEFAULT NULL COMMENT '审批人ID',
  `approver_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批人名称',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `approval_comment` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批意见',
  `issued_cert_id` bigint DEFAULT NULL COMMENT '签发证书ID',
  `issue_time` datetime DEFAULT NULL COMMENT '签发时间',
  `ext` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '扩展数据',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_ra_cert_operation_cert` (`tenant_id`,`cert_id`),
  KEY `idx_ra_cert_operation_user` (`tenant_id`,`user_id`),
  KEY `idx_ra_cert_operation_type` (`tenant_id`,`operation_type`),
  KEY `idx_ra_cert_operation_status` (`tenant_id`,`approval_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='RA证书操作申请表';
-- ----------------------------
-- ra_cert_policy
-- ----------------------------
DROP TABLE IF EXISTS `ra_cert_policy`;
CREATE TABLE `ra_cert_policy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `policy_oid` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '策略OID',
  `policy_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '策略名称',
  `policy_description` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '策略描述',
  `policy_rules` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '策略规则（JSON格式）',
  `approval_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否需要审批（0否 1是）',
  `policy_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '策略状态（0禁用 1启用）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_cert_policy_oid` (`policy_oid`,`tenant_id`),
  KEY `idx_policy_name` (`policy_name`),
  KEY `idx_policy_status` (`policy_status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书策略表';
-- ----------------------------
-- ra_cert_policy_profile
-- ----------------------------
DROP TABLE IF EXISTS `ra_cert_policy_profile`;
CREATE TABLE `ra_cert_policy_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `policy_id` bigint NOT NULL COMMENT '证书策略ID',
  `profile_id` bigint NOT NULL COMMENT '证书模板ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_cert_policy_profile` (`policy_id`,`profile_id`,`tenant_id`),
  KEY `idx_policy_id` (`policy_id`),
  KEY `idx_profile_id` (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书策略模板关系表';
-- ----------------------------
-- ra_cert_renewal
-- ----------------------------
DROP TABLE IF EXISTS `ra_cert_renewal`;
CREATE TABLE `ra_cert_renewal` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `old_cert_id` bigint NOT NULL COMMENT '原证书ID',
  `new_cert_id` bigint DEFAULT NULL COMMENT '新证书ID',
  `renewal_reason` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '续期原因',
  `renewal_time` datetime DEFAULT NULL COMMENT '续期时间',
  `approval_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审批状态（0待审批 1已通过 2已拒绝）',
  `approver_id` bigint DEFAULT NULL COMMENT '审批人ID',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `approval_comment` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批意见',
  `auto_renewal` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自动续期（0否 1是）',
  `renewal_days_before` int NOT NULL DEFAULT '30' COMMENT '提前续期天数',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_old_cert_id` (`old_cert_id`),
  KEY `idx_new_cert_id` (`new_cert_id`),
  KEY `idx_approval_status` (`approval_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书续期表';
-- ----------------------------
-- ra_cert_statistics
-- ----------------------------
DROP TABLE IF EXISTS `ra_cert_statistics`;
CREATE TABLE `ra_cert_statistics` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `stat_date` date NOT NULL COMMENT '统计日期',
  `total_cert_count` int NOT NULL DEFAULT '0' COMMENT '证书总数',
  `valid_cert_count` int NOT NULL DEFAULT '0' COMMENT '有效证书数',
  `revoked_cert_count` int NOT NULL DEFAULT '0' COMMENT '吊销证书数',
  `expired_cert_count` int NOT NULL DEFAULT '0' COMMENT '过期证书数',
  `pending_cert_count` int NOT NULL DEFAULT '0' COMMENT '待审核证书数',
  `new_cert_count` int NOT NULL DEFAULT '0' COMMENT '新增证书数',
  `renewed_cert_count` int NOT NULL DEFAULT '0' COMMENT '续期证书数',
  `updated_cert_count` int NOT NULL DEFAULT '0' COMMENT '更新证书数',
  `today_expire_cert_count` int NOT NULL DEFAULT '0' COMMENT '今日过期证书数',
  `week_expire_cert_count` int NOT NULL DEFAULT '0' COMMENT '本周过期证书数',
  `month_expire_cert_count` int NOT NULL DEFAULT '0' COMMENT '本月过期证书数',
  `root_ca_cert_count` int NOT NULL DEFAULT '0' COMMENT '根CA证书数',
  `intermediate_ca_count` int NOT NULL DEFAULT '0' COMMENT '中间CA证书数',
  `end_entity_cert_count` int NOT NULL DEFAULT '0' COMMENT '终端实体证书数',
  `rsa_cert_count` int NOT NULL DEFAULT '0' COMMENT 'RSA算法证书数',
  `ecdsa_cert_count` int NOT NULL DEFAULT '0' COMMENT 'ECDSA算法证书数',
  `ed25519_cert_count` int NOT NULL DEFAULT '0' COMMENT 'Ed25519算法证书数',
  `stat_by_type_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '按类型统计（JSON格式）',
  `stat_by_status_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '按状态统计（JSON格式）',
  `stat_by_profile_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '按模板统计（JSON格式）',
  `stat_by_root_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '按根CA统计（JSON格式）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_cert_statistics_date` (`stat_date`,`tenant_id`),
  KEY `idx_stat_date` (`stat_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书统计表';
-- ----------------------------
-- ra_cert_update
-- ----------------------------
DROP TABLE IF EXISTS `ra_cert_update`;
CREATE TABLE `ra_cert_update` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `cert_id` bigint NOT NULL COMMENT '证书ID',
  `new_cert_id` bigint DEFAULT NULL COMMENT '新证书ID',
  `old_cert_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '更新前证书内容',
  `new_cert_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '更新后证书内容',
  `update_reason` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新原因',
  `cert_update_time` datetime DEFAULT NULL COMMENT '证书更新时间',
  `approval_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审批状态（0待审批 1已通过 2已拒绝）',
  `approver_id` bigint DEFAULT NULL COMMENT '审批人ID',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `approval_comment` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批意见',
  `update_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新类型（rekey:重新密钥, reissue:重新申请, other:其他）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_cert_id` (`cert_id`),
  KEY `idx_approval_status` (`approval_status`),
  KEY `idx_cert_update_time` (`cert_update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书更新表';
-- ----------------------------
-- ra_crl
-- ----------------------------
DROP TABLE IF EXISTS `ra_crl`;
CREATE TABLE `ra_crl` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `crl_number` bigint NOT NULL COMMENT 'CRL序列号',
  `root_id` bigint NOT NULL COMMENT '根CA ID',
  `crl_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'CRL内容（PEM格式）',
  `crl_scope` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'CRL范围（full:全量, delta:增量）',
  `this_update` datetime NOT NULL COMMENT '本次更新时间',
  `next_update` datetime NOT NULL COMMENT '下次更新时间',
  `crl_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'CRL状态（0正常 1已废弃）',
  `entry_count` int NOT NULL DEFAULT '0' COMMENT '吊销条目数量',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `publish_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发布URL',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_crl_number` (`crl_number`,`tenant_id`),
  KEY `idx_root_id` (`root_id`),
  KEY `idx_this_update` (`this_update`),
  KEY `idx_crl_status` (`crl_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='CRL表';
-- ----------------------------
-- ra_crl_entry
-- ----------------------------
DROP TABLE IF EXISTS `ra_crl_entry`;
CREATE TABLE `ra_crl_entry` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `crl_id` bigint NOT NULL COMMENT 'CRL ID',
  `cert_id` bigint NOT NULL COMMENT '证书ID',
  `serial_number` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书序列号',
  `revocation_date` datetime NOT NULL COMMENT '吊销日期',
  `revocation_reason` tinyint(1) NOT NULL DEFAULT '0' COMMENT '吊销原因（0:unspecified 1:keyCompromise 2:cACompromise 3:affiliationChanged 4:superseded 5:cessationOfOperation 6:certificateHold 8:removeFromCRL 9:privilegeWithdrawn 10:aACompromise）',
  `invalidity_date` datetime DEFAULT NULL COMMENT '失效日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_crl_id` (`crl_id`),
  KEY `idx_cert_id` (`cert_id`),
  KEY `idx_serial_number` (`serial_number`),
  KEY `idx_revocation_date` (`revocation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='CRL条目表';
-- ----------------------------
-- ra_keypair
-- ----------------------------
DROP TABLE IF EXISTS `ra_keypair`;
CREATE TABLE `ra_keypair` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `keypair_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '密钥对名称',
  `key_algorithm` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '密钥算法（RSA:RSA, ECDSA:ECDSA, Ed25519:Ed25519）',
  `key_size` int DEFAULT NULL COMMENT '密钥长度（RSA用）',
  `curve_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '曲线名称（ECDSA用）',
  `public_key` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公钥（PEM格式）',
  `key_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '密钥状态（0正常 1已泄露 2已废弃）',
  `usage_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '使用类型（signature:签名, encryption:加密, both:双重用途）',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `associated_cert_id` bigint DEFAULT NULL COMMENT '关联证书ID',
  `description` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_keypair_name` (`keypair_name`,`tenant_id`),
  KEY `idx_key_algorithm` (`key_algorithm`),
  KEY `idx_key_status` (`key_status`),
  KEY `idx_associated_cert_id` (`associated_cert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='密钥对表';
-- ----------------------------
-- ra_notification
-- ----------------------------
DROP TABLE IF EXISTS `ra_notification`;
CREATE TABLE `ra_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `notification_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知类型（email:邮件, sms:短信, inapp:站内信）',
  `title` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知内容',
  `recipient_id` bigint NOT NULL COMMENT '接收人ID',
  `recipient_email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '接收人邮箱',
  `recipient_phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '接收人手机号',
  `send_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发送状态（0待发送 1发送成功 2发送失败）',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误信息',
  `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已读（0未读 1已读）',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  `priority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '优先级（0普通 1重要 2紧急）',
  `business_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务类型',
  `business_id` bigint DEFAULT NULL COMMENT '业务ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_recipient_id` (`recipient_id`),
  KEY `idx_send_status` (`send_status`),
  KEY `idx_is_read` (`is_read`),
  KEY `idx_business` (`business_type`,`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='通知表';
-- ----------------------------
-- ra_profile
-- ----------------------------
DROP TABLE IF EXISTS `ra_profile`;
CREATE TABLE `ra_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模板名称',
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板类型',
  `conf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_profile_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='证书模板表';
-- ----------------------------
-- ra_root
-- ----------------------------
DROP TABLE IF EXISTS `ra_root`;
CREATE TABLE `ra_root` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'CA名称',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态标识（0正常 1停用）',
  `crl_signer_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'CRL签名名称',
  `cert` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '根证书',
  `certchain` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '证书链',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_root_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='CA表';
-- ----------------------------
-- ra_root_profile
-- ----------------------------
DROP TABLE IF EXISTS `ra_root_profile`;
CREATE TABLE `ra_root_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `root_id` bigint NOT NULL DEFAULT '0' COMMENT '根CA_ID',
  `profile_id` bigint NOT NULL DEFAULT '0' COMMENT '模板_ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='根证书模板关联表';
-- ----------------------------
-- ra_system_config
-- ----------------------------
DROP TABLE IF EXISTS `ra_system_config`;
CREATE TABLE `ra_system_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `config_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置键',
  `config_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '配置值',
  `config_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置类型（system:系统配置, business:业务配置, security:安全配置）',
  `is_encrypted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加密（0否 1是）',
  `description` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '配置描述',
  `is_public` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否公开（0否 1是）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_system_config_key` (`config_key`,`tenant_id`),
  KEY `idx_config_type` (`config_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2059602060428578888 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统配置表';
-- ----------------------------
-- ra_user_root_profile
-- ----------------------------
DROP TABLE IF EXISTS `ra_user_root_profile`;
CREATE TABLE `ra_user_root_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `root_id` bigint NOT NULL COMMENT '根CA_ID',
  `profile_id` bigint NOT NULL COMMENT '模板_ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ra_user_root_profile` (`tenant_id`,`user_id`,`root_id`,`profile_id`),
  KEY `idx_ra_user_root_profile_user` (`tenant_id`,`user_id`),
  KEY `idx_ra_user_root_profile_root` (`tenant_id`,`root_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='RA业务用户根证书模板授权表';
-- ----------------------------
-- ra_user_statistics
-- ----------------------------
DROP TABLE IF EXISTS `ra_user_statistics`;
CREATE TABLE `ra_user_statistics` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `stat_date` date NOT NULL COMMENT '统计日期',
  `total_cert_apply_count` int NOT NULL DEFAULT '0' COMMENT '证书申请总数',
  `total_cert_owned_count` int NOT NULL DEFAULT '0' COMMENT '拥有证书总数',
  `pending_apply_count` int NOT NULL DEFAULT '0' COMMENT '待审批申请数',
  `approved_apply_count` int NOT NULL DEFAULT '0' COMMENT '已通过申请数',
  `rejected_apply_count` int NOT NULL DEFAULT '0' COMMENT '已拒绝申请数',
  `renewal_apply_count` int NOT NULL DEFAULT '0' COMMENT '续期申请数',
  `revoke_apply_count` int NOT NULL DEFAULT '0' COMMENT '吊销申请数',
  `update_apply_count` int NOT NULL DEFAULT '0' COMMENT '更新申请数',
  `stat_by_profile_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '按证书模板统计（JSON格式）',
  `stat_by_status_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '按状态统计（JSON格式）',
  `stat_by_cert_type_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '按证书类型统计（JSON格式）',
  `stat_by_root_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '按根CA统计（JSON格式）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_user_statistics_date` (`stat_date`,`tenant_id`),
  KEY `idx_stat_date` (`stat_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户证书统计表';
-- ----------------------------
-- ra_workflow_definition
-- ----------------------------
DROP TABLE IF EXISTS `ra_workflow_definition`;
CREATE TABLE `ra_workflow_definition` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `workflow_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程名称',
  `workflow_key` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程标识',
  `workflow_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程类型（cert_apply:证书申请, cert_renewal:证书续期, cert_revoke:证书吊销）',
  `definition` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程定义（JSON/XML格式）',
  `version_no` int NOT NULL DEFAULT '1' COMMENT '版本号',
  `effective_time` datetime NOT NULL COMMENT '生效时间',
  `expire_time` datetime DEFAULT NULL COMMENT '失效时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态（0草稿 1已发布 2已停用）',
  `description` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_workflow_key_version` (`workflow_key`,`version_no`,`tenant_id`),
  KEY `idx_workflow_type` (`workflow_type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工作流定义表';
-- ----------------------------
-- ra_workflow_instance
-- ----------------------------
DROP TABLE IF EXISTS `ra_workflow_instance`;
CREATE TABLE `ra_workflow_instance` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `definition_id` bigint NOT NULL COMMENT '流程定义ID',
  `instance_no` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例编号',
  `workflow_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程类型',
  `instance_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例状态（running:进行中, completed:已完成, terminated:已终止, suspended:已挂起）',
  `initiator_id` bigint NOT NULL COMMENT '发起人ID',
  `initiator_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发起人姓名',
  `start_time` datetime NOT NULL COMMENT '发起时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `current_node` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '当前节点',
  `business_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务类型',
  `business_id` bigint DEFAULT NULL COMMENT '业务ID',
  `business_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务键',
  `variables` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '流程变量（JSON格式）',
  `duration_millis` bigint DEFAULT NULL COMMENT '耗时（毫秒）',
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误信息',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `const_ra_workflow_instance_no` (`instance_no`,`tenant_id`),
  KEY `idx_definition_id` (`definition_id`),
  KEY `idx_instance_status` (`instance_status`),
  KEY `idx_initiator_id` (`initiator_id`),
  KEY `idx_business` (`business_type`,`business_id`),
  KEY `idx_start_time` (`start_time`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工作流实例表';
-- ----------------------------
-- ra_workflow_task
-- ----------------------------
DROP TABLE IF EXISTS `ra_workflow_task`;
CREATE TABLE `ra_workflow_task` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `instance_id` bigint NOT NULL COMMENT '流程实例ID',
  `task_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务标识',
  `task_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `task_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务类型（userTask:用户任务, serviceTask:服务任务, gateway:网关）',
  `task_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务状态（pending:待处理, completed:已处理, skipped:已跳过, terminated:已终止）',
  `assignee_id` bigint DEFAULT NULL COMMENT '处理人ID',
  `assignee_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理人姓名',
  `assignee_role` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理人角色',
  `start_time` datetime NOT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `due_time` datetime DEFAULT NULL COMMENT '期望完成时间',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '处理意见',
  `variables` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '任务变量（JSON格式）',
  `node_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程节点ID',
  `duration_millis` bigint DEFAULT NULL COMMENT '耗时（毫秒）',
  `is_urgent` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否紧急（0否 1是）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_task_key` (`task_key`),
  KEY `idx_task_status` (`task_status`),
  KEY `idx_assignee_id` (`assignee_id`),
  KEY `idx_start_time` (`start_time`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工作流任务表';

SET FOREIGN_KEY_CHECKS = 1;
