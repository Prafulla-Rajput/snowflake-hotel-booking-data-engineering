-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Create Bronze Raw Table
-- =====================================================

-- Store source CSV data in its raw form.
-- STRING data types are used to avoid datatype conversion failures during initial ingestion.
-- Data type validation and conversion are handled in the Silver layer.

CREATE TABLE IF NOT EXISTS bronze_hotel_bookings (
    booking_id STRING,
    hotel_id STRING,
    hotel_city STRING,
    customer_id STRING,
    customer_name STRING,
    customer_email STRING,
    check_in_date STRING,
    check_out_date STRING,
    room_type STRING,
    num_guests STRING,
    total_amount STRING,
    currency STRING,
    booking_status STRING
);
