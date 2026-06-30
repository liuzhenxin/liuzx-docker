/*
 LiuZX NAS 数据库初始化数据脚本

 说明: 初始化 NAS 租户、部门、用户、角色、菜单和权限数据
 执行方式:
 mysql -u root -p lcloud_platform_4 < 02_nas_4_platform_data.sql

 注意:
 1. 此脚本写入平台库 lcloud_platform_4，不写入 NAS 业务库
 2. 需要先执行 liuzx-admin 的数据库脚本
 3. 租户ID为10，用于 NAS 文件迁移系统
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE lcloud_platform_4;

-- ----------------------------
-- 清理旧数据 (租户ID: 10)
-- ----------------------------
DELETE FROM `sys_user_role` WHERE `tenant_id` = 10;
DELETE FROM `sys_role_dept` WHERE `tenant_id` = 10;
DELETE FROM `sys_role_menu` WHERE `tenant_id` = 10;
DELETE FROM `sys_role` WHERE `tenant_id` = 10;
DELETE FROM `sys_user_dept` WHERE `tenant_id` = 10;
DELETE FROM `sys_user` WHERE `tenant_id` = 10;
DELETE FROM `sys_menu` WHERE `tenant_id` = 10;
DELETE FROM `sys_dept` WHERE `tenant_id` = 10;
DELETE FROM `sys_tenant` WHERE `id` = 10;

-- ----------------------------
-- 1. sys_tenant (租户)
-- ----------------------------
BEGIN;
INSERT INTO `sys_tenant`
  (`id`, `creator`, `editor`, `create_time`, `update_time`, `del_flag`, `version`, `tenant_id`, `name`, `code`, `status`, `source_id`, `package_id`)
VALUES
  (10, 101, NULL, '2024-05-15 14:42:36', NULL, 0, 1, 10, '文件迁移系统', 'nas', 0, 10, 10);
COMMIT;

-- ----------------------------
-- 2. sys_dept (部门)
-- ----------------------------
BEGIN;
REPLACE INTO sys_dept (id, creator, create_time, del_flag, version, tenant_id, pid, name, path, sort)
VALUES (1001, 101, NOW(), 0, 0, 10, 0, 'NAS管理部', '0,1001', 0);
COMMIT;

-- ----------------------------
-- 3. sys_menu (菜单与权限)
-- ----------------------------
BEGIN;
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, path, component, visible, status, icon, tenant_id)
VALUES (10000, 0, 'NAS业务', '', 'M', 1, 'nas', '', '0', '0', 'folder', 10);

REPLACE INTO sys_menu (id, pid, name, permission, type, sort, path, component, visible, status, icon, tenant_id)
VALUES (10010, 10000, '迁移任务', 'nas:migration', 'C', 1, 'migration-task', 'nas/migration-task/index', '0', '0', 'guide', 10);

REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10111, 10010, '任务查询', 'nas:migration:list', 'F', 1, 10);
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10112, 10010, '任务新增', 'nas:migration:add', 'F', 2, 10);
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10113, 10010, '任务修改', 'nas:migration:edit', 'F', 3, 10);
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10114, 10010, '任务删除', 'nas:migration:remove', 'F', 4, 10);
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10115, 10010, '启动任务', 'nas:migration:start', 'F', 5, 10);
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10116, 10010, '停止任务', 'nas:migration:stop', 'F', 6, 10);
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10117, 10010, '失败记录查询', 'nas:migration:failure:list', 'F', 7, 10);
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10118, 10010, '失败记录重迁', 'nas:migration:failure:retry', 'F', 8, 10);
REPLACE INTO sys_menu (id, pid, name, permission, type, sort, tenant_id) VALUES (10119, 10010, '任务重新迁移', 'nas:migration:remigrate', 'F', 9, 10);
COMMIT;

-- ----------------------------
-- 4. sys_role (角色)
-- ----------------------------
BEGIN;
REPLACE INTO sys_role (id, name, sort, data_scope, tenant_id)
VALUES (1001, 'NAS管理员', 1, 'all', 10);
COMMIT;

-- ----------------------------
-- 5. sys_role_menu (角色权限映射)
-- ----------------------------
BEGIN;
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10000, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10010, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10111, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10112, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10113, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10114, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10115, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10116, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10117, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10118, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10119, 10);
COMMIT;

-- ----------------------------
-- 6. sys_user (管理员用户)
-- admin / Qwe123!!
-- ----------------------------
BEGIN;
REPLACE INTO sys_user (id, creator, create_time, del_flag, version, tenant_id, dept_id, username, password, super_admin, status)
VALUES (1001, 101, NOW(), 0, 0, 10, 1001, 'Ylh4QTF0YmdEWWJRimFMPGaJmldyuWIb9BNmUN1ULMI7', '{bcrypt}$2a$10$oZfSMv8EDmlWa0szVQ6B3uTbcp6pEmcCFFFDqzfUp7ghB8UqBD7Om', 0, 0);
COMMIT;

-- ----------------------------
-- 7. sys_user_role (用户角色关联)
-- ----------------------------
BEGIN;
REPLACE INTO sys_user_role (user_id, role_id, tenant_id)
VALUES (1001, 1001, 10);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
