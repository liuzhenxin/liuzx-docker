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

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
-- ----------------------------
-- Records of sys_tenant 租户ID：2
-- ----------------------------
BEGIN;
INSERT INTO `sys_tenant`
    (`id`, `creator`, `editor`, `create_time` 	   	, `update_time`, `del_flag`, `version`, `tenant_id`, `name`	, `code`  , `status`, `source_id`, `package_id`)
VALUES
    (2	 , 201		, NULL	  , '2024-05-15 14:42:36', NULL		   , 0		  , 1		 , 2   		  , '授权系统'	, 'license'   , 0		, 2		   , 1);
COMMIT;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept`
    (`id`, `creator`, `editor`, `create_time`		 , `update_time`, `del_flag`, `version`, `tenant_id`, `pid`, `name`  , `path`, `sort`)
VALUES
    (201 , 201		, NULL    , '2024-05-15 14:42:36', NULL		  	, 0        , 0        , 2		   , 0    , '总部集团', '0,201', 0);
COMMIT;

-- ----------------------------
-- Records of sys_menu HSM 菜单开始编号：1000
-- ----------------------------
BEGIN;
-- 初始化 -- 安装向导
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`   , `component`			  , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`      , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1000 , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 1    , '安装向导' , 'setup'      , 'C'   , 1     , 'setup'  , 'system/init/hsm/index', ''           , 1  		   , 0         , '0'      , '0'     , 'tree-table', 0        , 0        , 1          , '安装向导菜单');
COMMIT;

-- 系统权限
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`, `type`, `sort`, `path`    , `component`, `query_param`, `is_frame`, `is_cache`, `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1030  , 201	 , '2025-01-01 00:00:00', NULL    , NULL         , 0    , '系统权限', ''          , 'M'   , 1030     , 'hsm-role', ''  		  , ''           , 1		  , 0         , '0'      , '0'     , 'tool', 0        , 0        , 1          , '密钥管理目录');
-- 系统权限 -- 认证信息
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission` , `type`, `sort`, `path`       , `component`	        , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1031, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1030 , '登录信息' , 'hsm:auth', 'C'   , 1     , 'hsm-auth' , 'hsm/auth/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , '菜单管理菜单');
-- 系统权限 -- 管理员管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission` , `type`, `sort`, `path`       , `component`	        , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1032, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1030 , '管理员管理' , 'hsm:admin', 'C'   , 2     , 'hsm-admin' , 'hsm/admin/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , '菜单管理菜单');
-- 系统权限 -- 操作员管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission` , `type`, `sort`, `path`       , `component`	        , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1033, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1030 , '操作员管理' , 'hsm:operator', 'C'   , 3     , 'hsm-operator' , 'hsm/operator/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , '菜单管理菜单');
-- 系统权限 -- 审计员管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission` , `type`, `sort`, `path`       , `component`	        , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1034, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1030 , '审计员管理' , 'hsm:audit', 'C'   , 4     , 'hsm-audit' , 'hsm/audit/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , '菜单管理菜单');


-- 密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`, `type`, `sort`, `path`    , `component`, `query_param`, `is_frame`, `is_cache`, `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1040  , 201	 , '2025-01-01 00:00:00', NULL    , NULL         , 0    , '密钥管理', ''          , 'M'   , 1040     , 'key', ''  		  , ''           , 1		  , 0         , '0'      , '0'     , 'key', 0        , 0        , 1          , '密钥管理目录');
-- 密钥管理 -- 主密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission` , `type`, `sort`, `path`           , `component`	         , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1041, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , '主密钥', 'key:master' , 'C'   , 1     , 'hsm-key-master' , 'hsm/key/master/index' , ''           , 1		    , 0         , '0'      , '1'     ,  ''     , 0       , 0        , 1          , '主密钥管理菜单');
-- 密钥管理 -- 对称密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`      , `permission`    , `type`, `sort`, `path`              , `component`	              , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1042, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , '对称密钥', 'key:symmetric' , 'C'   , 2     , 'hsm-key-symmetric' , 'hsm/key/symmetric/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , '对称密钥管理菜单');
-- 密钥管理 -- RSA密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`      , `permission` , `type`, `sort`, `path`     , `component`	       , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1043, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , 'RSA密钥', 'key:rsa'   , 'C'   , 3     , 'hsm-key-rsa' , 'hsm/key/RSA/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , 'RSA密钥管理菜单');
-- 密钥管理 -- SM2密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`      , `permission` , `type`, `sort`, `path`     , `component`	       , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1044, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , 'SM2密钥', 'key:sm2'   , 'C'   , 4     , 'hsm-key-sm2' , 'hsm/key/SM2/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , 'SM2密钥管理菜单');
-- 密钥管理 -- ECC密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`      , `permission` , `type`, `sort`, `path`     , `component`	       , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1045, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , 'ECC密钥', 'key:ecc'   , 'C'   , 5     , 'hsm-key-ecc' , 'hsm/key/ECC/index' , ''           , 1		    , 0         , '0'      , '1'     ,  ''     , 0       , 0        , 1          , 'ECC密钥管理菜单');
-- 密钥管理 -- DSA密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`      , `permission` , `type`, `sort`, `path`     , `component`	       , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1046, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , 'DSA密钥', 'key:dsa'   , 'C'   , 6     , 'hsm-key-dsa' , 'hsm/key/DSA/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , 'DSA密钥管理菜单');
-- 密钥管理 -- EcDSA密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`        , `permission` , `type`, `sort`, `path`     , `component`	       , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1047, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , 'EcDSA密钥', 'key:EcDSA'   , 'C'   , 7     , 'key-EcDSA' , 'hsm/key/EcDSA/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , 'EcDSA密钥管理菜单');
-- 密钥管理 -- EdDSA密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`        , `permission` , `type`, `sort`, `path`     , `component`	       , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1048, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , 'EdDSA密钥', 'key:EdDSA'   , 'C'   , 8     , 'key-EdDSA' , 'hsm/key/EdDSA/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , 'EdDSA密钥管理菜单');
-- 密钥管理 -- SM9主密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`       , `permission`      , `type`, `sort`, `path`          , `component`	       , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1049, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , 'SM9主密钥', 'key:sm9master'   , 'C'   , 9     , 'key-sm9master' , 'hsm/key/sm9/master/index' , ''           , 1		    , 0         , '0'      , '1'     ,  ''     , 0       , 0        , 1          , 'EdDSA密钥管理菜单');
-- 密钥管理 -- SM9用户密钥管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`        , `permission`     , `type`, `sort`, `path`       , `component`    	         , `query_param` , `is_frame`  , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1050, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , 'SM9用户密钥', 'key:sm9user'   , 'C'   , 10     , 'key-sm9user' , 'hsm/key/sm9/user/index' , ''           , 1		    , 0         , '0'      , '1'     ,  ''     , 0       , 0        , 1          , 'EdDSA密钥管理菜单');
-- 密钥管理 -- 密钥备份
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission` , `type`, `sort`, `path`       , `component`	          , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1051, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , '密钥备份' , 'key:backup' , 'C'   , 11     , 'key-backup' , 'hsm/key/backup/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , 'EdDSA密钥管理菜单');
-- 密钥管理 -- 密钥恢复
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`       , `permission` , `type`, `sort`, `path`    , `component`	             , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1052, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1040 , '密钥恢复', 'key:recovery'   , 'C'   , 12     , 'key-recovery' , 'hsm/key/recovery/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , 'EdDSA密钥管理菜单');

-- 服务管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`, `type`, `sort`, `path` , `component`, `query_param`, `is_frame`, `is_cache`, `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1060  , 201	 , '2025-01-01 00:00:00', NULL    , NULL         , 0    , '服务管理', ''          , 'M'   , 1050 , 'process', '' 		  , ''           , 1		  , 0         , '0'      , '0'     , 'process', 0        , 0        , 1          , '服务管理目录');
-- 服务管理 -- 服务状态
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`     , `type`, `sort`, `path`               , `component`	         , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1061, 201		 , '2025-01-01 00:00:00', NULL    , NULL        , 1060 , '服务状态', 'process:status' , 'C'   , 1     , 'hsm-process-status' , 'hsm/process/status/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , '服务状态菜单');
-- 服务管理 -- 服务配置
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`  , `permission`     , `type`, `sort`, `path`               , `component`	         , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1062, 201		 , '2025-01-01 00:00:00', NULL    , NULL        , 1060 , '服务配置', 'process:config' , 'C'   , 2     , 'hsm-process-config' , 'hsm/process/config/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , '服务状态菜单');
-- 服务管理 -- 白名单管理
INSERT INTO `sys_menu`
    (`id`, `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`        , `type`, `sort`, `path`               , `component`	         , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (1063, 201		 , '2025-01-01 00:00:00', NULL    , NULL         , 1060 , '白名单管理', 'process:whitelist' , 'C'   , 3     , 'hsm-process-whitelist' , 'hsm/process/whitelist/index' , ''           , 1		    , 0         , '0'      , '0'     ,  ''     , 0       , 0        , 1          , '服务状态菜单');

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `password`                                                            , `super_admin`, `mail`                                        						   , `mobile`                  							   , `status`, `avatar`, `serial_number`, `cert_pem`,`username_phrase`,`mail_phrase`,`mobile_phrase`, `username`)
VALUES
    (201 , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , '{bcrypt}$2a$10$Z42xytAkdV34Ta5YM0D9EuB9y1YrfYhDeJa38BMtSA0PaoGxGPB/q', 0            , 'Ylh4QTF0YmdEWWJRh2xUL2ADuvSdlf7gLJTyjR0zFujLE06Htlzb4WJh+K9tuEuoooo=', 'Ylh4QTF0YmdEWWJR2jAZZDhR7brNzIiSHR1E9jPh2KldKbhoC83k', 0       , NULL    , NULL           , NULL      ,NULL             ,NULL         ,NULL           , 'Ylh4QTF0YmdEWWJRimFMPGaJmldyuWIb9BNmUN1ULMI7');
COMMIT;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;

INSERT INTO `sys_role`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`	 , `sort`, `data_scope`)
VALUES
    (201 , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , '密码机管理员', 1            , 'no');

