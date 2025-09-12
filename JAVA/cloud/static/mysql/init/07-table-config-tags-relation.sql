-- =============================================
-- config_tags_relation 表 - 配置标签关系表
-- =============================================

USE nacos_config;

CREATE TABLE config_tags_relation (
  id bigint(20) NOT NULL COMMENT 'id',
  tag_name varchar(128) NOT NULL COMMENT 'tag_name',
  tag_type varchar(64) DEFAULT NULL COMMENT 'tag_type',
  data_id varchar(255) NOT NULL COMMENT 'data_id',
  group_id varchar(128) NOT NULL COMMENT 'group_id',
  tenant_id varchar(128) DEFAULT '' COMMENT 'tenant_id',
  nid bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'nid, 自增长标识',
  PRIMARY KEY (nid),
  UNIQUE KEY uk_configtagrelation_configidtag (id,tag_name,tag_type),
  KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_tag_relation';