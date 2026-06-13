/*
 LiuZX License 数据库表结构脚本

 说明: 创建 License 业务库 lcloud_license_4 表结构
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `lcloud_license_4`;

-- ----------------------------
-- Table structure for license_customer
-- ----------------------------
CREATE TABLE IF NOT EXISTS `license_customer` (
  `id` bigint NOT NULL COMMENT 'ID',
  `creator` bigint NOT NULL COMMENT '创建人',
  `editor` bigint COMMENT '编辑人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `del_flag` tinyint NOT NULL COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL COMMENT '版本号',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `name` varchar(100) NOT NULL COMMENT '客户名称',
  `contact` varchar(50) NOT NULL COMMENT '联系人',
  `phone` varchar(50) COMMENT '电话',
  `email` varchar(100) COMMENT '邮件',
  `remark` varchar(1000) COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '客户信息表';

-- ----------------------------
-- Table structure for license_product
-- ----------------------------
CREATE TABLE IF NOT EXISTS `license_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `name` varchar(100) NOT NULL COMMENT '产品名称',
  `product_version` varchar(50) NOT NULL COMMENT '版本',
  `remark` varchar(1000) COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='软件产品表';

-- ----------------------------
-- Table structure for license_biz
-- ----------------------------
CREATE TABLE IF NOT EXISTS `license_biz` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `customer_id` bigint NOT NULL DEFAULT '0' COMMENT '客户ID',
  `product_id` bigint NOT NULL DEFAULT '0' COMMENT '产品ID',
  `license` varchar(500) NULL COMMENT '许可证数据',
  `issued_time` datetime NULL COMMENT '颁布时间',
  `expir_time` datetime NULL COMMENT '到期时间',
  `status` varchar(2) NOT NULL COMMENT '状态 0:未激活,1:正常,2:过期',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='许可证表';

-- ----------------------------
-- Table structure for license_data
-- ----------------------------
CREATE TABLE IF NOT EXISTS `license_data` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `license_id` bigint NOT NULL DEFAULT '0' COMMENT '许可证ID',
  `uuid` varchar(100) COMMENT '系统uuid全局唯一',
  `cpuid` varchar(100) COMMENT '可被允许的CPU序列号',
  `main_board_serial` varchar(100) COMMENT '可被允许的主板序列号',
  `extra` varchar(500) NULL DEFAULT NULL COMMENT '扩展信息K,V结构',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='许可证数据表';

-- ----------------------------
-- Table structure for license_test
-- ----------------------------
CREATE TABLE IF NOT EXISTS `license_test` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `creator` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `editor` bigint DEFAULT NULL COMMENT '编辑人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标识 0未删除 1已删除',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  `test_name` varchar(100) NOT NULL COMMENT '测试名称',
  `test_value` varchar(255) DEFAULT NULL COMMENT '测试值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='测试表';

SET FOREIGN_KEY_CHECKS = 1;
