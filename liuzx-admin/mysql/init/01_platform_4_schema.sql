/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80023 (8.0.23)
 Source Host           : localhost:3306
 Source Schema         : lcloud_platform

 Target Server Type    : MySQL
 Target Server Version : 80023 (8.0.23)
 File Encoding         : 65001

 Date: 03/07/2024 14:32:26
*/
USE lcloud_platform_4;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_cluster 集群
-- ----------------------------
DROP TABLE IF EXISTS `sys_cluster`;
CREATE TABLE `sys_cluster` (
									`id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									`creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									`editor` bigint DEFAULT NULL COMMENT '编辑人',
									`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									`update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									`del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									`version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									`tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									`name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集群名称',
									`code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集群编码',
									`remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '集群备注',
									PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='集群';

-- ----------------------------
-- Records of sys_cluster
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_dept 部门
-- ---------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
								 `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
								 `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
								 `editor` bigint DEFAULT NULL COMMENT '编辑人',
								 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
								 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
								 `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
								 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
								 `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
								 `pid` bigint NOT NULL COMMENT '部门父节点',
								 `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
								 `path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '部门节点',
								 `sort` int NOT NULL DEFAULT '1' COMMENT '部门排序',
								 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='部门';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
COMMIT;
-- ----------------------------
-- Table structure for sys_dict 字典
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
								 `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
								 `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
								 `editor` bigint DEFAULT NULL COMMENT '编辑人',
								 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
								 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
								 `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
								 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
								 `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
								 `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典标签',
								 `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典类型',
								 `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '字典状态 0正常 1停用',
								 `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典备注',
								 PRIMARY KEY (`id`) USING BTREE,
								 UNIQUE KEY `sys_dict_type_tenantId_idx` (`type`,`tenant_id`) USING BTREE COMMENT '字典类型_唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='字典';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_item 字典项
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item` (
									  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									  `editor` bigint DEFAULT NULL COMMENT '编辑人',
									  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典标签',
									  `value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典值',
									  `sort` int NOT NULL DEFAULT '1' COMMENT '字典排序',
									  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
									  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
									  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
									  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
									  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典备注',
									  `type_id`  bigint NOT NULL DEFAULT '0' COMMENT '类型ID',
									  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='字典项';

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_i18n_menu 国际化消息
-- ----------------------------
DROP TABLE IF EXISTS `sys_i18n_menu`;
CREATE TABLE `sys_i18n_menu` (
										 `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
										 `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
										 `editor` bigint DEFAULT NULL COMMENT '编辑人',
										 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
										 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
										 `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
										 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
										 `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
										 `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
										 `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
										 PRIMARY KEY (`id`) USING BTREE,
										 UNIQUE KEY `sys_i18n_menu_code_menu_idx` (`code`,`name`) USING BTREE COMMENT '编码_名称_唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='国际化菜单';

-- ----------------------------
-- Records of sys_i18n_menu
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_menu 菜单
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
								 `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
								 `creator` bigint DEFAULT NULL COMMENT '创建人',
								 `editor` bigint DEFAULT NULL COMMENT '编辑人',
								 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
								 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
								 `del_flag` tinyint(1) DEFAULT '0' COMMENT '1已删除 0未删除',
								 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
								 `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
								 `pid` bigint NOT NULL COMMENT '父节点',
								 `permission` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限标识(多个用逗号分隔，如：sys:userDetails:list,sys:userDetails:save)',
								 `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
								 `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
								 `sort` int DEFAULT '0' COMMENT '显示顺序',
								 `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '路径',
								 `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
								 `query_param` varchar(255) DEFAULT NULL COMMENT '路由参数',
								 `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
								 `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
								 `visible` char(1) DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
								 `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
								 `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
								 `remark` varchar(500) DEFAULT '' COMMENT '备注',
								 PRIMARY KEY (`id`) USING BTREE,
								 KEY `idx_type_visible` (`type`,`visible`) USING BTREE COMMENT '类型_可见_索引'
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_menu_package 菜单套餐
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_package`;
CREATE TABLE `sys_menu_package` (
										 `id` bigint NOT NULL COMMENT 'ID',
										 `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
										 `editor` bigint DEFAULT NULL COMMENT '编辑人',
										 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
										 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
										 `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
										 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
										 `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
										 `package_id` bigint NOT NULL COMMENT '套餐ID',
										 `menu_id` bigint NOT NULL COMMENT '菜单ID',
										 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='套餐菜单';

-- ----------------------------
-- Records of sys_menu_package
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message` (
									`id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									`creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									`editor` bigint DEFAULT NULL COMMENT '编辑人',
									`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									`update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									`del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									`version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									`tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									`title` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消息标题',
									`content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消息内容',
									`type` tinyint NOT NULL DEFAULT '0' COMMENT '消息类型 0通知 1提醒',
									PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='消息';

-- ----------------------------
-- Records of sys_message
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_oss OSS
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss` (
								`id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
								`creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
								`editor` bigint DEFAULT NULL COMMENT '编辑人',
								`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
								`update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
								`del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
								`version` int NOT NULL DEFAULT '0' COMMENT '版本号',
								`tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
								`name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'OSS的名称',
                                `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'OSS的类型',
                                `param` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'OSS的参数',
                                `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'OSS的状态 0启用 1停用',
								PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='OSS';

-- ----------------------------
-- Records of sys_oss
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_package 套餐
-- ----------------------------
DROP TABLE IF EXISTS `sys_package`;
CREATE TABLE `sys_package` (
									`id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									`creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									`editor` bigint DEFAULT NULL COMMENT '编辑人',
									`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									`update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									`del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									`version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									`dept_id` bigint NOT NULL DEFAULT '0' COMMENT '部门ID',
									`dept_path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '部门PATH',
									`tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									`name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐名称',
									PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='套餐管理';

-- ----------------------------
-- Records of sys_package
-- ----------------------------
BEGIN;

COMMIT;

-- ----------------------------
-- Table structure for sys_role 角色
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
								 `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
								 `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
								 `editor` bigint DEFAULT NULL COMMENT '编辑人',
								 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
								 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
								 `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
								 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
								 `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
								 `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
								 `sort` int NOT NULL DEFAULT '1' COMMENT '角色排序',
								 `data_scope` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据范围 all全部 custom自定义 dept_self仅本部门 dept部门及以下 self仅本人',
								 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept 角色部门
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
									  `id` bigint NOT NULL COMMENT 'ID',
									  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									  `editor` bigint DEFAULT NULL COMMENT '编辑人',
									  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									  `role_id` bigint NOT NULL COMMENT '角色ID',
									  `dept_id` bigint NOT NULL COMMENT '部门ID',
									  PRIMARY KEY (`id`) USING BTREE,
									  KEY `role_id` (`role_id`) USING BTREE,
									  KEY `dept_id` (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色部门';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu 角色菜单
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
									  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									  `editor` bigint DEFAULT NULL COMMENT '编辑人',
									  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									  `role_id` bigint NOT NULL COMMENT '角色ID',
									  `menu_id` bigint NOT NULL COMMENT '菜单ID',
									  PRIMARY KEY (`id`) USING BTREE,
									  KEY `role_id` (`role_id`) USING BTREE,
									  KEY `menu_id` (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色菜单';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_source 数据源
-- ----------------------------
DROP TABLE IF EXISTS `sys_source`;
CREATE TABLE `sys_source` (
								   `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
								   `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
								   `editor` bigint DEFAULT NULL COMMENT '编辑人',
								   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
								   `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
								   `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
								   `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
								   `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
								   `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据源名称',
								   `driver_class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据源的驱动名称',
								   `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据源的连接信息',
								   `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据源的用户名',
								   `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据源的密码',
								   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='数据源';

-- ----------------------------
-- Records of sys_source
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_tenant 租户
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant` (
								   `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
								   `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
								   `editor` bigint DEFAULT NULL COMMENT '编辑人',
								   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
								   `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
								   `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
								   `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
								   `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
								   `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户名称',
								   `code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户标识',
								   `status` tinyint(1) DEFAULT '0' COMMENT '状态（0未初始化，不可用 -1已经初始化，可以使用）',
								   `source_id` bigint NOT NULL COMMENT '数据源ID',
								   `package_id` bigint NOT NULL COMMENT '套餐ID',
								   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='租户';

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user 用户
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
								 `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
								 `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
								 `editor` bigint DEFAULT NULL COMMENT '编辑人',
								 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
								 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
								 `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
								 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
								 `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
								 `dept_id` bigint NOT NULL DEFAULT '0' COMMENT '部门ID',
								 `username` varchar(100) NOT NULL COMMENT '用户名',
								 `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
								 `super_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '超级管理员标识 0否 1是',
								 `mail` varchar(100) DEFAULT NULL COMMENT '用户邮箱',
								 `mobile` varchar(100) DEFAULT NULL COMMENT '用户手机号',
								 `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态 0正常 1停用',
									 `user_category` varchar(50) DEFAULT NULL COMMENT '用户分类',
								 `avatar` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户头像',
								 `cert_sn` varchar(128) DEFAULT NULL COMMENT '证书序列号',
								 `cert_pem` text COMMENT '证书PEM编码',
								 `username_phrase` varchar(1000) DEFAULT NULL COMMENT '用户名短语',
								 `mail_phrase` varchar(1000) DEFAULT NULL COMMENT '用户邮箱短语',
								 `mobile_phrase` varchar(1000) DEFAULT NULL COMMENT '用户手机号短语',
								 PRIMARY KEY (`id`) USING BTREE,
								 UNIQUE KEY `idx_username_tenant_id` (`username`,`tenant_id`) USING BTREE COMMENT '用户名_租户_唯一索引',
								 UNIQUE KEY `idx_mail_tenant_id` (`mail`,`tenant_id`) USING BTREE COMMENT '邮箱_租户_唯一索引',
								 UNIQUE KEY `idx_mobile_tenant_id` (`mobile`,`tenant_id`) USING BTREE COMMENT '手机号_租户_唯一索引',
								 UNIQUE KEY `idx_certificate_tenant_id` (`cert_sn`,`tenant_id`) USING BTREE COMMENT '证书_租户_唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_user_dept 用户部门
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_dept`;
CREATE TABLE `sys_user_dept` (
									  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									  `editor` bigint DEFAULT NULL COMMENT '编辑人',
									  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									  `user_id` bigint NOT NULL COMMENT '用户ID',
									  `dept_id` bigint NOT NULL DEFAULT '0' COMMENT '部门ID',
									  PRIMARY KEY (`id`) USING BTREE,
									  KEY `user_id` (`user_id`) USING BTREE,
									  KEY `dept_id` (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户部门';

-- ----------------------------
-- Records of sys_user_dept
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for sys_user_message 用户消息
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_message`;
CREATE TABLE `sys_user_message` (
										 `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
										 `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
										 `editor` bigint DEFAULT NULL COMMENT '编辑人',
										 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
										 `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
										 `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
										 `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
										 `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
										 `user_id` bigint NOT NULL COMMENT '用户ID',
										 `message_id` bigint NOT NULL COMMENT '消息ID',
										 `read_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息已读标识 0未读 1已读',
										 PRIMARY KEY (`id`) USING BTREE,
										 KEY `user_id` (`user_id`) USING BTREE,
										 KEY `message_id` (`message_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户消息表';

-- ----------------------------
-- Records of sys_user_message
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role 用户角色
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
									  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
									  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
									  `editor` bigint DEFAULT NULL COMMENT '编辑人',
									  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
									  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
									  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
									  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
									  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
									  `user_id` bigint NOT NULL COMMENT '用户ID',
									  `role_id` bigint NOT NULL COMMENT '角色ID',
									  PRIMARY KEY (`id`) USING BTREE,
									  KEY `user_id` (`user_id`) USING BTREE,
									  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
COMMIT;

/*==============================================================*/
/* Table: sys_config                                            */
/*==============================================================*/
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
                            `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
                            `editor` bigint DEFAULT NULL COMMENT '编辑人',
                            `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                            `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                            `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
                            `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
                            `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
                            `k` VARCHAR(255) NOT NULL COMMENT '类型（例admin_key）',
                            `v` VARCHAR(255) DEFAULT NULL COMMENT '值',
                            `enabled` tinyint(1) NOT NULL COMMENT '1启用 0不启用',
                            PRIMARY KEY (id) USING BTREE,
                            UNIQUE KEY `sys_config_k` (k)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;

COMMIT;

-- ----------------------------
-- Table structure for oauth2_authorization_consent
-- ----------------------------
DROP TABLE IF EXISTS `oauth2_authorization_consent`;
CREATE TABLE `oauth2_authorization_consent` (
												`registered_client_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
												`principal_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
												`authorities` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
												PRIMARY KEY (`registered_client_id`,`principal_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of oauth2_authorization_consent
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for oauth2_registered_client
-- ----------------------------
DROP TABLE IF EXISTS `oauth2_registered_client`;
CREATE TABLE `oauth2_registered_client` (
											`id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
											`client_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
											`client_id_issued_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
											`client_secret` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
											`client_secret_expires_at` timestamp NULL DEFAULT NULL,
											`client_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
											`client_authentication_methods` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
											`authorization_grant_types` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
											`redirect_uris` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
											`post_logout_redirect_uris` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
											`scopes` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
											`client_settings` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
											`token_settings` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
											PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of oauth2_registered_client
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
