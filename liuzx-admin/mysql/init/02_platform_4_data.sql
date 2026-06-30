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
-- Records of oauth2_registered_client
-- ----------------------------
INSERT INTO `oauth2_registered_client` VALUES ('95TxSsTPFA3tF12TBSMmUVK0da', '95TxSsTPFA3tF12TBSMmUVK0da', '2024-04-30 00:01:09', '{bcrypt}$2a$10$BDcxgmL3WYk7G.QEDTqlBeSudNlV3KUU/V6iC.hKlAbGAC.jbX2fO', NULL, 'OAuth2.1认证', 'client_secret_basic', 'refresh_token,password,client_credentials,mail,urn:ietf:params:oauth:grant-type:device_code,authorization_code,mobile,urn:ietf:params:oauth:grant-type:jwt-bearer', 'http://127.0.0.1:8001,http://127.0.0.1:8000,https://vue.liuzx.org,https://liuzx.org.cn', 'http://127.0.0.1:8001,http://127.0.0.1:8000,https://vue.liuzx.org,https://liuzx.org.cn', 'password,mail,openid,mobile', '{"@class":"java.util.Collections$UnmodifiableMap","settings.client.require-proof-key":false,"settings.client.require-authorization-consent":true}', '{"@class":"java.util.Collections$UnmodifiableMap","settings.token.reuse-refresh-tokens":true,"settings.token.id-token-signature-algorithm":["org.springframework.security.oauth2.jose.jws.SignatureAlgorithm","RS256"],"settings.token.access-token-time-to-live":["java.time.Duration",3600.000000000],"settings.token.access-token-format":{"@class":"org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat","value":"self-contained"},"settings.token.refresh-token-time-to-live":["java.time.Duration",21600.000000000],"settings.token.authorization-code-time-to-live":["java.time.Duration",3600.000000000],"settings.token.Device-code-time-to-live":["java.time.Duration",3600.000000000]}');


-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
BEGIN;
INSERT INTO `sys_tenant`
	(`id`, `creator`, `editor`, `create_time` 	   	, `update_time`, `del_flag`, `version`, `tenant_id`, `name`	, `code`  , `status`, `source_id`, `package_id`)
VALUES
	(1	 , 1		, NULL	  , '2023-09-17 15:42:27', NULL		   , 0		  , 1		 , 1   		  , '云平台'	, 'cloud' , 0		, 1		   , 1);

COMMIT;

-- ----------------------------
-- Records of sys_source
-- ----------------------------
BEGIN;
INSERT INTO `sys_source`
	(`id`, `creator`, `editor`, `create_time`		   , `update_time`, `del_flag`, `version`, `tenant_id`, `name`, `driver_class_name`		   , `url`																																																		, `username` ,`password`)
