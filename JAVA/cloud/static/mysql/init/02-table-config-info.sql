-- =============================================
-- config_info 表 - 配置信息主表
-- =============================================

USE nacos_config;

CREATE TABLE config_info (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  data_id varchar(255) NOT NULL COMMENT 'data_id',
  group_id varchar(128) DEFAULT NULL COMMENT 'group_id',
  content longtext NOT NULL COMMENT 'content',
  md5 varchar(32) DEFAULT NULL COMMENT 'md5',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  src_user text COMMENT 'source user',
  src_ip varchar(50) DEFAULT NULL COMMENT 'source ip',
  app_name varchar(128) DEFAULT NULL COMMENT 'app_name',
  tenant_id varchar(128) DEFAULT '' COMMENT '租户字段',
  c_desc varchar(256) DEFAULT NULL COMMENT 'configuration description',
  c_use varchar(64) DEFAULT NULL COMMENT 'configuration usage',
  effect varchar(64) DEFAULT NULL COMMENT '配置生效的描述',
  type varchar(64) DEFAULT NULL COMMENT '配置的类型',
  c_schema text COMMENT '配置的模式',
  encrypted_data_key text NOT NULL COMMENT '秘钥',
  PRIMARY KEY (id),
  UNIQUE KEY uk_configinfo_datagrouptenant (data_id,group_id,tenant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';