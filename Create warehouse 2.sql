-- Create warehouse
{# CREATE WAREHOUSE IF NOT EXISTS compute_wh
    WITH WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE; #}

-- Create database
CREATE DATABASE IF NOT EXISTS predictit;

CREATE ROLE IF NOT EXISTS de_predictit;
GRANT ROLE de_predictit TO ROLE ACCOUNTADMIN;

GRANT OPERATE ON WAREHOUSE compute_wh TO ROLE de_predictit; 

GRANT ROLE de_predictit TO USER dbt; 

CREATE SCHEMA IF NOT EXISTS predictit.raw;


GRANT ALL PRIVILEGES ON SCHEMA predictit.raw TO ROLE de_predictit;
GRANT ALL ON DATABASE predictit TO ROLE de_predictit; 
GRANT ALL ON SCHEMA predictit.raw TO ROLE de_predictit;
GRANT ALL ON FUTURE TABLES IN SCHEMA predictit.raw TO ROLE de_predictit;
GRANT ALL ON FUTURE VIEWS IN SCHEMA predictit.raw TO ROLE de_predictit;
GRANT ALL ON FUTURE SCHEMAS IN DATABASE predictit TO ROLE de_predictit;
GRANT TRANSFORM ON SCHEMA predictit.raw TO ROLE de_predictit;