VALUES (1   , 1		  , NULL    , '2024-05-15 14:42:36', NULL		  , 0        , 0        , 1		     , '云平台', 'com.mysql.cj.jdbc.Driver' , 'jdbc:mysql://mysql.liuzx.org:3306/lcloud_platform_2?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&useSSL=false', 'root'	 , '11111111');
COMMIT;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept`
	(`id`, `creator`, `editor`, `create_time`		 , `update_time`, `del_flag`, `version`, `tenant_id`, `pid`, `name`  , `path`, `sort`)
VALUES
	(1   , 1		, NULL    , '2024-05-15 14:42:36', NULL		  	, 0        , 0        , 1		   , 0    , '总部集团', '0,1', 0);
COMMIT;
-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
-- 初始化
INSERT INTO `sys_menu`
	(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`, `type`, `sort`, `path` , `component`, `query_param`, `is_frame`, `is_cache`, `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
	(1   , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 0    , '初始化', ''         , 'M'   , 1    , 'ca', ''  		  , ''           , 1		  , 0         , '0'      , '0'     , 'system', 0        , 0        , 1          , '初始化目录');

-- 系统管理 --2
INSERT INTO `sys_menu`
	(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`, `type`, `sort`, `path` , `component`, `query_param`, `is_frame`, `is_cache`, `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
	(2   , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 0    , '系统管理', ''         , 'M'   , 1    , 'system', ''  		  , ''           , 1		  , 0         , '0'      , '0'     , 'system', 0        , 0        , 1          , '系统管理目录');
-- 系统管理 -- 菜单管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`             , `component`		, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`      , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(20  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , '菜单管理' , 'menu'      , 'C'   , 1     , 'menu'			   , 'system/menu/index', ''           , 1		  , 0         , '0'      , '0'     , 'tree-table', 0        , 0        , 1          , '菜单管理菜单');
-- 系统管理 -- 菜单管理 -- 分页查询菜单列表
iNSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`          , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(201  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 20  , '分页查询菜单列表' , 'sys:menu:page'     , 'F'   , 1     , ''	, ''         , ''           , 1 		   , 0          , '0'      , '0'      , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 菜单管理 -- 保存菜单
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`	, `type`, `sort`, `path` , `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(202  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 20  , '保存菜单', 'sys:menu:save' , 'F'   , 1     , ''  , ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 菜单管理 -- 修改菜单
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`     , `type`, `sort`, `path` , `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(203  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 20  , '修改菜单', 'sys:menu:modify', 'F'   , 2     , ''	   , ''         , ''           , 1 	    	, 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 菜单管理 -- 删除菜单
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`     , `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(204  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 20  , '删除菜单', 'sys:menu:remove', 'F'   , 3     , ''	  , ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 菜单管理 -- 查询菜单树列表
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`         , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(205  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 20  , '查询菜单树列表' , 'sys:menu:list-tree' , 'F'   , 4     , ''   , ''         , ''           , 1 		   , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 菜单管理 -- 查询用户菜单树列表
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`         , `permission`        	   , `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(206  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 20  , '查询菜单树列表' , 'sys:menu:user-list-tree', 'F'   , 5     , ''   , ''         , ''           , 1 		, 0             , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 菜单管理 -- 导入菜单
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`     , `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(207  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 20  , '导入菜单' , 'sys:menu:import', 'F'   , 6     , ''	  , ''         , ''           , 1 	    , 0            , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 菜单管理 -- 导出菜单
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`     , `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(208  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 20  , '导出菜单', 'sys:menu:export', 'F'   , 7     , ''	  , ''         , ''           , 1		  , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');

-- -- 系统管理 -- 部门管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`             , `component`		, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(21  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , '部门管理' , 'dept'      , 'C'   , 2     , 'dept'			   , 'system/dept/index', ''           , 1			, 0			 , '0'      , '0'     , 'tree', 0        , 0        , 1          , '部门管理菜单');
-- -- 系统管理 -- 部门管理 -- 查询部门树列表
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`          , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(211  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 21  , '分页查询部门列表' , 'sys:dept:page'     , 'F'   , 1     , ''	, ''         , ''           , 1 		   , 0          , '0'      , '0'      , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 部门管理 -- 保存部门
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`	, `type`, `sort`, `path` , `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(212  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 21  , '保存部门', 'sys:dept:save' , 'F'   , 2     , ''  , ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 部门管理 -- 修改部门
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`		, `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(213  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 21  , '修改部门', 'sys:dept:modify'	, 'F'   , 3     , ''	, ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 部门管理 -- 删除部门
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`		, `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(214  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 21  , '删除部门', 'sys:dept:remove'	, 'F'   , 4     , ''	, ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');

-- -- 系统管理 -- 用户管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`, `component`			, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(22  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , '用户管理' , 'user'      , 'C'   , 3     , 'role', 'system/user/index'	, ''           , 1			, 0			 , '0'      , '0'     , 'user', 0		 , 0        , 1          , '用户管理菜单');
-- -- 系统管理 -- 用户管理 -- 查询用户列表
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`          , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(221  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 22  , '分页查询用户列表' , 'sys:user:page'     , 'F'   , 1     , ''	, ''         , ''           , 1 		   , 0          , '0'      , '0'      , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 用户管理 -- 保存用户
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`	, `type`, `sort`, `path` , `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(222  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 22  , '保存用户', 'sys:user:save' , 'F'   , 2     , ''  , ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 用户管理 -- 修改用户
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`		, `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(223  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 22  , '修改用户', 'sys:user:modify'	, 'F'   , 3     , ''	, ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 用户管理 -- 删除用户
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`		, `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(224  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 22  , '删除用户', 'sys:user:remove'	, 'F'   , 4     , ''	, ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');

-- -- 系统管理 -- 角色管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`, `component`			, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`	, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(23  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , '角色管理' , 'role'      , 'C'   , 4     , 'role', 'system/role/index'	, ''           , 1			, 0			 , '0'      , '0'     , 'peoples', 0       , 0        , 1          , '角色管理菜单');

-- -- 系统管理 -- 租户管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`		, `component`			, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(24  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , '租户管理' , 'tenant'      , 'C'   , 5     , 'tenant'	, 'system/tenant/index'	, ''           , 1			, 0			 , '0'      , '0'     , 'tenant', 0		 , 0        , 1          , '租户管理菜单');
-- -- 系统管理 -- 租户管理 -- 查询租户列表
iNSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`          , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(241  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 24  , '分页查询租户列表' , 'sys:tenant:page'   , 'F'   , 1     , ''	 , ''        , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 租户管理 -- 保存租户
iNSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(242  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 24  , '保存租户' , 'sys:tenant:save'   , 'F'   , 1     , ''	 , ''        , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 租户管理 -- 修改租户
iNSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(243  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 24  , '修改租户' , 'sys:tenant:modify' , 'F'   , 1     , ''	 , ''        , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 租户管理 -- 修改租户
iNSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(244  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 24  , '删除租户' , 'sys:tenant:remove' , 'F'   , 1     , ''	 , ''        , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- -- 系统管理 -- 数据源管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`, `component`				, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`		, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(25  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , '数据源管理' , 'source'	  , 'C'   , 6     , 'source', 'system/source/index'	, ''           , 1			, 0			 , '0'      , '0'     , 'list', 0		 , 0        , 1          , '数据源管理菜单');

-- -- 系统管理 -- OSS管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`, `component`			, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(26  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , 'OSS管理' , 'oss'        , 'C'   , 7     , 'oss', 'system/oss/index'	, ''           , 1			, 0			 , '0'      , '0'     , 'redis', 0		 , 0        , 1          , 'OSS管理菜单');

-- -- 系统管理 -- IP管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`	, `permission`, `type`, `sort`, `path`, `component`			, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(27  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , 'IP管理'	, 'ip'		  , 'C'   , 8     , 'ip'  , 'system/ip/index'	, ''           , 1			, 0			 , '0'      , '0'     , 'ip', 0		 , 0        , 1          , 'IP管理菜单');

-- -- 系统管理 -- 字典管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`	, `permission`, `type`, `sort`, `path`, `component`			, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(28  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , '字典管理'	, 'dict'		  , 'C'   , 9     , 'dict', 'system/dict/index'	, ''           , 1			, 0			 , '0'      , '0'     , 'dict', 0		 , 0        , 1          , '字典管理菜单');
-- 系统管理 -- 字典管理 -- 查询字典列表
iNSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`          , `permission`			, `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(281  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '分页查询字典列表' , 'sys:dict:page'	, 'F'   , 1     , ''	, ''         , ''           , 1 		   , 0          , '0'      , '0'      , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 字典管理 -- 保存字典
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`	, `type`, `sort`, `path` , `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(282  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '保存字典', 'sys:dict:save' , 'F'  , 1		, ''	 , ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 字典管理 -- 修改字典
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`     , `type`, `sort`, `path` , `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(283  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '修改字典', 'sys:dict:modify', 'F'   , 1     , ''	   , ''         , ''           , 1 	    	, 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 字典管理 -- 删除字典
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`			, `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(284  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '删除字典', 'sys:dict:remove'	, 'F'   , 1     , ''	  , ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 字典项管理 -- 分页查询字典项列表
iNSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`          , `permission`			, `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(285  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '分页查询字典项列表' , 'sys:dict-item:page'	, 'F'   , 1     , ''	, ''         , ''           , 1 		   , 0        , '0'      , '0'      , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 字典项管理 -- 保存字典项
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`	, `permission`			, `type`, `sort`, `path` , `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(286  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '保存字典项', 'sys:dict-item:save'	, 'F'   , 1     , ''	 , ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 字典项管理 -- 修改字典项
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`	, `permission`			, `type`, `sort`, `path` , `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(287  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '修改字典项', 'sys:dict-item:modify', 'F'   , 1     , ''	   , ''        , ''          , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 字典项管理 -- 删除字典项
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`			, `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(288  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '删除字典项', 'sys:dict-item:remove'	, 'F'   , 1     , ''	  , ''         , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');
-- 系统管理 -- 字典项管理 -- 字典类型查询字典项
INSERT INTO `sys_menu`
(`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`			, `permission`				, `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(289  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 28  , '字典类型查询字典项', 'sys:dict-item:type-items', 'F'	, 1     , ''	, ''         , ''           , 1			, 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');

-- -- 系统管理 -- 国际化消息管理
INSERT INTO `sys_menu`
(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`		, `permission`, `type`, `sort`, `path`, `component`					, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
(29 , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 2    , '国际化消息管理', 'i18n'	  , 'C'   , 10     , 'i18n', 'system/i18n-messages/index', ''           , 1			, 0			 , '0'      , '0'     , 'language', 0	 , 0        , 1          , '国际化消息管理菜单');


-- 日志管理 --3
INSERT INTO `sys_menu`
	(`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`, `type`, `sort`, `path` , `component`, `query_param`, `is_frame`, `is_cache`, `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
	(3   , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 0    , '日志管理', ''         , 'M'   , 1    , 'audit', ''  		  , ''           , 1		  , 0         , '0'      , '0'     , 'system', 0        , 0        , 1          , '日志管理目录');

-- -- 日志管理 -- 登录日志管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`		, `permission`, `type`, `sort`, `path`, `component`					, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (30 , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 3    , '登录日志管理', 'loginlog'	  , 'C'   , 30     , 'loginlog', 'system/loginlog/index', ''           , 1			, 0			 , '0'      , '0'     , 'loginlog', 0	 , 0        , 1          , '登录日志管理菜单');

-- -- 日志管理 -- 操作日志管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`		, `permission`, `type`, `sort`, `path`, `component`					, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (31 , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 3    , '操作日志管理', 'operlog'	  , 'C'   , 31     , 'operlog', 'system/operlog/index', ''           , 1			, 0			 , '0'      , '0'     , 'operlog', 0	 , 0        , 1          , '操作日志管理菜单');


COMMIT;

-- ----------------------------
-- Records of sys_i18n_menu
-- ----------------------------
BEGIN;

INSERT INTO sys_i18n_menu VALUES (1, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,   'menu.sys', '系统管理');
INSERT INTO sys_i18n_menu VALUES (2, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,   'menu.sys.log', '日志管理');
INSERT INTO sys_i18n_menu VALUES (3, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,   'menu.sys.log.login', '登录日志');
INSERT INTO sys_i18n_menu VALUES (4, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,   'menu.sys.log.notice', '通知日志');
INSERT INTO sys_i18n_menu VALUES (5, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.permission', '权限管理');
INSERT INTO sys_i18n_menu VALUES (6, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.permission.menu', '菜单');
INSERT INTO sys_i18n_menu VALUES (7, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.permission.dept', '部门');
INSERT INTO sys_i18n_menu VALUES (8, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.permission.role', '角色');
INSERT INTO sys_i18n_menu VALUES (9, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.permission.user', '用户');
INSERT INTO sys_i18n_menu VALUES (10, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,   'menu.iot.device.product', '产品');
INSERT INTO sys_i18n_menu VALUES (11, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.tenant', '租户管理');
INSERT INTO sys_i18n_menu VALUES (12, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.tenant.package', '套餐');
INSERT INTO sys_i18n_menu VALUES (13, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.tenant.tenant', '租户');
INSERT INTO sys_i18n_menu VALUES (14, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.base.dict', '数据字典');
INSERT INTO sys_i18n_menu VALUES (15, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.log.operate', '操作日志');
INSERT INTO sys_i18n_menu VALUES (16, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.base.i18n', '国际化');
INSERT INTO sys_i18n_menu VALUES (17, 1, 1, '2026-03-07 12:06:37', '2026-03-07 12:06:37', 0, 0, 0,  'menu.sys.config', '系统配置');

COMMIT;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `dept_id`, `password`                                                            , `super_admin`, `mail`                                        						   , `mobile`                  							   , `status`, `avatar`, `cert_sn`, `cert_pem`,`username_phrase`,`mail_phrase`,`mobile_phrase`, `username`)
VALUES
(1   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0         , 0        , 1          , 1        , '{bcrypt}$2a$10$DI0I83PtEiBmlPrAEN49jesNAoiI.pAtPGxqPvsB/N3x7OT4Wh5Sy', 1            , 'Ylh4QTF0YmdEWWJRh2xUL2ADuvSdlf7gLJTyjR0zFujLE06Htlzb4WJh+K9tuEuoooo=', 'Ylh4QTF0YmdEWWJR2jAZZDhR7brNzIiSHR1E9jPh2KldKbhoC83k', 0       , NULL    , NULL           , NULL      ,NULL             ,NULL         ,NULL           , 'Ylh4QTF0YmdEWWJRimFMPGaJmldyuWIb9BNmUN1ULMI7');

COMMIT;

-- ----------------------------
-- Records of sys_user_dept 用户部门
-- ----------------------------
BEGIN;
-- 用户管理 -- 管理员 -- 用户部门
INSERT INTO `sys_user_dept`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `user_id`, `dept_id`)
VALUES
    (1 , 1, NULL ,'2025-01-01 00:00:00',NULL, 0,0, 1 , 1, 1);

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;

INSERT INTO `sys_dict`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`  , `type`       , `status`, `remark`)
VALUES
(1   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '用户性别','sys_user_sex',  0     , '用户性别列表（0男 1女 2未知');

INSERT INTO `sys_dict`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`  , `type`        , `status`, `remark`)
VALUES
(2   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '显示状态','sys_visible_status',  0     , '显示状态列表（0显示 1隐藏）');

INSERT INTO `sys_dict`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`  , `type`        	   , `status`, `remark`)
VALUES
(3   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '系统开关','sys_normal_disable',  0     , '系统开关列表');

INSERT INTO `sys_dict`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`  , `type`      , `status`, `remark`)
VALUES
(4   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '系统是否','sys_yes_no',  0     , '系统是否列表');

INSERT INTO `sys_dict`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`  , `type`      	  , `status`, `remark`)
VALUES
(5   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '登录状态','sys_login_status',  0     , '登录状态列表');

INSERT INTO `sys_dict`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`  , `type`      	  , `status`, `remark`)
VALUES
(6   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '初始化状态','sys_init_status',  0     , '初始化状态列表');
COMMIT;

INSERT INTO `sys_dict`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`  , `type`      	  , `status`, `remark`)
VALUES
(7   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '通用状态','sys_common_status',  0     , '通用状态列表（0正常 1停用）');
COMMIT;



-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
(1   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '男'	   , '0'    , 1     , ''         , ''          , 'Y'         , 0       , '性别男' , 1);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
(2   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '女'	   , '1'    , 2     , ''         , ''          , 'N'         , 0       , '性别女' , 1);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
(3   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '未知'	   , '2'    , 3     , ''         , ''          , 'N'         , 0       , '性别未知', 1);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
(4   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '显示'	   , '0'    , 1     , ''         , ''          , 'Y'         , 0       , '显示菜单', 2);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
(5   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '隐藏'	   , '1'    , 2     , ''         , ''          , 'N'         , 0       , '隐藏菜单', 2);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
(6   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '正常'	   , '0'    , 1     , ''         , ''          , 'Y'         , 0       , '正常状态', 3);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
(7   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '停用'	   , '0'    , 2     , ''         , ''          , 'N'         , 0       , '停用状态', 3);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`  , `type_id`)
VALUES
(8   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '是'	   , 'true'    , 1     , ''         , ''          , 'Y'         , 0       , '系统默认是', 4);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`  , `type_id`)
VALUES
(9   , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '否'	   , 'false'    , 2     , ''         , ''          , 'N'         , 0       , '系统默认否', 4);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`  , `type_id`)
VALUES
(10  , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '成功'	   , 'Y'    , 1     , ''         , ''          , 'Y'         , 0       , '成功状态', 5);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`  , `type_id`)
VALUES
(11  , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '失败'	   , 'N'    , 2     , ''         , ''          , 'N'         , 0       , '失败状态', 5);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`  , `type_id`)
VALUES
(12  , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '未初始化'	   , '0'    , 2     , ''         , ''          , 'Y'         , 0       , '未初始化状态', 6);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`  , `type_id`)
VALUES
(13  , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '已初始化'	   , '-1'   , 1     , ''         , ''          , 'N'         , 0       , '已初始化状态', 6);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`  , `type_id`)
VALUES
(14  , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '正常'	   , '0'    , 1     , ''         , ''          , '0'         , 0       , '正常状态', 7);

INSERT INTO `sys_dict_item`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`  , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`  , `type_id`)
VALUES
(15  , 1		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 1          , '停用'	   , '1'    , 2     , ''         , ''          , '1'         , 0       , '停用状态', 7);

COMMIT;



SET FOREIGN_KEY_CHECKS = 1;