COMMIT;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
-- HSM管理员角色菜单
-- 初始化
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (2   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1);

-- -- 系统管理 -- 字典管理
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (28   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 28);
-- 系统管理 -- 字典管理 -- 查询字典列表
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (281   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 281);
-- 系统管理 -- 字典管理 -- 保存字典
INSERT INTO `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (282   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 282);
-- 系统管理 -- 字典管理 -- 修改字典
INSERT INTO `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (283   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 283);
-- 系统管理 -- 字典管理 -- 删除字典
INSERT INTO `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (284   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 284);
-- 系统管理 -- 字典项管理 -- 分页查询字典项列表
INSERT INTO `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (285   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 285);
-- 系统管理 -- 字典项管理 -- 保存字典项
INSERT INTO `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (286   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 286);
-- 系统管理 -- 字典项管理 -- 修改字典项
INSERT INTO `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (287   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 287);
-- 系统管理 -- 字典项管理 -- 删除字典项
INSERT INTO `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (288   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 288);
-- 系统管理 -- 字典项管理 -- 字典类型查询字典项
INSERT INTO `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (289   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 289);
-- 初始化 -- HSM安装向导
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1000   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1000);
-- -- 系统管理 -- 租户管理 -- 修改租户
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1001   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 243);
-- -- 系统管理 -- 用户管理 -- 修改用户
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1002   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 223);
-- 设备管理
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1010   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1010);
-- 设备管理 -- 设备信息
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1011   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1011);
-- 设备管理 -- 设备服务
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1012   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1012);
-- 设备管理 -- 设备自检
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1013   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1013);
-- 系统配置
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1020   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1020);
-- 系统配置 -- 系统时间
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1021   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1021);
-- 系统配置 -- 网络配置
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1022   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1022);
-- 系统权限
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1030   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1030);
-- 系统权限 -- 认证信息
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1031   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1031);
-- 系统权限 -- 管理员管理
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1032   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1032);
-- 系统权限 -- 操作员管理
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1033   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1033);
-- 系统权限 -- 审计员管理
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1034   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1034);
-- 密钥管理
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1040   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1040);
-- 密钥管理 -- 主密钥管理
INSERT INTO `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
VALUES
    (1041   , 201	 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 1041);
-- 密钥管理 -- 对称密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1042   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1042);
-- 密钥管理 -- RSA密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1043   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1043);
-- 密钥管理 -- SM2密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1044   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1044);
-- 密钥管理 -- ECC密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1045   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1045);
-- 密钥管理 -- DSA密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1046   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1046);
-- 密钥管理 -- EcDSA密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1047   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1047);
-- 密钥管理 -- EdDSA密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1048   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1048);
-- 密钥管理 -- SM9主密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1049   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1049);
-- 密钥管理 -- SM9用户密钥管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1050   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1050);
-- 密钥管理 -- 密钥备份
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1051   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1051);
-- 密钥管理 -- 密钥恢复
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1052   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1052);

-- 服务管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1060   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1060);
COMMIT;
-- 服务管理-- 服务状态
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1061   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1061);
COMMIT;
-- 服务管理-- 服务配置
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1062   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1062);
COMMIT;
-- 服务管理-- 白名单管理
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1063   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1063);

-- 网络管理
insert into `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1080   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1080);
-- 网络管理 -- 配置网络
insert into `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1081   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1081);
-- 网络管理 -- 网络诊断
insert into `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1082   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1082);
-- 网络管理 -- 时间源
insert into `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (1083   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 1083);

-- 审计管理
insert into `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (10000   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 10000);
-- 审计管理 -- 登录日志
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (10010   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 10010);
-- -- 审计管理 -- 登录日志 -- 查询登录日志列表
insert into `sys_role_menu`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (10011   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 10011);

