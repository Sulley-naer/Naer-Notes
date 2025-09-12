-- =============================================
-- config_info_gray 表 - 灰度配置信息表
-- =============================================

USE nacos_config;

CREATE TABLE config_info_gray (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  data_id varchar(255) NOT NULL COMMENT 'data_id',
  group_id varchar(128) NOT NULL COMMENT 'group_id',
  tenant_id varchar(128) DEFAULT '' COMMENT 'tenant_id',
  app_name varchar(128) DEFAULT NULL COMMENT 'app_name',
  content longtext NOT NULL COMMENT 'content',
  md5 varchar(32) DEFAULT NULL COMMENT 'md5',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  src_user text COMMENT 'source user',
  src_ip varchar(50) DEFAULT NULL COMMENT 'source ip',
  gray_name varchar(128) DEFAULT NULL COMMENT '灰度名称',
  gray_rule text COMMENT '灰度规则',
  encrypted_data_key text NOT NULL COMMENT '秘钥',
  PRIMARY KEY (id),
  UNIQUE KEY uk_configinfogray_datagrouptenant (data_id,group_id,tenant_id,gray_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_gray';