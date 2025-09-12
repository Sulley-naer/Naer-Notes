-- =============================================
-- config_info_aggr 表 - 聚合配置信息表
-- =============================================

USE nacos_config;

CREATE TABLE config_info_aggr (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  data_id varchar(255) NOT NULL COMMENT 'data_id',
  group_id varchar(128) NOT NULL COMMENT 'group_id',
  datum_id varchar(255) NOT NULL COMMENT 'datum_id',
  content longtext NOT NULL COMMENT '内容',
  gmt_modified datetime NOT NULL COMMENT '修改时间',
  app_name varchar(128) DEFAULT NULL COMMENT 'app_name',
  tenant_id varchar(128) DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (id),
  UNIQUE KEY uk_configinfoaggr_datagrouptenantdatum (data_id,group_id,tenant_id,datum_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增加租户字段';