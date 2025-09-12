-- =============================================
-- 插入默认数据
-- =============================================

USE nacos_config;

-- 插入默认用户 nacos/nacos
INSERT INTO users (username, password, enabled) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

-- 插入默认角色
INSERT INTO roles (username, role) VALUES ('nacos', 'ROLE_ADMIN');