-- =============================================
-- MySQL 数据库初始化脚本
-- 创建数据库和用户
-- =============================================

-- 创建 nacos_config 数据库
CREATE DATABASE IF NOT EXISTS nacos_config DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 创建 nacos 用户并授权
CREATE USER IF NOT EXISTS 'nacos'@'%' IDENTIFIED BY 'nacos';
GRANT ALL PRIVILEGES ON nacos_config.* TO 'nacos'@'%';
FLUSH PRIVILEGES;

-- 使用 nacos_config 数据库
USE nacos_config;