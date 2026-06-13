/*
 LiuZX KMC 数据库初始化数据脚本

 说明: 初始化 KMC 基础 CA 机构和备用密钥池策略，不包含密钥池和已用密钥等运行期数据
 执行方式:
 mysql -u root -p lcloud_kmc_4 < 02_kmc_4_data.sql
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `lcloud_kmc_4`;

-- ----------------------------
-- 清理旧基础数据
-- ----------------------------
DELETE FROM `kmc_pool_strategy` WHERE `tenant_id` = 3;
DELETE FROM `kmc_ca` WHERE `tenant_id` = 3;

-- ----------------------------
-- 1. kmc_ca (CA机构)
-- ----------------------------
INSERT INTO `kmc_ca` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `name`,
  `type`,
  `status`,
  `communication_cert_pem`,
  `cert_subject`,
  `cert_issuer`,
  `cert_serial_number`,
  `cert_not_before`,
  `cert_not_after`,
  `cert_fingerprint_sha256`,
  `description`
) VALUES
  (1,301,301,'2026-05-10 17:41:41','2026-05-15 23:17:37',0,3,3,'CA','ROOT','1','-----BEGIN CERTIFICATE-----\nMIICwjCCAmigAwIBAgIGAZ39nPDeMAoGCCqBHM9VAYN1MEMxCzAJBgNVBAYTAkNO\nMQ4wDAYDVQQKDAVMaXVaWDEMMAoGA1UECwwDUEtJMRYwFAYDVQQDDA1MaXVaWCBS\nb290IENBMB4XDTI2MDUwNjE0MDY1NFoXDTMxMDUwNjE0MDY1NFowQDELMAkGA1UE\nBhMCQ04xDjAMBgNVBAoMBUxpdVpYMQswCQYDVQQLDAJDQTEUMBIGA1UEAwwLQ0Eg\nSWRlbnRpdHkwWTATBgcqhkjOPQIBBggqgRzPVQGCLQNCAAQVlCtc92SGigJ4Uuzp\nTGQrhGqZXjMhS0wRYgNOZnXtw6r/XZTv0HoGmdR62kbCtV4qKWvknh7sePGh8UoN\nurS+o4IBSTCCAUUwHQYDVR0OBBYEFHzTo4OCy+D7xfkkuM+Y+qFMCvO3MB8GA1Ud\nIwQYMBaAFFiG1o5WNNybTlgvucN18ESwZcf2MAwGA1UdEwEB/wQCMAAwDgYDVR0P\nAQH/BAQDAgSwMBMGA1UdJQQMMAoGCCsGAQUFBwMBMG0GCCsGAQUFBwEBBGEwXzAp\nBggrBgEFBQcwAoYdaHR0cHM6Ly9teW9yZy5vcmcvcm9vdGNhMS5kZXIwMgYIKwYB\nBQUHMAGGJmh0dHBzOi8vbG9jYWxob3N0OjgwODAvb2NzcC9yZXNwb25kZXIxMEgG\nA1UdHwRBMD8wPaA7oDmGN2h0dHBzOi8vbG9jYWxob3N0OjgwODEvZHVtbXkvY3Js\nLz90eXBlPWNybCZuYW1lPXJvb3RjYTEwFwYIKwYBBQUHARgBAf8ECDAGAgECAgEF\nMAoGCCqBHM9VAYN1A0gAMEUCIQCsl07oyUn6H6TDob7/AkHdl/g0jRus2yn7lNps\nAEKJNQIgUjANIor9UPAUygETsHHy2IOsHh0js5PhYvO6YYK75lg=\n-----END CERTIFICATE-----','CN=CA Identity,OU=CA,O=LiuZX,C=CN','CN=LiuZX Root CA,OU=PKI,O=LiuZX,C=CN','19DFD9CF0DE','2026-05-06 22:06:54','2031-05-06 22:06:54','96ED2B6E650BA6C696956B84C88C169D3B066ADA4C49135DE361F2122B9A12F6','CA机构');

-- ----------------------------
-- 2. kmc_pool_strategy (备用密钥池策略)
-- ----------------------------
INSERT INTO `kmc_pool_strategy` (
  `id`,
  `creator`,
  `editor`,
  `create_time`,
  `update_time`,
  `del_flag`,
  `version`,
  `tenant_id`,
  `alg_type`,
  `key_usage`,
  `low_watermark`,
  `high_watermark`,
  `status`
) VALUES
  (2051486788897292290,90002,301,'2026-05-05 10:19:00','2026-05-10 17:41:41',0,0,3,'SM2','ENCRYPT',5,20,1),
  (2051486788897292291,301,301,'2026-05-10 17:41:41','2026-05-10 17:41:41',0,0,3,'SM2','SIGN',5,20,1),
  (2051486788897292293,301,301,'2026-05-10 17:41:41','2026-05-10 17:41:41',0,0,3,'RSA2048','SIGN',5,20,1);

SET FOREIGN_KEY_CHECKS = 1;
