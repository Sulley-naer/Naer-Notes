-- =============================================
-- tenant_info 表 - 租户信息表
-- =============================================

USE nacos_config;

CREATE TABLE tenant_info (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  kp varchar(128) NOT NULL COMMENT 'kp',
  tenant_id varchar(128) DEFAULT '' COMMENT 'tenant_id',
  tenant_name varchar(128) DEFAULT '' COMMENT 'tenant_name',
  tenant_desc varchar(256) DEFAULT NULL COMMENT 'tenant_desc',
  create_source varchar(32) DEFAULT NULL COMMENT 'create_source',
  gmt_create bigint(20) NOT NULL COMMENT '创建时间',
  gmt_modified bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_tenant_info_kptenantid (kp,tenant_id),
  KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tenant_info';