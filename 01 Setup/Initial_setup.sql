-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Initial Snowflake Environment Setup
-- =====================================================

-- Create Database
CREATE DATABASE hotel_db;

-- Create Schema
CREATE SCHEMA booking_data;


-- Create a warehouse
CREATE WAREHOUSE IF NOT EXISTS booking_data_wh
WAREHOUSE_TYPE = 'Standard'
WAREHOUSE_SIZE = 'x-small'
SCALING_POLICY = 'Standard'
MIN_CLUSTER_COUNT = 1
MAX_CLUSTER_COUNT = 2
AUTO_SUSPEND = 300
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = FALSE;
