/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80023 (8.0.23)
 Source Host           : localhost:3306
 Source Schema         : lcloud_platform_domain

 Target Server Type    : MySQL
 Target Server Version : 80023 (8.0.23)
 File Encoding         : 65001

 Date: 03/07/2024 14:32:26
*/
USE lcloud_platform_domain_4;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log` (
									 `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									 `creator` bigint DEFAULT NULL COMMENT '创建人',
									 `editor` bigint DEFAULT NULL COMMENT '编辑人',
									 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									 `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									 `tenant_id` bigint DEFAULT '0' COMMENT '租户ID',
									 `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录的用户名',
									 `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录的IP地址',
									 `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录的IP地址',
									 `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录的浏览器',
									 `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录的操作系统',
									 `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '事件状态 0已创建 1已消费',
									 `error_message` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误信息',
									 `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录类型',
									 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='登录日志';

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
BEGIN;
COMMIT;



-- ----------------------------
-- Table structure for sys_notice_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_log`;
CREATE TABLE `sys_notice_log` (
									  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									  `editor` bigint DEFAULT NULL COMMENT '编辑人',
									  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知编码',
									  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知名称',
									  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '通知状态 0成功 1失败',
									  `error_message` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误信息',
									  `param` text COMMENT '通知参数',
									  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='通知日志';

-- ----------------------------
-- Records of sys_notice_log
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operate_log`;
CREATE TABLE `sys_operate_log` (
									  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									  `editor` bigint DEFAULT NULL COMMENT '编辑人',
									  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
									  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作名称',
									  `module_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的模块名称',
									  `uri` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的URI',
									  `method_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的方法名',
									  `request_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的请求类型',
									  `request_params` text COMMENT '操作的请求参数',
									  `user_agent` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的浏览器',
									  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的IP地址',
									  `service_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的服务地址',
									  `service_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的服务ID',
									  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的归属地',
									  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '事件状态 0已创建 1已消费',
									  `operator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人',
									  `error_message` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误信息',
									  `profile` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作的服务环境',
									  `stack_trace` text COMMENT '操作的堆栈信息',
									  `cost_time` bigint NOT NULL DEFAULT '0' COMMENT '操作的消耗时间(毫秒)',
									  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='操作日志';

-- ----------------------------
-- Records of sys_operate_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_oss_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_log`;
CREATE TABLE `sys_oss_log` (
										`id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
										`creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
										`editor` bigint DEFAULT NULL COMMENT '编辑人',
										`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
										`update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
										`del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
										`version` int NOT NULL DEFAULT '0' COMMENT '版本号',
										`tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
										`name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名称',
										`md5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件的MD5标识',
										`url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件的URL',
										`size` bigint NOT NULL DEFAULT '0' COMMENT '文件大小',
										`status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '事件状态 0已创建 1已消费',
										`error_message` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误信息',
										PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='存储日志';

-- ----------------------------
-- Records of sys_oss_log
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_sql_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_sql_log`;
CREATE TABLE `sys_sql_log` (
									`id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									`creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									`editor` bigint DEFAULT NULL COMMENT '编辑人',
									`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									`update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									`del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									`version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									`tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									`service_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务ID',
									`sql` text COMMENT 'SQL',
									`cost_time` bigint NOT NULL DEFAULT '0' COMMENT '消耗时间(毫秒)',
									PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='存储日志';

-- ----------------------------
-- Records of sys_sql_log
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