-- 审计管理 -- 操作日志
insert into `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (10020   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 10020);
-- -- 审计管理 -- 操作日志 -- 查询操作日志列表
insert into `sys_role_menu`
(`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
values
    (10021   , 201	 , null    , '2025-01-01 00:00:00', null         , 0        , 0        , 2          , 201		   , 10021);


COMMIT;
-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;

INSERT INTO `sys_role_dept`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `dept_id`)
VALUES
    (1   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201		   , 201);

COMMIT;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;

INSERT INTO `sys_user_role`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `user_id`, `role_id`)
VALUES
    (1   , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 201	  ,201);

COMMIT;


-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;

INSERT INTO `sys_dict`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `name`  , `type`       , `status`, `remark`)
VALUES
    (201 , 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , '密钥类型','hsm_key_type',  0     , '用户性别列表');

COMMIT;


-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2011, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'RSA加密密钥'	   , '0'    , 1     , ''         , ''          , 'Y'         , 0       , 'RSA加密密钥' , 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2012, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'RSA签名密钥'	   , '1'    , 2     , ''         , ''          , 'N'         , 0       , 'RSA签名密钥' , 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2013, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'SM2加密密钥'	   , '2'    , 3     , ''         , ''          , 'N'         , 0       , 'SM2加密密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2014, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'SM2加密密钥'	   , '3'    , 4     , ''         , ''          , 'N'         , 0       , 'SM2加密密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2015, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'SM9加密主密钥'	   , '4'    , 5     , ''         , ''          , 'N'         , 0       , 'SM9加密主密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2016, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'SM9签名主密钥'	   , '5'    , 6     , ''         , ''          , 'N'         , 0       , 'SM9签名主密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2017, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'DSA密钥'         ,'6'    , 7     , ''         , ''          , 'N'         , 0       , 'DSA密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2018, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'ECDSA密钥'	   , '7'    , 8     , ''         , ''          , 'N'         , 0       , 'ECDSA密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2019, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'EDDSA密钥'	   , '8'    , 9     , ''         , ''          , 'N'         , 0       , 'EDDSA密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2020, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , '对称密钥'	   , '9'    , 10     , ''         , ''          , 'N'         , 0       , '对称密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2021, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'SM9加密用户密钥'	   , '10'    , 11     , ''         , ''          , 'N'         , 0       , 'SM9加密用户密钥', 201);

