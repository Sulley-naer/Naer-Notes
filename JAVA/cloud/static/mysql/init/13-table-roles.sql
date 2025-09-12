-- =============================================
-- roles 表 - 角色表
-- =============================================

USE nacos_config;

CREATE TABLE roles (
  username varchar(50) NOT NULL COMMENT 'username',
  role varchar(50) NOT NULL COMMENT 'role',
  UNIQUE KEY idx_user_role (username,role) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;