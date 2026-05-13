/*
 LiuZX NAS 数据库初始化数据脚本
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE lcloud_platform_4;

-- 1. 租户初始化 (ID=10, 平台版本=4)
BEGIN;
REPLACE INTO sys_tenant (id, creator, create_time, del_flag, version, tenant_id, name, code, status, source_id, package_id)
VALUES (10, 101, NOW(), 0, 1, 10, '文件迁移系统', 'nas', -1, 10, 10);
COMMIT;

-- 2. 部门初始化
BEGIN;
REPLACE INTO sys_dept (id, creator, create_time, del_flag, version, tenant_id, pid, name, path, sort)
VALUES (1001, 101, NOW(), 0, 0, 10, 0, 'NAS管理部', '0,1001', 0);
COMMIT;

-- 3. 菜单与权限初始化
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
COMMIT;

-- 4. 角色初始化
BEGIN;
REPLACE INTO sys_role (id, name, sort, data_scope, tenant_id)
VALUES (1001, 'NAS管理员', 1, 'all', 10);
COMMIT;

-- 5. 权限绑定
BEGIN;
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10000, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10010, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10111, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10112, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10113, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10114, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10115, 10);
REPLACE INTO sys_role_menu (role_id, menu_id, tenant_id) VALUES (1001, 10116, 10);
COMMIT;

-- 6. 管理员用户初始化 (admin / Qwe123!!)
BEGIN;
REPLACE INTO sys_user (id, creator, create_time, del_flag, version, tenant_id, dept_id, username, password, super_admin, status)
VALUES (1001, 101, NOW(), 0, 0, 10, 1001, 'Ylh4QTF0YmdEWWJRimFMPGaJmldyuWIb9BNmUN1ULMI7', '{bcrypt}$2a$10$oZfSMv8EDmlWa0szVQ6B3uTbcp6pEmcCFFFDqzfUp7ghB8UqBD7Om', 0, 0);
COMMIT;

-- 7. 用户角色关联
BEGIN;
REPLACE INTO sys_user_role (user_id, role_id, tenant_id)
VALUES (1001, 1001, 10);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
