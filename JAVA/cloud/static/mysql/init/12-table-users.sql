-- =============================================
-- users 表 - 用户表
-- =============================================

USE nacos_config;

CREATE TABLE users (
  username varchar(50) NOT NULL COMMENT 'username',
  password varchar(500) NOT NULL COMMENT 'password',
  enabled tinyint(1) NOT NULL COMMENT 'enabled',
  PRIMARY KEY (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;