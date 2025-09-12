-- =============================================
-- config_info_tag 表 - 标签配置信息表
-- =============================================

USE nacos_config;

CREATE TABLE config_info_tag (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  data_id varchar(255) NOT NULL COMMENT 'data_id',
  group_id varchar(128) NOT NULL COMMENT 'group_id',
  tenant_id varchar(128) DEFAULT '' COMMENT 'tenant_id',
  tag_id varchar(128) NOT NULL COMMENT 'tag_id',
  app_name varchar(128) DEFAULT NULL COMMENT 'app_name',
  content longtext NOT NULL COMMENT 'content',
  md5 varchar(32) DEFAULT NULL COMMENT 'md5',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  src_user text COMMENT 'source user',
  src_ip varchar(50) DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (id),
  UNIQUE KEY uk_configinfotag_datagrouptenanttag (data_id,group_id,tenant_id,tag_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_tag';