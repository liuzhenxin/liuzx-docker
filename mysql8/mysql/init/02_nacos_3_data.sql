USE lcloud_platform_nacos_3;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`username`, `password`, `enabled`) VALUES ('liuzx', '$2a$10$75WIn2J5FoX9F5wEBdFsL.0cKdv5h8QqBMKMWBABhWAxKB4TO8WZq', 0);
INSERT INTO `users` (`username`, `password`, `enabled`) VALUES ('nacos', '$2a$10$oVX1zRtaql9Jbsyzaaovx.TU2M6Bw0ZpCbPYWOIED58d1ougzaFRm', 0);
COMMIT;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
BEGIN;
INSERT INTO `tenant_info` (`id`, `kp`, `tenant_id`, `tenant_name`, `tenant_desc`, `create_source`, `gmt_create`, `gmt_modified`) VALUES (1, '2', 'nacos-default-mcp', 'nacos-default-mcp', 'Nacos default AI MCP module.', 'nacos', 1747555499268, 1747555499268);
INSERT INTO `tenant_info` (`id`, `kp`, `tenant_id`, `tenant_name`, `tenant_desc`, `create_source`, `gmt_create`, `gmt_modified`) VALUES (2, '1', '0dac1a68-2f01-40df-bd26-bf0cb199057a', 'dev', 'dev', 'nacos', 1716631648356, 1716631648356);
INSERT INTO `tenant_info` (`id`, `kp`, `tenant_id`, `tenant_name`, `tenant_desc`, `create_source`, `gmt_create`, `gmt_modified`) VALUES (3, '1', 'a61abd4c-ef96-42a5-99a1-616adee531f3', 'test', 'test', 'nacos', 1673556960289, 1716628319164);
INSERT INTO `tenant_info` (`id`, `kp`, `tenant_id`, `tenant_name`, `tenant_desc`, `create_source`, `gmt_create`, `gmt_modified`) VALUES (4, '1', '8140e92b-fb43-48f5-b63b-7506185206a5', 'prod', 'prod', 'nacos', 1716631657328, 1716631657328);
COMMIT;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` (`username`, `role`) VALUES ('liuzx', 'ADMIN');
INSERT INTO `roles` (`username`, `role`) VALUES ('nacos', 'ROLE_ADMIN');
COMMIT;

-- ----------------------------
-- Records of permissions
-- ----------------------------
BEGIN;
INSERT INTO `permissions` (`role`, `resource`, `action`) VALUES ('ADMIN', ':*:*', 'rw');
INSERT INTO `permissions` (`role`, `resource`, `action`) VALUES ('ADMIN', 'a61abd4c-ef96-42a5-99a1-616adee531f3:*:*', 'rw');
INSERT INTO `permissions` (`role`, `resource`, `action`) VALUES ('ROLE_ADMIN', ':*:*', 'rw');
INSERT INTO `permissions` (`role`, `resource`, `action`) VALUES ('ROLE_ADMIN', 'a61abd4c-ef96-42a5-99a1-616adee531f3:*:*', 'rw');
COMMIT;


INSERT INTO `config_info` (id, data_id, group_id, content, md5, gmt_create, gmt_modified, src_user, src_ip, app_name, tenant_id, c_desc, c_use, effect, type, c_schema, encrypted_data_key) values (26, 'router.json', 'LIUZX_GROUP', '[
  {
    "id": "liuzx-auth",
    "uri": "lb://liuzx-auth",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/auth/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "auth",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/auth/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-admin",
    "uri": "lb://liuzx-admin",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/admin/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "admin",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/admin/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-ca",
    "uri": "lb://liuzx-ca",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/ca/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "ca",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/ca/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-kmc",
    "uri": "lb://liuzx-kmc",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/kmc/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "kmc",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/kmc/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  }
]
', '46227cc6722377f03d3f77f576e4016a', '2024-05-25 18:13:33', '2026-04-21 17:33:54', 'nacos', '172.20.0.1', 'liuzx-gateway', '0dac1a68-2f01-40df-bd26-bf0cb199057a', '动态路由配置', null, null, 'json', null, '');
INSERT INTO `config_info` (id, data_id, group_id, content, md5, gmt_create, gmt_modified, src_user, src_ip, app_name, tenant_id, c_desc, c_use, effect, type, c_schema, encrypted_data_key) values (30, 'router.json', 'LIUZX_GROUP', '[
  {
    "id": "liuzx-auth",
    "uri": "lb://liuzx-auth",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/auth/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "auth",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/auth/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-admin",
    "uri": "lb://liuzx-admin",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/admin/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "admin",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/admin/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-ca",
    "uri": "lb://liuzx-ca",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/ca/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "ca",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/ca/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-kmc",
    "uri": "lb://liuzx-kmc",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/kmc/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "kmc",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/kmc/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  }
]
', '46227cc6722377f03d3f77f576e4016a', '2023-01-13 15:44:25', '2026-04-21 17:38:45', 'nacos', '172.20.0.1', 'liuzx-gateway', 'a61abd4c-ef96-42a5-99a1-616adee531f3', '', null, null, 'json', null, '');
INSERT INTO `config_info` (id, data_id, group_id, content, md5, gmt_create, gmt_modified, src_user, src_ip, app_name, tenant_id, c_desc, c_use, effect, type, c_schema, encrypted_data_key) values (31, 'router.json', 'LIUZX_GROUP', '[
  {
    "id": "liuzx-auth",
    "uri": "lb://liuzx-auth",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/auth/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "auth",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/auth/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-admin",
    "uri": "lb://liuzx-admin",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/admin/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "admin",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/admin/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-ca",
    "uri": "lb://liuzx-ca",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/ca/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "ca",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/ca/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-kmc",
    "uri": "lb://liuzx-kmc",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/kmc/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "kmc",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/kmc/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  }
]
', '46227cc6722377f03d3f77f576e4016a', '2024-05-25 18:13:11', '2026-04-21 17:38:33', 'nacos', '172.20.0.1', 'liuzx-gateway', '8140e92b-fb43-48f5-b63b-7506185206a5', '动态路由配置', null, null, 'json', null, '');
INSERT INTO `config_info` (id, data_id, group_id, content, md5, gmt_create, gmt_modified, src_user, src_ip, app_name, tenant_id, c_desc, c_use, effect, type, c_schema, encrypted_data_key) values (214, 'test.yaml', 'DEFAULT_GROUP', 'test: 123', '5e76b5e94b54e1372f8b452ef64dc55c', '2025-03-24 20:47:39', '2025-03-24 20:47:39', 'nacos', '0:0:0:0:0:0:0:1', '', '', null, null, null, 'yaml', null, '');

SET FOREIGN_KEY_CHECKS = 1;


-- 同步网关动态路由：兼容 /api/ca/** -> /api/**，避免全新初始化后手工访问 /api/ca/** 返回 404。
SET @gateway_router_json = '[
  {
    "id": "liuzx-auth",
    "uri": "lb://liuzx-auth",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/auth/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "auth",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/auth/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-admin",
    "uri": "lb://liuzx-admin",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/admin/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "admin",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/admin/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-ca",
    "uri": "lb://liuzx-ca",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/ca/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "ca",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/ca/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-ca-api",
    "uri": "lb://liuzx-ca",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api/ca/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "ca-api",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api/ca/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-kmc",
    "uri": "lb://liuzx-kmc",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/kmc/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "kmc",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/kmc/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  },
  {
    "id": "liuzx-nas",
    "uri": "lb://liuzx-nas",
    "predicates": [
      {
        "name": "Path",
        "args": {
          "pattern": "/api-gateway/nas/**"
        }
      },
      {
        "name": "Weight",
        "args": {
          "_genkey_0": "nas",
          "_genkey_1": "100"
        }
      }
    ],
    "filters": [
      {
        "name": "RewritePath",
        "args": {
          "_genkey_0": "/api-gateway/nas/(?<path>.*)",
          "_genkey_1": "/api/${path}"
        }
      }
    ],
    "metadata": {
      "version": "v1"
    },
    "order": 1
  }
]
';
UPDATE `config_info`
SET `content` = @gateway_router_json,
    `md5` = '110b6c4cbae6c1541cb35b8388eb2710',
    `gmt_modified` = NOW()
WHERE `data_id` = 'router.json'
  AND `group_id` = 'LIUZX_GROUP';
