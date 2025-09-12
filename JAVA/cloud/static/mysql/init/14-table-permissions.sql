-- =============================================
-- permissions 表 - 权限表
-- =============================================

USE nacos_config;

CREATE TABLE permissions (
  role varchar(50) NOT NULL COMMENT 'role',
  resource varchar(255) NOT NULL COMMENT 'resource',
  action varchar(8) NOT NULL COMMENT 'action',
  UNIQUE KEY uk_role_permission (role,resource,action) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;