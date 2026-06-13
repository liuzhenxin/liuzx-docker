/*
 LiuZX RA 平台数据库初始化数据脚本

 说明: 初始化 RA 租户、菜单权限、角色、admin/audit 基础用户及授权关系
 执行方式:
 mysql -u root -p lcloud_platform_4 < 03_ra_4_platform_data.sql
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `lcloud_platform_4`;

-- ----------------------------
-- 清理旧数据 (租户ID: 5)
-- ----------------------------
DELETE FROM `sys_user_role` WHERE `tenant_id` = 5;
DELETE FROM `sys_user_dept` WHERE `tenant_id` = 5;
DELETE FROM `sys_role_menu` WHERE `tenant_id` = 5;
DELETE FROM `sys_role_dept` WHERE `tenant_id` = 5;
DELETE FROM `sys_user` WHERE `tenant_id` = 5;
DELETE FROM `sys_role` WHERE `tenant_id` = 5;
DELETE FROM `sys_menu` WHERE `tenant_id` = 5;
DELETE FROM `sys_dept` WHERE `tenant_id` = 5;
DELETE FROM `sys_tenant` WHERE `id` = 5 OR `tenant_id` = 5;

-- ----------------------------
-- sys_tenant (租户)
-- ----------------------------

INSERT INTO `sys_tenant` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `name`,
  `code`,
  `status`,
  `source_id`,
  `package_id`
) VALUES
  (5,501,501,'2024-05-15 14:42:36','2026-06-04 09:20:41',0,39,5,'注册认证中心','ra',-1,5,5);

-- ----------------------------
-- sys_dept (部门)
-- ----------------------------

INSERT INTO `sys_dept` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `pid`,
  `name`,
  `path`,
  `sort`
) VALUES
  (501,501,NULL,'2024-05-15 14:42:36',NULL,0,0,5,0,'总部','0,501',0);

-- ----------------------------
-- sys_menu (菜单及权限)
-- ----------------------------

INSERT INTO `sys_menu` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `pid`,
  `permission`,
  `type`,
  `name`,
  `sort`,
  `path`,
  `component`,
  `query_param`,
  `is_frame`,
  `is_cache`,
  `visible`,
  `status`,
  `icon`,
  `remark`
) VALUES
  (5000,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,1,'setup','C','安装向导',1,'setup','ra/init/index','',1,0,'0','0','tree-table','安装向导菜单'),
  (5010,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,0,'','M','证书业务',3010,'ra-certificate','','',1,0,'0','0','cert','证书管理目录'),
  (5011,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5010,'ra:apply','C','证书申请',1,'ra-cert-apply','ra/apply/index','',1,0,'0','0','key','证书申请菜单'),
  (5012,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5010,'ra:cert','C','证书查询',2,'ra-cert-list','ra/cert/index','',1,0,'0','0','search','证书列表菜单'),
  (5013,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5010,'ra:renewal','C','证书续期',3,'ra-cert-renewal','ra/renewal/index','',1,0,'0','0','time','证书续期菜单'),
  (5014,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5010,'ra:update','C','证书更新',4,'ra-cert-update','ra/update/index','',1,0,'0','0','edit','证书更新菜单'),
  (5015,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5010,'ra:revoke','C','证书吊销',5,'ra-cert-revoke','ra/revoke/index','',1,0,'0','0','lock','证书吊销菜单'),
  (5016,501,NULL,'2026-06-02 19:42:38',NULL,0,0,5,5010,'ra:reissue','C','证书补办',6,'ra-cert-reissue','ra/reissue/index','',1,0,'0','0','key','证书补办菜单'),
  (5017,501,NULL,'2026-06-02 19:42:38',NULL,0,0,5,5010,'ra:freeze','C','证书冻结',7,'ra-cert-freeze','ra/freeze/index','',1,0,'0','0','lock','证书冻结菜单'),
  (5018,501,NULL,'2026-06-02 19:42:38',NULL,0,0,5,5010,'ra:unfreeze','C','证书解冻',8,'ra-cert-unfreeze','ra/unfreeze/index','',1,0,'0','0','key','证书解冻菜单'),
  (5019,501,NULL,'2026-06-03 11:22:16','2026-06-03 17:02:09',0,0,5,5010,'ra:cert:issue','C','证书签发',9,'ra-cert-issue','ra/issue/index','',1,0,'0','0','cert','审核通过后证书签发菜单'),
  (5020,501,501,'2025-01-01 00:00:00','2026-05-24 16:21:48',0,0,5,5090,'','M','CA管理',2,'ra-admin-ca','ParentView','',1,0,'0','0','cert','管理员管理下的CA管理目录'),
  (5021,501,501,'2025-01-01 00:00:00','2026-05-06 14:08:51',0,0,5,5020,'ra:root','C','根证书管理',1,'ra-root-cert','ra/root/index','',1,0,'0','0','key','根证书管理菜单'),
  (5022,501,501,'2025-01-01 00:00:00','2026-05-24 16:08:18',1,0,5,5020,'ra:profile','C','证书模板',2,'ra-profile','ra/profile/index','',1,0,'1','0','form','证书模板菜单'),
  (5023,501,501,'2025-01-01 00:00:00','2026-05-24 16:08:18',1,0,5,5020,'ra:crl','C','CRL管理',3,'ra-crl','ra/crl/index','',1,0,'1','0','list','CRL管理菜单'),
  (5030,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,0,'','M','用户管理',2991,'ra-user','','',1,0,'0','0','user','用户管理目录'),
  (5031,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5030,'ra:user','C','用户列表',1,'ra-user-list','ra/user/index','',1,0,'0','0','user','用户列表菜单'),
  (5040,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,0,'','M','部门管理',2990,'ra-dept','','',1,0,'0','0','tree','部门管理目录'),
  (5041,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5040,'ra:dept','C','部门列表',1,'ra-dept-list','ra/dept/index','',1,0,'0','0','tree','部门列表菜单'),
  (5042,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5041,'sys:dept:list-tree','F','查询部门树',1,'','','',1,0,'0','0','','部门树查询权限'),
  (5043,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5041,'sys:dept:detail','F','查看部门',2,'','','',1,0,'0','0','','部门详情权限'),
  (5044,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5041,'sys:dept:save','F','新增部门',3,'','','',1,0,'0','0','','部门新增权限'),
  (5045,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5041,'sys:dept:modify','F','修改部门',4,'','','',1,0,'0','0','','部门修改权限'),
  (5046,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5041,'sys:dept:remove','F','删除部门',5,'','','',1,0,'0','0','','部门删除权限'),
  (5050,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,0,'','M','策略管理',3050,'ra-policy','','',1,0,'0','0','guide','策略管理目录'),
  (5051,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5050,'ra:policy:cert','C','证书策略',1,'ra-cert-policy','ra/policy/cert/index','',1,0,'0','0','tool','证书策略菜单'),
  (5052,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5050,'ra:policy:security','C','安全策略',2,'ra-security-policy','ra/policy/security/index','',1,0,'0','0','lock','安全策略菜单'),
  (5060,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,0,'','M','审核中心',3020,'ra-workflow','','',1,0,'0','0','checkbox','工作流目录'),
  (5061,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5060,'ra:workflow:def','C','流程定义',1,'ra-workflow-def','ra/workflow/definition/index','',1,0,'0','0','workflow','流程定义菜单'),
  (5062,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5060,'ra:workflow:todo','C','待办审核',1,'ra-workflow-todo','ra/workflow/todo/index','',1,0,'0','0','waiting','待办任务菜单'),
  (5063,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5060,'ra:workflow:instance','C','已办记录',2,'ra-workflow-instance','ra/workflow/instance/index','',1,0,'0','0','finish','流程实例菜单'),
  (5070,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,0,'','M','通知告警',3070,'ra-alert','','',1,0,'0','0','message','通知告警目录'),
  (5071,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5070,'ra:alert:rule','C','告警规则',1,'ra-alert-rule','ra/alert/rule/index','',1,0,'0','0','message','告警规则菜单'),
  (5072,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5070,'ra:alert:history','C','告警历史',2,'ra-alert-history','ra/alert/history/index','',1,0,'0','0','log','告警历史菜单'),
  (5073,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5070,'ra:notification','C','通知管理',3,'ra-notification','ra/notification/index','',1,0,'0','0','email','通知管理菜单'),
  (5080,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,0,'','M','统计分析',3030,'ra-statistics','','',1,0,'0','0','chart','统计分析目录'),
  (5081,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5080,'ra:stat:cert','C','证书统计',1,'ra-cert-stat','ra/statistics/cert/index','',1,0,'0','0','chart','证书统计菜单'),
  (5082,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5080,'ra:stat:user','C','用户统计',2,'ra-user-stat','ra/statistics/user/index','',1,0,'0','0','peoples','用户统计菜单'),
  (5083,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5080,'ra:stat:trend','C','趋势分析',3,'ra-trend','ra/statistics/trend/index','',1,0,'0','0','chart','趋势分析菜单'),
  (5090,501,501,'2025-01-01 00:00:00','2026-05-06 15:07:54',0,0,5,0,'','M','管理员管理',3000,'ra-admin','','',1,0,'0','0','peoples','管理员管理目录'),
  (5091,501,501,'2025-01-01 00:00:00','2026-05-06 14:08:51',0,0,5,5090,'ra:admin','C','业务管理员',1,'ra-admin-operator','ra/admin/index','',1,0,'0','0','peoples','业务管理员菜单'),
  (5092,501,501,'2025-01-01 00:00:00','2026-05-06 14:08:51',1,0,5,5091,'ra:admin:input','C','录入员',1,'ra-admin-input','ra/admin/index','roleId=503',1,0,'0','0','user','录入员管理菜单'),
  (5093,501,501,'2025-01-01 00:00:00','2026-05-06 14:08:51',1,0,5,5091,'ra:admin:reviewer','C','审核员',2,'ra-admin-reviewer','ra/admin/index','roleId=504',1,0,'0','0','user','审核员管理菜单'),
  (5094,501,501,'2025-01-01 00:00:00','2026-05-06 14:08:51',1,0,5,5091,'ra:admin:maker','C','制证员',3,'ra-admin-maker','ra/admin/index','roleId=505',1,0,'0','0','user','制证员管理菜单'),
  (5100,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,0,'','M','审计管理',3100,'ra-audit','','',1,0,'0','0','log','审计管理目录'),
  (5101,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5100,'ra:audit','C','审计日志',1,'ra-audit-log','ra/audit/index','',1,0,'0','0','log','审计日志菜单'),
  (5110,501,501,'2025-01-01 00:00:00','2026-05-06 15:08:50',0,0,5,0,'','M','系统管理',3010,'ra-system','','',1,0,'0','0','system','系统管理目录'),
  (5111,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5110,'ra:config','C','系统配置',1,'ra-system-config','ra/config/index','',1,0,'0','0','tool','系统配置菜单'),
  (5112,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,5110,'ra:log','C','操作日志',2,'ra-system-log','ra/log/index','',1,0,'0','0','log','操作日志菜单'),
  (50511,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,5051,'ra:policy:cert:list','F','查询证书策略',1,'','','',1,0,'0','0','','查询RA证书策略'),
  (50512,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,5051,'ra:policy:cert:get','F','查看证书策略',2,'','','',1,0,'0','0','','查看RA证书策略'),
  (50513,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,5051,'ra:policy:cert:save','F','新增证书策略',3,'','','',1,0,'0','0','','新增RA证书策略'),
  (50514,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,5051,'ra:policy:cert:modify','F','修改证书策略',4,'','','',1,0,'0','0','','修改RA证书策略'),
  (50515,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,5051,'ra:policy:cert:remove','F','删除证书策略',5,'','','',1,0,'0','0','','删除RA证书策略'),
  (50516,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,5051,'ra:policy:cert:status','F','启停证书策略',6,'','','',1,0,'0','0','','启停RA证书策略'),
  (50521,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,5052,'platform:security:policy:list','F','查询安全策略',1,'','','',1,0,'0','0','','查询安全策略'),
  (50522,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,5052,'platform:security:policy:get','F','查看安全策略',2,'','','',1,0,'0','0','','查看安全策略'),
  (50523,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,5052,'platform:security:policy:save','F','新增安全策略',3,'','','',1,0,'0','0','','新增安全策略'),
  (50524,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,5052,'platform:security:policy:modify','F','修改安全策略',4,'','','',1,0,'0','0','','修改安全策略'),
  (50525,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,5052,'platform:security:policy:remove','F','删除安全策略',5,'','','',1,0,'0','0','','删除安全策略'),
  (50526,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,5052,'platform:security:policy:status','F','启停安全策略',6,'','','',1,0,'0','0','','启停安全策略'),
  (51111,501,NULL,'2026-05-27 19:17:28',NULL,0,0,5,5111,'ra:config:get','F','读取配置',1,'','','',1,0,'0','0','','读取RA系统配置'),
  (51112,501,NULL,'2026-05-27 19:17:28',NULL,0,0,5,5111,'ra:config:save','F','保存配置',2,'','','',1,0,'0','0','','保存RA系统配置');

-- ----------------------------
-- sys_role (角色)
-- ----------------------------

INSERT INTO `sys_role` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `name`,
  `sort`,
  `data_scope`
) VALUES
  (501,501,NULL,'2025-01-01 00:00:00','2026-05-06 14:08:51',0,0,5,'管理员',1,'no'),
  (502,501,NULL,'2025-01-01 00:00:00','2026-05-06 14:08:51',0,0,5,'审计管理员',2,'no'),
  (503,501,NULL,'2025-01-01 00:00:00','2026-05-06 14:08:51',0,0,5,'录入员',3,'no'),
  (504,501,NULL,'2025-01-01 00:00:00','2026-05-06 14:08:51',0,0,5,'审核员',4,'no'),
  (505,501,NULL,'2025-01-01 00:00:00','2026-05-06 14:08:51',0,0,5,'制证员',5,'no'),
  (506,501,NULL,'2025-01-01 00:00:00','2026-05-06 14:08:51',0,0,5,'审计员',6,'no');

-- ----------------------------
-- sys_user (基础用户)
-- ----------------------------

INSERT INTO `sys_user` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `dept_id`,
  `username`,
  `password`,
  `super_admin`,
  `mail`,
  `mobile`,
  `status`,
  `avatar`,
  `cert_sn`,
  `cert_pem`,
  `username_phrase`,
  `mail_phrase`,
  `mobile_phrase`
) VALUES
  (501,501,501,'2025-01-01 00:00:00','2026-05-25 06:40:39',0,0,5,501,'Ylh4QTF0YmdEWWJRimFMPGaJmldyuWIb9BNmUN1ULMI7','{bcrypt}$2a$10$A8JXnpHivwN4vfSgAROfmO4yx6nnYupP6TwYederuqe5SwhWlUFtG',0,NULL,NULL,0,NULL,NULL,'-----BEGIN CERTIFICATE-----\r\nMIICSTCCATGgAwIBAgIIYjXB3xtFfaYwDQYJKoZIhvcNAQELBQAwTzELMAkGA1UE\nBhMCQ04xDjAMBgNVBAoMBUxpdVpYMQswCQYDVQQLDAJDQTEjMCEGA1UEAwwaUlNB\nIFJvb3QgQ0EgMjAyNjA1MjAxNDExMDMwHhcNMjYwNTI0MjI0MDE1WhcNMjcwNTI0\nMjI0MDE1WjBFMQ4wDAYDVQQDDAVhZG1pbjESMBAGA1UECwwJ566h55CG5ZGYMRIw\nEAYDVQQKDAlMaXVaWCBQS0kxCzAJBgNVBAYTAkNOMFkwEwYHKoZIzj0CAQYIKoEc\nz1UBgi0DQgAEK9NAg5ptGhl145tKcRdu/7ErHpHPk4f3VbMTwQvtahwTszjURFWv\nR4oPvSZESf9Xim9fyq9al9oMGO5Wyqgc/jANBgkqhkiG9w0BAQsFAAOCAQEAWuoN\nACN8CNCwYKEOdWcMPZ1qFs5KzoDonBwGe0qwU+WNK74yBDxMPM88aAZWYgEO91x+\nv5K6ftjAbfXPaSshumj0QVU92jr1bQRJPlXA0zA75qWfT6AnamHtIiOAZc6Eicoz\nEyYZp1IgUcX+nuOPmS8Wmt4JdN5DCLNn6MLoWs70soLE3apy57IfIlB9Q0gD/UN9\nNIbAiQxcirzlxwoXT+4ZjzPPFuss4qtiqrxCEZfVyn9sfcZgvWHx4nLXQvKANwrP\nGmrYv10N7Tp8rYhYISrd11DhuCm1iEZ0rfxzUo64b0/tRQyO5hO9Z/I3V/Eka655\nNrUxVMhxinVaiCXXmA==\r\n-----END CERTIFICATE-----\r\n',NULL,NULL,NULL),
  (502,501,501,'2025-01-01 00:00:00','2026-05-25 06:40:39',0,0,5,501,'Ylh4QTF0YmdEWWJRinBFPHwJphga8mvCiz5iIvhHZ+f/0Fg=','{bcrypt}$2a$10$RGXfLPUALDmlcluSYltYXOD0yO5H9E74QdM9cdgeBcYooVbIza3gW',0,NULL,NULL,0,NULL,NULL,'-----BEGIN CERTIFICATE-----\r\nMIICSzCCATOgAwIBAgIIYgDXGkLEosMwDQYJKoZIhvcNAQELBQAwTzELMAkGA1UE\nBhMCQ04xDjAMBgNVBAoMBUxpdVpYMQswCQYDVQQLDAJDQTEjMCEGA1UEAwwaUlNB\nIFJvb3QgQ0EgMjAyNjA1MjAxNDExMDMwHhcNMjYwNTI0MjI0MDI5WhcNMjcwNTI0\nMjI0MDI5WjBHMRAwDgYDVQQDDAdhdWRpdG9yMRIwEAYDVQQLDAnlrqHorqHlkZgx\nEjAQBgNVBAoMCUxpdVpYIFBLSTELMAkGA1UEBhMCQ04wWTATBgcqhkjOPQIBBggq\ngRzPVQGCLQNCAAS+LOe8fYSllwKIzgzRjV/13juUMcUrYlXaglbw2G23ISu9vD4g\nA9+qwGzzz/pawjNWypeWu9tYz0NkUIly5GDLMA0GCSqGSIb3DQEBCwUAA4IBAQAL\nAfgIusTNB7zRrnRou1jpVAicAuiqrxLRPFFTavDpSAdLM5ygSSz5x25oFgX6glO4\n8GgUjvFYIXTfGkEQm4hxRufxUvOEv/+bd94vxys5KL93TgHWVK8vgQDhjELoWnGk\nB3zz0NVNrnmcU7p1F0XU8sOXX93RbC9/2k/5E+Uv26i1ghn2O2b2lN6fiHBg1ZQ9\nZMdbgu5b4HXRu4Wj7OajKxhDcCtzNxAwkRPrtpnW+oM1vGvAZ0GFzzmewlxj8RVu\nhWx9DpksBrrYS/dr7X7j3O/szY74/ffoeIPZztuQtPt1iu1j2y5EmsYmL90EZdxe\nudOkMECB0hgXcKITYLEz\r\n-----END CERTIFICATE-----\r\n',NULL,NULL,NULL);

-- ----------------------------
-- sys_role_dept (角色部门关系)
-- ----------------------------

INSERT INTO `sys_role_dept` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `role_id`,
  `dept_id`
) VALUES
  (405,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,501);

-- ----------------------------
-- sys_role_menu (角色菜单关系)
-- ----------------------------

INSERT INTO `sys_role_menu` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `role_id`,
  `menu_id`
) VALUES
  (590,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5042),
  (591,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5043),
  (592,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5044),
  (593,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5045),
  (594,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5046),
  (595,501,NULL,'2026-05-27 19:17:28',NULL,0,0,5,501,51111),
  (596,501,NULL,'2026-05-27 19:17:28',NULL,0,0,5,501,51112),
  (597,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,501,50511),
  (598,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,501,50512),
  (599,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,501,50513),
  (600,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,501,50514),
  (601,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,501,50515),
  (602,501,NULL,'2026-05-27 20:31:03',NULL,0,0,5,501,50516),
  (603,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,501,50521),
  (604,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,501,50522),
  (605,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,501,50523),
  (606,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,501,50524),
  (607,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,501,50525),
  (608,501,NULL,'2026-05-27 00:00:00',NULL,0,0,5,501,50526),
  (1212,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5090),
  (1213,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5091),
  (1214,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5020),
  (1215,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5021),
  (1218,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5050),
  (1219,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5051),
  (1220,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5052),
  (1221,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5060),
  (1222,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5061),
  (1223,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5070),
  (1224,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5071),
  (1225,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5072),
  (1226,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5073),
  (1227,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5080),
  (1228,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5081),
  (1229,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5082),
  (1230,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5083),
  (1231,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5110),
  (1232,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5111),
  (1233,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,502,5100),
  (1234,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,502,5101),
  (1235,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,502,5110),
  (1236,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,502,5112),
  (1250,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,3),
  (1251,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,30),
  (1252,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,31),
  (1253,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,5080),
  (1254,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,5081),
  (1255,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,5082),
  (1256,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,5083),
  (1257,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,5100),
  (1258,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,506,5101),
  (1452,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5040),
  (1453,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,5041),
  (1628,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5010),
  (1629,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5011),
  (1630,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5012),
  (1631,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5030),
  (1632,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5031),
  (1633,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5040),
  (1634,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5041),
  (1635,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5042),
  (1636,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5043),
  (1637,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,503,5044),
  (1638,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5010),
  (1639,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5012),
  (1640,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5060),
  (1641,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5062),
  (1642,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5063),
  (1643,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5080),
  (1644,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5081),
  (1645,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5082),
  (1646,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,504,5083),
  (1647,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5010),
  (1648,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5012),
  (1649,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5013),
  (1650,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5014),
  (1651,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5015),
  (1652,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5016),
  (1653,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5017),
  (1654,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5018),
  (1655,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5080),
  (1656,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5081),
  (1657,501,NULL,'2026-06-03 08:28:06','2026-06-03 08:28:06',0,0,5,505,5083),
  (1659,501,NULL,'2026-06-03 11:22:16','2026-06-03 11:22:16',0,0,5,505,5019);

-- ----------------------------
-- sys_user_dept (用户部门关系)
-- ----------------------------

INSERT INTO `sys_user_dept` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `user_id`,
  `dept_id`
) VALUES
  (501,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,501),
  (502,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,502,501);

-- ----------------------------
-- sys_user_role (用户角色关系)
-- ----------------------------

INSERT INTO `sys_user_role` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `user_id`,
  `role_id`
) VALUES
  (90017,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,501,501),
  (90018,501,NULL,'2025-01-01 00:00:00',NULL,0,0,5,502,502);

SET FOREIGN_KEY_CHECKS = 1;
