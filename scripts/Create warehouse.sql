-- Create warehouse
CREATE WAREHOUSE IF NOT EXISTS compute_wh
    WITH WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE;

-- Create database
CREATE DATABASE IF NOT EXISTS predictit;

-- Create role
CREATE ROLE IF NOT EXISTS de_predictit;

-- Create user
CREATE USER IF NOT EXISTS dbt_predictit
    PASSWORD = 'dbtPassword123'  -- Remember to change this!
    DEFAULT_ROLE = de_predictit
    DEFAULT_WAREHOUSE = compute_wh;

-- Grant role to user
GRANT ROLE de_predictit TO USER dbt_predictit;

-- Grant warehouse access
GRANT USAGE ON WAREHOUSE compute_wh TO ROLE de_predictit;

-- Database permissions
GRANT USAGE ON DATABASE predictit TO ROLE de_predictit;
GRANT CREATE SCHEMA ON DATABASE predictit TO ROLE de_predictit;

-- Grant future permissions for schemas
USE DATABASE predictit;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE predictit TO ROLE de_predictit;
GRANT CREATE TABLE ON FUTURE SCHEMAS IN DATABASE predictit TO ROLE de_predictit;
GRANT CREATE VIEW ON FUTURE SCHEMAS IN DATABASE predictit TO ROLE de_predictit;
GRANT CREATE STAGE ON FUTURE SCHEMAS IN DATABASE predictit TO ROLE de_predictit;
GRANT CREATE PIPE ON FUTURE SCHEMAS IN DATABASE predictit TO ROLE de_predictit;
GRANT CREATE SEQUENCE ON FUTURE SCHEMAS IN DATABASE predictit TO ROLE de_predictit;

-- Create default schema and grant permissions
CREATE SCHEMA IF NOT EXISTS predictit.raw;
GRANT USAGE ON SCHEMA predictit.raw TO ROLE de_predictit;
GRANT ALL PRIVILEGES ON SCHEMA predictit.raw TO ROLE de_predictit;

-- Grant future permissions on tables and views in raw schema
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON FUTURE TABLES IN SCHEMA predictit.raw TO ROLE de_predictit;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA predictit.raw TO ROLE de_predictit;

-- Monitor grants
GRANT MONITOR ON DATABASE predictit TO ROLE de_predictit;
GRANT MONITOR ON WAREHOUSE compute_wh TO ROLE de_predictit;