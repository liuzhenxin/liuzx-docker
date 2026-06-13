/*
 LiuZX KMC 数据库初始化数据脚本

 版本: 4.1.2
 日期: 2026-05-02
 说明: 初始化 KMC 租户、部门、用户、角色、菜单和权限数据

 执行方式:
 mysql -u root -p lcloud_platform_4 < 02_kmc_4_data.sql

 注意:
 1. 此脚本写入平台库 lcloud_platform_4，不写入 KMC 业务库
 2. 需要先执行 liuzx-admin 的数据库脚本
 3. 租户ID为3，用于 KMC 密钥管理中心
 4. 默认账号密码沿用平台初始化约定，生产环境必须首次登录后修改
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `lcloud_platform_4`;

-- ----------------------------
-- 清理旧数据 (租户ID: 3)
-- ----------------------------
DELETE FROM `sys_user_role` WHERE `tenant_id` = 3;
DELETE FROM `sys_role_dept` WHERE `tenant_id` = 3;
DELETE FROM `sys_role_menu` WHERE `tenant_id` = 3;
DELETE FROM `sys_role` WHERE `tenant_id` = 3;
DELETE FROM `sys_user_dept` WHERE `tenant_id` = 3;
DELETE FROM `sys_user` WHERE `tenant_id` = 3;
DELETE FROM `sys_menu` WHERE `tenant_id` = 3;
DELETE FROM `sys_dept` WHERE `tenant_id` = 3;
DELETE FROM `sys_tenant` WHERE `id` = 3;

-- ----------------------------
-- 1. sys_tenant (租户)
-- ----------------------------
INSERT INTO `sys_tenant` (`id`, `creator`, `create_time`, `tenant_id`, `name`, `code`, `status`, `source_id`, `package_id`)
VALUES (3, 301, '2024-05-15 14:42:36', 3, '密钥管理中心', 'kmc', -1, 3, 3);

-- ----------------------------
-- 2. sys_dept (部门)
-- ----------------------------
INSERT INTO `sys_dept` (`id`, `pid`, `name`, `path`, `sort`, `tenant_id`)
VALUES (301, 0, '总部', '0,301', 0, 3);

-- ----------------------------
-- 3. sys_menu (菜单及按钮)
-- ID 码段:
-- 3000      安装向导
-- 3010-3019 密钥管理菜单
-- 3020-3029 安全管理菜单
-- 3030-3039 审计员管理菜单
-- 3040-3049 司法取证菜单
-- 3050-3059 策略管理菜单
-- 3060-3069 审计日志菜单
-- 3101-3199 密钥管理按钮
-- 3201-3299 司法取证按钮
-- 3301-3399 策略管理按钮
-- 3401-3499 安全管理/测试按钮
-- ----------------------------

-- [3000] 安装向导
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES
(3000, 1, '安装向导', 'kmc:setup', 'C', 1, 'setup', 'kmc/init/index', 1, 0, '0', '0', 'tree-table', 3, '安装向导');

-- [3010] 密钥管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES
(3010, 0, '密钥管理', '', 'M', 3010, 'kmc-key', '', 1, 0, '0', '0', 'key', 3, '密钥管理目录'),
(3011, 3010, '密钥看板', 'kmc:dashboard:view', 'C', 1, 'kmc-dashboard', 'kmc/dashboard/index', 1, 0, '0', '0', '', 3, '密钥看板'),
(3012, 3010, '密钥池策略', 'kmc:poolstrategy:page', 'C', 2, 'kmc-pool-strategy', 'kmc/pool/strategy/index', 1, 0, '0', '0', '', 3, '密钥池策略'),
(3013, 3010, '备用密钥池', 'kmc:poolkey:allocate', 'C', 3, 'kmc-pool-key', 'kmc/pool/key/index', 1, 0, '0', '0', '', 3, '备用密钥池'),
(3014, 3010, '在用密钥', 'kmc:usedkey:page', 'C', 4, 'kmc-used-key', 'kmc/used/index', 1, 0, '0', '0', '', 3, '在用密钥'),
(3015, 3010, '归档密钥', 'kmc:archivekey:page', 'C', 5, 'kmc-archive-key', 'kmc/archive/index', 1, 0, '0', '0', '', 3, '归档密钥'),
(3016, 3010, '备用密钥维护', 'kmc:reservekey:page', 'C', 6, 'kmc-reserve-key', 'kmc/reserve/index', 1, 0, '0', '0', '', 3, '备用密钥维护'),
(3017, 3010, '水位线管理', 'kmc:poolwatermark:status', 'C', 7, 'kmc-pool-watermark', 'kmc/pool/watermark/index', 1, 0, '0', '0', '', 3, '密钥池水位线管理'),
(3018, 3010, '生成任务', 'kmc:poolgenerationjob:page', 'C', 8, 'kmc-pool-generation-job', 'kmc/pool/generationJob/index', 1, 0, '0', '0', '', 3, '备用密钥生成任务');

INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `tenant_id`) VALUES
(3101, 3011, '查看看板', 'kmc:dashboard:view', 'F', 1, 3),
(3111, 3012, '分页查询', 'kmc:poolstrategy:page', 'F', 1, 3),
(3112, 3012, '查看详情', 'kmc:poolstrategy:detail', 'F', 2, 3),
(3113, 3012, '新增策略', 'kmc:poolstrategy:save', 'F', 3, 3),
(3114, 3012, '修改策略', 'kmc:poolstrategy:modify', 'F', 4, 3),
(3115, 3012, '删除策略', 'kmc:poolstrategy:remove', 'F', 5, 3),
(3121, 3013, '分配密钥', 'kmc:poolkey:allocate', 'F', 1, 3),
(3122, 3013, '批量分配', 'kmc:poolkey:batch-allocate', 'F', 2, 3),
(3131, 3014, '分页查询', 'kmc:usedkey:page', 'F', 1, 3),
(3132, 3014, '查看详情', 'kmc:usedkey:detail', 'F', 2, 3),
(3133, 3014, '保存在用密钥', 'kmc:usedkey:save', 'F', 3, 3),
(3134, 3014, '修改在用密钥', 'kmc:usedkey:modify', 'F', 4, 3),
(3135, 3014, '删除在用密钥', 'kmc:usedkey:remove', 'F', 5, 3),
(3136, 3014, '导入在用密钥', 'kmc:usedkey:import', 'F', 6, 3),
(3137, 3014, '导出在用密钥', 'kmc:usedkey:export', 'F', 7, 3),
(3138, 3014, '提交密钥恢复', 'kmc:keyrecovery:submit', 'F', 8, 3),
(3139, 3014, '恢复密钥', 'kmc:keyrecovery:recover', 'F', 9, 3),
(3140, 3014, '查询恢复状态', 'kmc:keyrecovery:status', 'F', 10, 3),
(3198, 3014, '司法取证员签名', 'kmc:keyrecovery:sign', 'F', 11, 3),
(3199, 3014, '司法取证员拒签', 'kmc:keyrecovery:reject', 'F', 12, 3),
(3141, 3015, '分页查询', 'kmc:archivekey:page', 'F', 1, 3),
(3142, 3015, '查看详情', 'kmc:archivekey:detail', 'F', 2, 3),
(3143, 3015, '保存归档密钥', 'kmc:archivekey:save', 'F', 3, 3),
(3144, 3015, '修改归档密钥', 'kmc:archivekey:modify', 'F', 4, 3),
(3145, 3015, '删除归档密钥', 'kmc:archivekey:remove', 'F', 5, 3),
(3146, 3015, '导入归档密钥', 'kmc:archivekey:import', 'F', 6, 3),
(3147, 3015, '导出归档密钥', 'kmc:archivekey:export', 'F', 7, 3),
(3148, 3015, '提交密钥恢复', 'kmc:keyrecovery:submit', 'F', 8, 3),
(3149, 3015, '恢复密钥', 'kmc:keyrecovery:recover', 'F', 9, 3),
(3150, 3015, '查询恢复状态', 'kmc:keyrecovery:status', 'F', 10, 3),
(3200, 3015, '司法取证员签名', 'kmc:keyrecovery:sign', 'F', 11, 3),
(3298, 3015, '司法取证员拒签', 'kmc:keyrecovery:reject', 'F', 12, 3),
(3151, 3016, '分页查询', 'kmc:reservekey:page', 'F', 1, 3),
(3152, 3016, '查看详情', 'kmc:reservekey:detail', 'F', 2, 3),
(3153, 3016, '保存备用密钥', 'kmc:reservekey:save', 'F', 3, 3),
(3154, 3016, '修改备用密钥', 'kmc:reservekey:modify', 'F', 4, 3),
(3155, 3016, '删除备用密钥', 'kmc:reservekey:remove', 'F', 5, 3),
(3156, 3016, '导入备用密钥', 'kmc:reservekey:import', 'F', 6, 3),
(3157, 3016, '导出备用密钥', 'kmc:reservekey:export', 'F', 7, 3),
(3161, 3017, '检查水位线', 'kmc:poolwatermark:check', 'F', 1, 3),
(3162, 3017, '批量生成密钥', 'kmc:poolwatermark:generate', 'F', 2, 3),
(3163, 3017, '查询水位状态', 'kmc:poolwatermark:status', 'F', 3, 3),
(3181, 3018, '分页查询', 'kmc:poolgenerationjob:page', 'F', 1, 3),
(3182, 3018, '查看详情', 'kmc:poolgenerationjob:detail', 'F', 2, 3),
(3183, 3018, '新增任务', 'kmc:poolgenerationjob:save', 'F', 3, 3),
(3184, 3018, '修改任务', 'kmc:poolgenerationjob:modify', 'F', 4, 3),
(3185, 3018, '删除任务', 'kmc:poolgenerationjob:remove', 'F', 5, 3),
(3186, 3018, '启用任务', 'kmc:poolgenerationjob:enable', 'F', 6, 3),
(3187, 3018, '停用任务', 'kmc:poolgenerationjob:disable', 'F', 7, 3),
(3188, 3018, '手动执行', 'kmc:poolgenerationjob:trigger', 'F', 8, 3),
(3189, 3018, '执行日志', 'kmc:poolgenerationjob:log', 'F', 9, 3);

-- [3020] 安全管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES
(3020, 0, '安全管理', '', 'M', 3020, 'kmc-security', '', 1, 0, '0', '0', 'tool', 3, '安全管理目录'),
(3021, 3020, '业务管理员', 'sys:user:page', 'C', 1, 'kmc-admin-biz', 'kmc/admin/biz/index', 1, 0, '0', '0', '', 3, '业务管理员'),
(3022, 3020, '业务操作员', 'sys:user:page', 'C', 2, 'kmc-admin-operator', 'kmc/admin/operator/index', 1, 0, '0', '0', '', 3, '业务操作员'),
(3023, 3020, '司法取证员', 'sys:user:page', 'C', 3, 'kmc-admin-judge', 'kmc/admin/judge/index', 1, 0, '0', '0', '', 3, '司法取证员');

INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `tenant_id`) VALUES
(3421, 3021, '分页查询用户', 'sys:user:page', 'F', 1, 3),
(3422, 3021, '查看用户详情', 'sys:user:detail', 'F', 2, 3),
(3423, 3021, '新增用户', 'system:user:add', 'F', 3, 3),
(3424, 3021, '修改用户', 'system:user:edit', 'F', 4, 3),
(3425, 3021, '删除用户', 'system:user:remove', 'F', 5, 3),
(3426, 3021, '导入用户', 'system:user:import', 'F', 6, 3),
(3427, 3021, '导出用户', 'system:user:export', 'F', 7, 3),
(3428, 3021, '重置密码', 'system:user:resetPwd', 'F', 8, 3),
(3429, 3021, '导入用户接口', 'sys:user:import', 'F', 9, 3),
(3430, 3021, '导出用户接口', 'sys:user:export', 'F', 10, 3),
(3431, 3022, '分页查询用户', 'sys:user:page', 'F', 1, 3),
(3432, 3022, '查看用户详情', 'sys:user:detail', 'F', 2, 3),
(3433, 3022, '新增用户', 'system:user:add', 'F', 3, 3),
(3434, 3022, '修改用户', 'system:user:edit', 'F', 4, 3),
(3435, 3022, '删除用户', 'system:user:remove', 'F', 5, 3),
(3436, 3022, '导入用户', 'system:user:import', 'F', 6, 3),
(3437, 3022, '导出用户', 'system:user:export', 'F', 7, 3),
(3438, 3022, '重置密码', 'system:user:resetPwd', 'F', 8, 3),
(3439, 3022, '导入用户接口', 'sys:user:import', 'F', 9, 3),
(3440, 3022, '导出用户接口', 'sys:user:export', 'F', 10, 3),
(3441, 3023, '分页查询用户', 'sys:user:page', 'F', 1, 3),
(3442, 3023, '查看用户详情', 'sys:user:detail', 'F', 2, 3),
(3443, 3023, '新增用户', 'system:user:add', 'F', 3, 3),
(3444, 3023, '修改用户', 'system:user:edit', 'F', 4, 3),
(3445, 3023, '删除用户', 'system:user:remove', 'F', 5, 3),
(3446, 3023, '导入用户', 'system:user:import', 'F', 6, 3),
(3447, 3023, '导出用户', 'system:user:export', 'F', 7, 3),
(3448, 3023, '重置密码', 'system:user:resetPwd', 'F', 8, 3),
(3449, 3023, '导入用户接口', 'sys:user:import', 'F', 9, 3),
(3450, 3023, '导出用户接口', 'sys:user:export', 'F', 10, 3);

-- [3030] 审计员管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES
(3030, 0, '审计员管理', '', 'M', 3030, 'kmc-audit-manager', '', 1, 0, '0', '0', 'user', 3, '审计员管理目录'),
(3031, 3030, '审计员', 'sys:user:page', 'C', 1, 'kmc-audit', 'kmc/audit/index', 1, 0, '1', '1', '', 3, '审计员');

-- [3040] 司法取证管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES
(3040, 0, '司法取证管理', '', 'M', 3040, 'kmc-judge', '', 1, 0, '0', '0', 'eye-open', 3, '司法取证管理目录'),
(3041, 3040, '审批记录', 'kmc:judge:page', 'C', 1, 'kmc-judge-record', 'kmc/judge/index', 1, 0, '0', '0', '', 3, '审批记录');

INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `tenant_id`) VALUES
(3201, 3041, '分页查询', 'kmc:judge:page', 'F', 1, 3),
(3202, 3041, '查看详情', 'kmc:judge:detail', 'F', 2, 3),
(3203, 3041, '新增审批', 'kmc:judge:save', 'F', 3, 3),
(3204, 3041, '修改审批', 'kmc:judge:modify', 'F', 4, 3),
(3205, 3041, '删除审批', 'kmc:judge:remove', 'F', 5, 3),
(3206, 3041, '导入审批', 'kmc:judge:import', 'F', 6, 3),
(3207, 3041, '导出审批', 'kmc:judge:export', 'F', 7, 3),
(3208, 3041, '审批申请', 'kmc:judge:approve', 'F', 8, 3);

-- [3050] 策略管理
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES
(3050, 0, '策略管理', '', 'M', 3050, 'kmc-policy', '', 1, 0, '0', '0', 'nested', 3, '策略管理目录'),
(3051, 3050, 'CA机构管理', 'kmc:ca:page', 'C', 1, 'kmc-ca', 'kmc/policy/ca/index', 1, 0, '0', '0', '', 3, 'CA机构管理'),
(3052, 3050, '系统配置', 'kmc:config', 'C', 2, 'kmc-config', 'kmc/policy/config/index', 1, 0, '0', '0', '', 3, '系统配置');

INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `tenant_id`) VALUES
(3301, 3051, '分页查询', 'kmc:ca:page', 'F', 1, 3),
(3302, 3051, '查看详情', 'kmc:ca:detail', 'F', 2, 3),
(3303, 3051, '保存CA机构', 'kmc:ca:save', 'F', 3, 3),
(3304, 3051, '修改CA机构', 'kmc:ca:modify', 'F', 4, 3),
(3305, 3051, '删除CA机构', 'kmc:ca:remove', 'F', 5, 3),
(3306, 3051, '导入CA机构', 'kmc:ca:import', 'F', 6, 3),
(3307, 3051, '导出CA机构', 'kmc:ca:export', 'F', 7, 3),
(3308, 3051, '验证CA身份', 'kmc:ca:verify', 'F', 8, 3),
(3311, 3052, '查看系统配置', 'kmc:config:view', 'F', 1, 3),
(3312, 3052, '修改系统配置', 'kmc:config:edit', 'F', 2, 3),
(3313, 3052, '刷新配置缓存', 'kmc:config:refresh', 'F', 3, 3);

-- [3060] 审计日志
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES
(3060, 0, '审计日志', '', 'M', 3060, 'kmc-log', '', 1, 0, '0', '0', 'documentation', 3, '审计日志目录'),
(3061, 3060, '登录日志', 'kmc:log:login', 'C', 1, 'kmc-log-login', 'kmc/log/login/index', 1, 0, '1', '1', '', 3, '登录日志'),
(3062, 3060, '业务日志', 'kmc:log:operator', 'C', 2, 'kmc-log-operator', 'kmc/log/operator/index', 1, 0, '1', '1', '', 3, '业务日志');

-- [3070] 开发测试
INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `path`, `component`, `is_frame`, `is_cache`, `visible`, `status`, `icon`, `tenant_id`, `remark`) VALUES
(3070, 0, '开发测试', '', 'M', 3990, 'kmc-dev', '', 1, 0, '1', '0', 'bug', 3, '开发测试目录'),
(3071, 3070, '测试样例', 'kmc:test', 'C', 1, 'kmc-test', 'kmc/test/index', 1, 0, '1', '0', '', 3, '测试样例');

INSERT INTO `sys_menu` (`id`, `pid`, `name`, `permission`, `type`, `sort`, `tenant_id`) VALUES
(3401, 3071, '分页查询', 'kmc:test:page', 'F', 1, 3),
(3402, 3071, '查看详情', 'kmc:test:detail', 'F', 2, 3),
(3403, 3071, '保存测试', 'kmc:test:save', 'F', 3, 3),
(3404, 3071, '修改测试', 'kmc:test:modify', 'F', 4, 3),
(3405, 3071, '删除测试', 'kmc:test:remove', 'F', 5, 3),
(3406, 3071, '导入测试', 'kmc:test:import', 'F', 6, 3),
(3407, 3071, '导出测试', 'kmc:test:export', 'F', 7, 3);

-- ----------------------------
-- KMC 运行时系统配置
-- ----------------------------
INSERT INTO `sys_config` (`creator`, `create_time`, `update_time`, `del_flag`, `version`, `tenant_id`, `k`, `v`, `enabled`) VALUES
(301, NOW(), NOW(), 0, 0, 3, 'kmc.key-generation.enable-hardware-generation', 'true', 1),
(301, NOW(), NOW(), 0, 0, 3, 'kmc.key-generation.default-key-type', 'SM2', 1),
(301, NOW(), NOW(), 0, 0, 3, 'kmc.key-generation.default-key-size', '256', 1),
(301, NOW(), NOW(), 0, 0, 3, 'kmc.key-generation.batch-size', '10', 1),
(301, NOW(), NOW(), 0, 0, 3, 'kmc.reserve-pool.enable-auto-replenish', 'true', 1),
(301, NOW(), NOW(), 0, 0, 3, 'kmc.reserve-pool.watermark-check-interval', '300', 1),
(301, NOW(), NOW(), 0, 0, 3, 'kmc.reserve-pool.generation-rate-limit', '5', 1),
(301, NOW(), NOW(), 0, 0, 3, 'kmc.audit.enabled', 'true', 1),
(301, NOW(), NOW(), 0, 0, 3, 'kmc.audit.retention-days', '90', 1)
ON DUPLICATE KEY UPDATE
    `v` = VALUES(`v`),
    `enabled` = VALUES(`enabled`),
    `del_flag` = 0,
    `update_time` = NOW();

-- ----------------------------
-- 4. sys_user (用户)
-- admin / Qwe123!!, audit / Qwe123!!
-- ----------------------------
INSERT INTO `sys_user` (`id`, `creator`, `create_time`, `tenant_id`, `dept_id`, `password`, `super_admin`, `status`, `username`) VALUES
(301, 301, '2025-01-01 00:00:00', 3, 301, '{bcrypt}$2a$10$oZfSMv8EDmlWa0szVQ6B3uTbcp6pEmcCFFFDqzfUp7ghB8UqBD7Om', 0, 0, 'Ylh4QTF0YmdEWWJRimFMPGaJmldyuWIb9BNmUN1ULMI7'),
(302, 301, '2025-01-01 00:00:00', 3, 301, '{bcrypt}$2a$10$oZfSMv8EDmlWa0szVQ6B3uTbcp6pEmcCFFFDqzfUp7ghB8UqBD7Om', 0, 0, 'Ylh4QTF0YmdEWWJRinBFPHx7Fvv2RgCsa2ib2oZvdGfT');

-- ----------------------------
-- 5. sys_role (角色)
-- ----------------------------
INSERT INTO `sys_role` (`id`, `creator`, `create_time`, `tenant_id`, `name`, `sort`, `data_scope`) VALUES
(301, 301, '2025-01-01 00:00:00', 3, '安全管理员', 1, 'no'),
(302, 301, '2025-01-01 00:00:00', 3, '审计管理员', 2, 'no'),
(303, 301, '2025-01-01 00:00:00', 3, '业务管理员', 3, 'no'),
(304, 301, '2025-01-01 00:00:00', 3, '业务操作员', 4, 'no'),
(305, 301, '2025-01-01 00:00:00', 3, '审计员', 5, 'no'),
(306, 301, '2025-01-01 00:00:00', 3, '司法取证员', 6, 'no');

-- ----------------------------
-- 6. sys_role_menu (角色权限映射)
-- ----------------------------

-- 安全管理员 (301): 安装向导、业务管理员管理、策略管理、密钥池策略、水位线和生成任务维护
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`)
SELECT 3, 301, id FROM `sys_menu`
WHERE tenant_id = 3
  AND (
      id IN (3000, 3010, 3012, 3017, 3018, 3020, 3021, 3050)
      OR pid IN (3012, 3017, 3018, 3021, 3050)
      OR pid IN (SELECT id FROM `sys_menu` WHERE tenant_id = 3 AND pid IN (3050))
  );

-- 审计管理员 (302): 审计员管理
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`)
SELECT 3, 302, id FROM `sys_menu`
WHERE tenant_id = 3
  AND (id = 3030 OR pid = 3030);

-- 业务管理员 (303): 维护业务操作员和司法取证员
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`)
SELECT 3, 303, id FROM `sys_menu`
WHERE tenant_id = 3
  AND (id IN (3020, 3022, 3023, 3431, 3432, 3433, 3434, 3435, 3438, 3441, 3442, 3443, 3444, 3445, 3448));

-- 业务操作员 (304): 密钥业务、司法取证、策略查询能力
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`)
SELECT 3, 304, id FROM `sys_menu`
WHERE tenant_id = 3
  AND (
      id IN (3010, 3011, 3014, 3015, 3040, 3051)
      OR pid IN (3011, 3014, 3015, 3040, 3051)
      OR pid IN (SELECT id FROM `sys_menu` WHERE tenant_id = 3 AND pid IN (3040))
  );

-- 司法取证员 (306): 司法审批和密钥恢复
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`)
SELECT 3, 306, id FROM `sys_menu`
WHERE tenant_id = 3
  AND (
      id IN (3040)
      OR pid IN (3040)
      OR pid IN (SELECT id FROM `sys_menu` WHERE tenant_id = 3 AND pid IN (3040))
  );

-- 审计员 (305): 审计日志
INSERT INTO `sys_role_menu` (`tenant_id`, `role_id`, `menu_id`)
SELECT 3, 305, id FROM `sys_menu`
WHERE tenant_id = 3
  AND (id = 3060 OR pid = 3060);

-- ----------------------------
-- 7. sys_user_role (用户角色映射)
-- ----------------------------
INSERT INTO `sys_user_role` (`tenant_id`, `user_id`, `role_id`) VALUES
(3, 301, 301),
(3, 302, 302);

-- ----------------------------
-- 8. sys_role_dept (角色部门)
-- ----------------------------
INSERT INTO `sys_role_dept` (`id`, `creator`, `create_time`, `tenant_id`, `role_id`, `dept_id`) VALUES
(301, 301, '2025-01-01 00:00:00', 3, 301, 301),
(302, 301, '2025-01-01 00:00:00', 3, 302, 301),
(303, 301, '2025-01-01 00:00:00', 3, 303, 301),
(304, 301, '2025-01-01 00:00:00', 3, 304, 301),
(305, 301, '2025-01-01 00:00:00', 3, 305, 301),
(306, 301, '2025-01-01 00:00:00', 3, 306, 301);

-- ----------------------------
-- 9. sys_user_dept (用户部门)
-- ----------------------------
INSERT INTO `sys_user_dept` (`id`, `creator`, `create_time`, `tenant_id`, `user_id`, `dept_id`) VALUES
(301, 301, '2025-01-01 00:00:00', 3, 301, 301),
(302, 301, '2025-01-01 00:00:00', 3, 302, 301);

SET FOREIGN_KEY_CHECKS = 1;

-- 显示初始化结果
SELECT 'KMC 初始化数据写入完成' as '状态';
