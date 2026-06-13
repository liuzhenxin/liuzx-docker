/*
 LiuZX RA 数据库初始化数据脚本

 说明: 初始化一条 RA 默认证书策略，适用于所有证书模板
 执行方式:
 mysql -u root -p lcloud_ra_4 < 02_ra_4_data.sql
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `lcloud_ra_4`;

-- ----------------------------
-- 1. ra_cert_policy (默认证书策略)
-- ----------------------------
INSERT INTO `ra_cert_policy` (`id`, `creator`, `editor`, `create_time`, `update_time`, `del_flag`, `version`, `tenant_id`, `policy_oid`, `policy_name`, `policy_description`, `policy_rules`, `approval_required`, `policy_status`)
VALUES
(1,501,501,'2026-05-10 22:41:39','2026-05-27 20:31:03',0,0,5,'1.3.6.1.4.1.55555.5.1','RA默认注册策略','RA初始化默认注册策略，适用于所有证书模板','{"certUsages":["generic"],"keyAlgorithms":["RSA-2048","RSA-3072","RSA-4096","SM2P256V1"],"validity":{"minDays":1,"defaultDays":365,"maxDays":3650},"approvalRequired":true,"profileScope":"all"}',1,1);

SET FOREIGN_KEY_CHECKS = 1;
