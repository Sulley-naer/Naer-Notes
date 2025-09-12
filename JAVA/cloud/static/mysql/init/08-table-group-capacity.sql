-- =============================================
-- group_capacity 表 - 集群、各Group容量信息表
-- =============================================

USE nacos_config;

CREATE TABLE group_capacity (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  group_id varchar(128) NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  quota int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  usage int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  max_size int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  max_aggr_count int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  max_aggr_size int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  max_history_count int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_group_id (group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';