INSERT INTO `sys_dict_item`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `label`          , `value`, `sort`, `css_class`, `list_class`, `is_default`, `status`, `remark`, `type_id`)
VALUES
    (2022, 201		 , NULL    , '2025-01-01 00:00:00', NULL         , 0        , 0        , 2          , 'SM9签名用户密钥'	   , '11'    , 12     , ''         , ''          , 'N'         , 0       , 'SM9签名用户密钥', 201);

COMMIT;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;
INSERT INTO `sys_config`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `k`, `v`, `enabled`)
VALUES
    (21,1,NULL,'2025-01-01 00:00:00',NULL         ,0        ,0        ,1          ,'ntp_server_flag'	   ,'false'	   ,1	   );

INSERT INTO `sys_config`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `k`, `v`, `enabled`)
VALUES
    (22,1,NULL,'2025-01-01 00:00:00',NULL         ,0        ,0        ,1          ,'ntp_server_master'	   ,''	   ,1	   );

INSERT INTO `sys_config`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `k`, `v`, `enabled`)
VALUES
    (23,1,NULL,'2025-01-01 00:00:00',NULL         ,0        ,0        ,1          ,'ntp_server_slave'	   ,''	   ,1	   );

INSERT INTO `sys_config`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `k`, `v`, `enabled`)
VALUES
    (24,1,NULL,'2025-01-01 00:00:00',NULL         ,0        ,0        ,1          ,'ntp_server_port'	   ,''	   ,1	   );

