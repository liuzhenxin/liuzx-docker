/*
 LiuZX CA 数据库初始化数据脚本

 版本: 4.1.5
 日期: 2026-04-30
 说明: 全面整理 ID 码段，补全系统字段，标准化权限标识符

 执行方式:
 docker exec -i mysql mysql -uroot -p11111111 lcloud_platform_4 < 03_init_data.sql
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE lcloud_platform_4;

-- ----------------------------
-- 清理旧数据 (租户ID: 4)
-- ----------------------------
DELETE FROM `sys_user_role` WHERE `tenant_id` = 4;
DELETE FROM `sys_role_dept` WHERE `tenant_id` = 4;
DELETE FROM `sys_role_menu` WHERE `tenant_id` = 4;
DELETE FROM `sys_role` WHERE `tenant_id` = 4;
DELETE FROM `sys_user_dept` WHERE `tenant_id` = 4;
DELETE FROM `sys_user` WHERE `tenant_id` = 4;
DELETE FROM `sys_menu` WHERE `tenant_id` = 4;
DELETE FROM `sys_dept` WHERE `tenant_id` = 4;
DELETE FROM `sys_tenant` WHERE `id` = 4;

-- ----------------------------
-- 1. sys_tenant (租户)
-- ----------------------------
INSERT INTO `sys_tenant`
  (`id`, `creator`, `editor`, `create_time`, `update_time`, `del_flag`, `version`, `tenant_id`, `name`, `code`, `status`, `source_id`, `package_id`)
VALUES
  (4, 401, NULL, '2024-05-15 14:42:36', NULL, 0, 0, 4, '证书认证系统', 'ca', 0, 4, 4);

-- ----------------------------
-- 2. sys_dept (部门)
-- ----------------------------
INSERT INTO `sys_dept` (`id`, `pid`, `name`, `path`, `sort`, `tenant_id`)
VALUES (401, 0, '总部', '0,401', 0, 4);

-- ----------------------------
-- 3. sys_menu (菜单及按钮)
-- 字段顺序: id, pid, name, permission, type, sort, path, component, is_frame, is_cache, visible, status, icon, tenant_id, remark
-- ID 码段:
-- 4000      安装向导
-- 4010-4019 安全管理菜单
-- 4020-4029 管理员管理菜单
-- 4030-4039 审计员管理菜单
-- 4040-4049 业务管理菜单
-- 4050-4059 审计日志菜单
-- 4111-4189 安全管理按钮
-- 4201-4239 业务管理按钮
-- ----------------------------

-- [4000] 安装向导
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4000, 1, '安装向导', 'setup', 'C', 1, 'setup', 'ca/init/index', 1, 0, '0', '0', 'guide', 4, '安装向导');

-- [4010] 安全管理 (目录)
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4010, 0, '安全管理', '', 'M', 3010, 'ca-security', '', 1, 0, '0', '0', 'tool', 4, '安全管理目录');

-- [4011] 根证书管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4011, 4010, '根证书管理', 'ca:root', 'C', 1, 'ca-root-cert', 'ca/root/index', 1, 0, '0', '0', 'key', 4, '根证书管理');
-- 按钮: 4111-4129
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES 
(4111, 4011, '分页查询', 'ca:root:page', 'F', 1, 4),
(4112, 4011, '列表查询', 'ca:root:list', 'F', 2, 4),
(4113, 4011, '查看详情', 'ca:root:detail', 'F', 3, 4),
(4114, 4011, '新增根CA', 'ca:root:save', 'F', 4, 4),
(4115, 4011, '修改根CA', 'ca:root:modify', 'F', 5, 4),
(4116, 4011, '删除根CA', 'ca:root:remove', 'F', 6, 4),
(4117, 4011, '导入根CA', 'ca:root:import', 'F', 7, 4),
(4118, 4011, '导出根CA', 'ca:root:export', 'F', 8, 4),
(4119, 4011, '自签发', 'ca:root:gen', 'F', 9, 4),
(4120, 4011, '生成CSR', 'ca:root:csr', 'F', 10, 4),
(4121, 4011, '外部签发', 'ca:root:external', 'F', 11, 4),
(4122, 4011, '签发管理员', 'ca:root:admin-cert', 'F', 12, 4),
(4123, 4011, '授权模板', 'ca:root:authorize', 'F', 13, 4),
(4124, 4011, '下载根CA', 'ca:root:download', 'F', 14, 4),
(4125, 4011, '启用根CA', 'ca:root:enable', 'F', 15, 4),
(4126, 4011, '停用根CA', 'ca:root:disable', 'F', 16, 4),
(4127, 4011, '吊销根CA', 'ca:root:revoke', 'F', 17, 4),
(4128, 4011, 'CRL配置', 'ca:root:crl-config', 'F', 18, 4);

-- [4012] 模板管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4012, 4010, '模板管理', 'ca:profile', 'C', 2, 'ca-profile', 'ca/profile/index', 1, 0, '0', '0', 'form', 4, '模板管理');
-- 按钮: 4131-4149
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES 
(4131, 4012, '分页查询', 'ca:profile:page', 'F', 1, 4),
(4132, 4012, '查看详情', 'ca:profile:detail', 'F', 2, 4),
(4133, 4012, '新增模板', 'ca:profile:save', 'F', 3, 4),
(4134, 4012, '修改模板', 'ca:profile:modify', 'F', 4, 4),
(4135, 4012, '删除模板', 'ca:profile:remove', 'F', 5, 4),
(4136, 4012, '导入模板', 'ca:profile:import', 'F', 6, 4),
(4137, 4012, '导出模板', 'ca:profile:export', 'F', 7, 4),
(4138, 4012, '模板初始化', 'ca:profile:init', 'F', 8, 4),
(4139, 4012, '列表查询', 'ca:profile:list', 'F', 9, 4);

-- [4013] 请求者管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4013, 4010, '请求者管理', 'ca:requestor', 'C', 3, 'ca-requestor', 'ca/requestor/index', 1, 0, '0', '0', 'people', 4, '请求者管理');
-- 按钮: 4151-4169
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES 
(4151, 4013, '分页查询', 'ca:requestor:page', 'F', 1, 4),
(4152, 4013, '列表查询', 'ca:requestor:list', 'F', 2, 4),
(4153, 4013, '查看详情', 'ca:requestor:detail', 'F', 3, 4),
(4154, 4013, '新增请求者', 'ca:requestor:save', 'F', 4, 4),
(4155, 4013, '修改请求者', 'ca:requestor:modify', 'F', 5, 4),
(4156, 4013, '删除请求者', 'ca:requestor:remove', 'F', 6, 4),
(4157, 4013, '导入请求者', 'ca:requestor:import', 'F', 7, 4),
(4158, 4013, '导出请求者', 'ca:requestor:export', 'F', 8, 4);

-- [4014] 签名者管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4014, 4010, '签名者管理', 'ca:signer', 'C', 4, 'ca-signer', 'ca/signer/index', 1, 0, '0', '0', 'stamp', 4, '签名者管理');
-- 按钮: 4171-4189
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES 
(4171, 4014, '列表查询', 'ca:signer:list', 'F', 1, 4),
(4172, 4014, '新增签名者', 'ca:signer:save', 'F', 2, 4),
(4173, 4014, '修改签名者', 'ca:signer:modify', 'F', 3, 4),
(4174, 4014, '删除签名者', 'ca:signer:remove', 'F', 4, 4),
(4175, 4014, '分页查询', 'ca:signer:page', 'F', 5, 4),
(4176, 4014, '查看详情', 'ca:signer:detail', 'F', 6, 4);

-- [4015] 系统配置
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4015, 4010, '系统配置', 'ca:config', 'C', 5, 'ca-config', 'ca/config/index', 1, 0, '0', '0', 'system', 4, 'CA系统配置');
-- 按钮: 4181-4189
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES
(4181, 4015, '读取配置', 'ca:config:get', 'F', 1, 4),
(4182, 4015, '保存配置', 'ca:config:save', 'F', 2, 4);

-- [4016] 发布者管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4016, 4010, '发布者管理', 'ca:publisher', 'C', 6, 'ca-publisher', 'ca/publisher/index', 1, 0, '0', '0', 'upload', 4, '发布者管理');
-- 按钮: 4191-4199
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES
(4191, 4016, '分页查询', 'ca:publisher:page', 'F', 1, 4),
(4192, 4016, '查看详情', 'ca:publisher:detail', 'F', 2, 4),
(4193, 4016, '新增发布者', 'ca:publisher:save', 'F', 3, 4),
(4194, 4016, '修改发布者', 'ca:publisher:modify', 'F', 4, 4),
(4195, 4016, '删除发布者', 'ca:publisher:remove', 'F', 5, 4),
(4196, 4016, '导入发布者', 'ca:publisher:import', 'F', 6, 4),
(4197, 4016, '导出发布者', 'ca:publisher:export', 'F', 7, 4);
-- 发布操作权限: 4255-4259
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES
	(4255, 4016, '手动发布证书', 'ca:publisher:publish', 'F', 10, 4),
	(4256, 4016, '重试发布', 'ca:publisher:retry', 'F', 11, 4),
	(4257, 4016, '分页查询发布队列', 'ca:publisher:queue:page', 'F', 12, 4),
	(4258, 4016, '查询发布状态', 'ca:publisher:queue:status', 'F', 13, 4),
	(4259, 4016, '测试发布点连接', 'ca:publisher:test', 'F', 14, 4);

-- [4020] 管理员管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4020, 0, '管理员管理', '', 'M', 3020, 'ca-admin', '', 1, 0, '0', '0', 'peoples', 4, '管理员管理');
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4021, 4020, '业务管理员', 'ca:admin', 'C', 1, 'ca-admin-operator', 'ca/admin/index', 1, 0, '0', '0', 'peoples', 4, '业务管理员');

-- [4030] 审计员管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4030, 0, '审计员管理', '', 'M', 4030, 'ca-audit-manager', '', 1, 0, '0', '0', 'user', 4, '审计员管理');
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4031, 4030, '审计员', 'ca:audit', 'C', 1, 'ca-audit', 'ca/audit/index', 1, 0, '0', '0', 'user', 4, '审计员');

-- [4040] 业务管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4040, 0, '业务管理', '', 'M', 3040, 'ca-function', '', 1, 0, '0', '0', 'shopping', 4, '业务管理目录');

-- [4041] 证书管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4041, 4040, '证书管理', 'ca:cert', 'C', 1, 'ca-cert', 'ca/cert/index', 1, 0, '0', '0', 'cert', 4, '证书管理');
-- 按钮: 4201-4219
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES 
(4201, 4041, '分页查询', 'ca:cert:page', 'F', 1, 4),
(4202, 4041, '查看详情', 'ca:cert:detail', 'F', 2, 4),
(4203, 4041, '保存证书', 'ca:cert:save', 'F', 3, 4),
(4204, 4041, '修改证书', 'ca:cert:modify', 'F', 4, 4),
(4205, 4041, '删除证书', 'ca:cert:remove', 'F', 5, 4),
(4206, 4041, '导入证书', 'ca:cert:import', 'F', 6, 4),
(4207, 4041, '导出证书', 'ca:cert:export', 'F', 7, 4),
(4208, 4041, '签发证书', 'ca:cert:issue', 'F', 8, 4),
(4209, 4041, '吊销证书', 'ca:cert:revoke', 'F', 9, 4),
(4210, 4041, '下载证书', 'ca:cert:download', 'F', 10, 4),
(4211, 4041, '密钥恢复', 'ca:cert:recover', 'F', 11, 4),
(4212, 4041, '挂起恢复', 'ca:cert:suspend', 'F', 12, 4),
(4213, 4041, '双证签发', 'ca:cert:issue-dual', 'F', 13, 4),
(4214, 4041, '证书续期', 'ca:cert:renew', 'F', 14, 4),
(4215, 4041, '证书更新', 'ca:cert:update', 'F', 15, 4),
(4216, 4041, '证书重签', 'ca:cert:reissue', 'F', 16, 4);

-- [4042] CRL管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4042, 4040, 'CRL管理', 'ca:crl', 'C', 2, 'ca-crl', 'ca/crl/index', 1, 0, '0', '0', 'clipboard', 4, 'CRL管理');
-- 按钮: 4221-4239
INSERT INTO `sys_menu` (id, pid, name, permission, type, sort, tenant_id) VALUES 
(4221, 4042, '列表查询', 'ca:crl:list', 'F', 1, 4),
(4222, 4042, '新增CRL', 'ca:crl:save', 'F', 2, 4),
(4223, 4042, '修改CRL', 'ca:crl:modify', 'F', 3, 4),
(4224, 4042, '删除CRL', 'ca:crl:remove', 'F', 4, 4),
(4225, 4042, '导入CRL', 'ca:crl:import', 'F', 5, 4),
(4226, 4042, '导出CRL', 'ca:crl:export', 'F', 6, 4),
(4227, 4042, '分页查询', 'ca:crl:page', 'F', 7, 4),
(4228, 4042, '查看详情', 'ca:crl:detail', 'F', 8, 4),
(4229, 4042, '签发CRL', 'ca:crl:issue', 'F', 9, 4),
(4230, 4042, '发布CRL', 'ca:crl:publish', 'F', 10, 4);

-- [4050] 审计管理 (日志)
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4050, 0, '审计管理', '', 'M', 3050, 'ca-log', '', 1, 0, '0', '0', 'documentation', 4, '审计管理目录');
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4051, 4050, '登录日志', 'sys:login-log:page', 'C', 1, 'ca-log-login', 'ca/log/login/index', 1, 0, '0', '0', 'logininfor', 4, '登录日志');
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES (4052, 4050, '业务日志', 'sys:operate-log:page', 'C', 2, 'ca-log-operator', 'ca/log/operator/index', 1, 0, '0', '0', 'log', 4, '业务日志');

-- ----------------------------
-- 4. sys_user (用户)
-- admin / Qwe123!!, audit / Qwe123!!
-- ----------------------------
INSERT INTO `sys_user` (`id`, `creator`, `create_time`, `tenant_id`, `dept_id`, `password`, `super_admin`, `status`, `username`) VALUES 
(401, 401, '2025-01-01 00:00:00', 4, 401, '{bcrypt}$2a$10$WxkUYA/zsqbyfKe7x/3bP.TSFAcX2nrap3G7lASYSLoOdDDafY.Me', 0, 0, 'Ylh4QTF0YmdEWWJRimFMPGaJmldyuWIb9BNmUN1ULMI7'),
(402, 401, '2025-01-01 00:00:00', 4, 401, '{bcrypt}$2a$10$WxkUYA/zsqbyfKe7x/3bP.TSFAcX2nrap3G7lASYSLoOdDDafY.Me', 0, 0, 'Ylh4QTF0YmdEWWJRinBFPHx7Fvv2RgCsa2ib2oZvdGfT');

-- ----------------------------
-- 5. sys_role (角色)
-- ----------------------------
INSERT INTO `sys_role` (`id`, `creator`, `create_time`, `tenant_id`, `name`, `sort`, `data_scope`) VALUES 
(401, 401, '2025-01-01 00:00:00', 4, '管理员', 1, 'no'),
(402, 401, '2025-01-01 00:00:00', 4, '审计管理员', 2, 'no'),
(403, 401, '2025-01-01 00:00:00', 4, '业务管理员', 3, 'no'),
(404, 401, '2025-01-01 00:00:00', 4, '审计员', 4, 'no');

-- ----------------------------
-- 6. sys_role_menu (角色权限映射)
-- ----------------------------

-- 管理员 (401): 仅拥有安全管理(4010)和管理员管理(4020)及下属权限
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) 
SELECT 4, 401, id FROM `sys_menu`
WHERE tenant_id = 4
  AND (
      id IN (4010, 4020)
      OR pid IN (4010, 4020)
      OR pid IN (SELECT id FROM `sys_menu` WHERE tenant_id = 4 AND pid IN (4010, 4020))
  );

-- 管理员 (401): 安装向导权限
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 401, 4000);

-- 管理员 (401): 证书管理(4041)及下属权限
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 401, 4041);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) SELECT 4, 401, id FROM `sys_menu` WHERE pid = 4041;

-- 业务管理员 (403): 拥有业务管理(4040)及下属所有权限
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4040);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) SELECT 4, 403, id FROM `sys_menu` WHERE pid = 4040;
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) SELECT 4, 403, id FROM `sys_menu` WHERE pid IN (SELECT id FROM `sys_menu` WHERE pid = 4040);

-- 业务管理员 (403): 模板管理(4012)只读权限（证书管理页面需查询模板列表）
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4012);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4131);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4139);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4132);

-- 业务管理员 (403): 请求者管理(4013)只读
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4013);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4151);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4152);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4153);

-- 业务管理员 (403): 签名者管理(4014)只读
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4014);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4171);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4175);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4176);

-- 业务管理员 (403): 发布者管理(4016)只读
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4016);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4191);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4192);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4257);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4258);

-- 业务管理员 (403): 系统配置(4015)只读
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4015);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4181);

-- 业务管理员 (403): 根证书管理(4011)只读
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4011);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4111);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4112);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 403, 4113);

-- 审计管理员 (402): 拥有审计员管理(4030)及下属权限
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 402, 4030);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) SELECT 4, 402, id FROM `sys_menu` WHERE pid = 4030;

-- 审计员 (404): 拥有审计管理(4050)及下属所有权限
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES (4, 404, 4050);
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) SELECT 4, 404, id FROM `sys_menu` WHERE pid = 4050;

-- ----------------------------
-- 7. sys_user_role (用户角色映射)
-- ----------------------------
INSERT INTO `sys_user_role` (`tenant_id`, `user_id`, `role_id`) VALUES (4, 401, 401), (4, 402, 402);

-- ----------------------------
-- 8. sys_role_dept (角色部门)
-- ----------------------------
INSERT INTO `sys_role_dept` (`id`, `creator`, `create_time`, `tenant_id`, `role_id`, `dept_id`) VALUES 
(401, 401, '2025-01-01 00:00:00', 4, 401, 401),
(402, 401, '2025-01-01 00:00:00', 4, 402, 401),
(403, 401, '2025-01-01 00:00:00', 4, 403, 401),
(404, 401, '2025-01-01 00:00:00', 4, 404, 401);

SET FOREIGN_KEY_CHECKS = 1;

SELECT '03_init_data.sql executed successfully and IDs organized' AS status;

-- ============================================================================
-- 归档证书管理菜单
-- ============================================================================

INSERT IGNORE INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`)
VALUES (4045, 4040, '归档证书管理', 'ca:archive-cert', 'C', 2, 'ca-archive-cert', 'ca/archive-cert/index', 1, 0, '0', '0', 'list', 4, '归档证书管理');

INSERT IGNORE INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `tenant_id`) VALUES
(4251, 4045, '分页查询', 'ca:archive-cert:page', 'F', 1, 4),
(4252, 4045, '查看详情', 'ca:archive-cert:detail', 'F', 2, 4),
(4253, 4045, '下载证书', 'ca:archive-cert:download', 'F', 3, 4),
(4254, 4045, '导出证书', 'ca:archive-cert:export', 'F', 4, 4);

INSERT IGNORE INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`) VALUES
(4, 403, 4045),
(4, 403, 4251),
(4, 403, 4252),
(4, 403, 4253),
(4, 403, 4254);

-- ============================================================================
-- 菜单图标
-- ============================================================================

UPDATE `sys_menu`
SET `icon` = CASE `id`
    WHEN 4000 THEN 'guide'
    WHEN 4010 THEN 'tool'
    WHEN 4011 THEN 'key'
    WHEN 4012 THEN 'form'
    WHEN 4013 THEN 'people'
    WHEN 4014 THEN 'stamp'
    WHEN 4015 THEN 'system'
    WHEN 4016 THEN 'upload'
    WHEN 4020 THEN 'peoples'
    WHEN 4021 THEN 'peoples'
    WHEN 4030 THEN 'user'
    WHEN 4031 THEN 'user'
    WHEN 4040 THEN 'shopping'
    WHEN 4041 THEN 'cert'
    WHEN 4042 THEN 'clipboard'
    WHEN 4045 THEN 'list'
    WHEN 4050 THEN 'documentation'
    WHEN 4051 THEN 'logininfor'
    WHEN 4052 THEN 'log'
    WHEN 4061 THEN 'lock'
    ELSE `icon`
END
WHERE `tenant_id` = 4
  AND `type` IN ('M', 'C')
  AND `id` IN (4000, 4010, 4011, 4012, 4013, 4014, 4015, 4016,
               4020, 4021, 4030, 4031, 4040, 4041, 4042,
               4045, 4050, 4051, 4052, 4061);

SELECT '02_ca_4_platform_data.sql executed successfully' AS status;
