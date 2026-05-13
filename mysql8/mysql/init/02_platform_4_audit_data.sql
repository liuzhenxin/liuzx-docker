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
-- Records of sys_menu
-- ----------------------------
BEGIN;
-- 审计管理 --10000
INSERT INTO `sys_menu`
    (`id`       , `creator`   , `create_time`                   , `editor`, `update_time`, `pid`, `name`  , `permission`, `type`, `sort`, `path` , `component`, `query_param`, `is_frame`, `is_cache`, `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (10000   , 201 , '2025-01-01 00:00:00',NULL    , NULL         , 0    , '审计管理', ''         , 'M'   , 10000  , 'audit', '' 		  , ''           , 1		  , 0         , '0'      , '0'     , 'audit', 0        , 0        , 1          , '审计管理目录');
COMMIT;
-- 审计管理 -- 登录日志
INSERT INTO `sys_menu`
    (`id`      , `creator`   , `create_time`        , `editor`, `update_time`, `pid`, `name`    , `permission`, `type`, `sort`, `path`  , `component`  		 , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (10010  , 201 , '2025-01-01 00:00:00', NULL    , NULL         , 10000    , '登录日志' , 'sys:login-log'      , 'C'   , 1     , 'monitor-logininfor' , 'monitor/logininfor/index', ''           , 1		  , 0         , '0'      , '0'     , 'log'  , 0        , 0        , 1          , '登录日志菜单');
-- -- 审计管理 -- 登录日志 -- 查询登录日志列表
iNSERT INTO `sys_menu`
    (`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`          , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (10011  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 10010  , '分页查询登录日志列表' , 'sys:login-log:page'   , 'F'   , 1     , ''	 , ''        , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');

-- 审计管理 -- 操作日志
INSERT INTO `sys_menu`
    (`id`   , `creator` , `create_time`        , `editor`, `update_time`, `pid`, `name`   , `permission`, `type`, `sort`, `path`    , `component`		   , `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon` , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (10020  , 201		    , '2025-01-01 00:00:00', NULL    , NULL         , 10000, '操作日志' , 'monitor:operlog'   , 'C'   , 2     , 'monitor-operlog' , 'monitor/operlog/index', ''           , 1		    , 0         , '0'      , '0'     , 'log'  , 0        , 0        , 1          , '操作日志菜单');
-- -- 审计管理 -- 操作日志 -- 查询审计日志列表
iNSERT INTO `sys_menu`
    (`id` , `creator`, `create_time`        , `editor`, `update_time`, `pid`, `name`          , `permission`        , `type`, `sort`, `path`, `component`, `query_param`, `is_frame` , `is_cache` , `visible`, `status`, `icon`  , `del_flag`, `version`, `tenant_id`, `remark`)
VALUES
    (10021  , 1		 , '2025-01-01 00:00:00', NULL    , NULL         , 10020  , '分页查询审计日志列表' , 'sys:operate-log:page'   , 'F'   , 1     , ''	 , ''        , ''           , 1 	      , 0          , '0'      , '0'     , NULL    , 0        , 0        , 1          , '');


COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