INSERT INTO `sys_config`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `k`, `v`, `enabled`)
VALUES
    (25,1,NULL,'2025-01-01 00:00:00',NULL         ,0        ,0        ,1          ,'sync_ntp_time_cron'	   ,''	   ,1	   );

INSERT INTO `sys_config`
    (`id`, `creator` , `editor`, `create_time`        , `update_time`, `del_flag`, `version`, `tenant_id`, `k`, `v`, `enabled`)
VALUES
    (26,1,NULL,'2025-01-01 00:00:00',NULL         ,0        ,0        ,1          ,'shamir_secret_sharing'	   ,'2/3'	   ,1	   );
COMMIT;

-- ----------------------------
-- License authorization center permissions
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu`
    (`id`, `creator`, `editor`, `create_time`, `update_time`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (2000, 201, NULL, '2025-01-01 00:00:00', NULL, 0, 'License授权', '', 'M', 2000, 'license', '', '', 1, 0, '0', '0', 'license', 0, 0, 2, 'License授权目录'),
    (2001, 201, NULL, '2025-01-01 00:00:00', NULL, 2000, 'License授权管理', 'license:license', 'C', 1, 'admin', 'license/admin/index', '', 1, 0, '0', '0', '', 0, 0, 2, 'License授权管理菜单'),
    (2002, 201, NULL, '2025-01-01 00:00:00', NULL, 2001, '签发License', 'license:license:issue', 'F', 1, '', '', '', 1, 0, '0', '0', '', 0, 0, 2, '签发License'),
    (2003, 201, NULL, '2025-01-01 00:00:00', NULL, 2001, '删除License', 'license:license:remove', 'F', 2, '', '', '', 1, 0, '0', '0', '', 0, 0, 2, '删除License'),
    (2004, 201, NULL, '2025-01-01 00:00:00', NULL, 2001, '下载License', 'license:license:download', 'F', 3, '', '', '', 1, 0, '0', '0', '', 0, 0, 2, '下载License'),
    (2005, 201, NULL, '2025-01-01 00:00:00', NULL, 2001, '查询License', 'license:license:page', 'F', 4, '', '', '', 1, 0, '0', '0', '', 0, 0, 2, '分页查询License'),
    (2006, 201, NULL, '2025-01-01 00:00:00', NULL, 2001, '查看License', 'license:license:detail', 'F', 5, '', '', '', 1, 0, '0', '0', '', 0, 0, 2, '查看License详情'),
    (2007, 201, NULL, '2025-01-01 00:00:00', NULL, 2001, '校验License', 'license:license:verify', 'F', 6, '', '', '', 1, 0, '0', '0', '', 0, 0, 2, '校验License'),
    (2008, 201, NULL, '2025-01-01 00:00:00', NULL, 2001, '吊销License', 'license:license:revoke', 'F', 7, '', '', '', 1, 0, '0', '0', '', 0, 0, 2, '吊销License')
ON DUPLICATE KEY UPDATE
    editor = VALUES(editor),
    update_time = NOW(),
    name = VALUES(name),
    permission = VALUES(permission),
    type = VALUES(type),
    sort = VALUES(sort),
    path = VALUES(path),
    component = VALUES(component),
    remark = VALUES(remark);

INSERT INTO `sys_role_menu`
    (`creator`, `editor`, `create_time`, `update_time`, `del_flag`, `version`, `tenant_id`, `role_id`, `menu_id`)
SELECT 201, NULL, '2025-01-01 00:00:00', NULL, 0, 0, 2, 201, m.id
FROM `sys_menu` m
WHERE m.id BETWEEN 2000 AND 2008
  AND NOT EXISTS (
      SELECT 1
      FROM `sys_role_menu` rm
      WHERE rm.role_id = 201
        AND rm.menu_id = m.id
        AND rm.del_flag = 0
  );
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
