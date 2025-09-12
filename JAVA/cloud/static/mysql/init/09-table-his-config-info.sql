-- =============================================
-- his_config_info 表 - 多租户改造
-- =============================================

USE nacos_config;

CREATE TABLE his_config_info (
  id bigint(20) unsigned NOT NULL COMMENT 'id',
  nid bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'nid, 自增长标识',
  data_id varchar(255) NOT NULL COMMENT 'data_id',
  group_id varchar(128) NOT NULL COMMENT 'group_id',
  app_name varchar(128) DEFAULT NULL COMMENT 'app_name',
  content longtext NOT NULL COMMENT 'content',
  md5 varchar(32) DEFAULT NULL COMMENT 'md5',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  src_user text COMMENT 'source user',
  src_ip varchar(50) DEFAULT NULL COMMENT 'source ip',
  op_type char(10) DEFAULT NULL COMMENT 'operation type',
  tenant_id varchar(128) DEFAULT '' COMMENT '租户字段',
  encrypted_data_key text NOT NULL COMMENT '秘钥',
  publish_type varchar(50) DEFAULT NULL COMMENT '发布类型',
  gray_name varchar(128) DEFAULT NULL COMMENT '灰度名称',
  ext_info text DEFAULT NULL COMMENT '扩展信息',
  PRIMARY KEY (nid),
  KEY idx_gmt_create (gmt_create),
  KEY idx_gmt_modified (gmt_modified),
  KEY idx_did (data_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多租户改造';