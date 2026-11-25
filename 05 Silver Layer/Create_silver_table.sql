-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Create Silver Layer Table
-- =====================================================

CREATE TABLE TABLE IF NOT EXISTS silver_hotel_bookings(
    booking_id VARCHAR,
    hotel_id INT,
    hotel_city VARCHAR(50),
    customer_id VARCHAR,
    customer_name VARCHAR(50),
    customer_email VARCHAR(100),
    check_in_date DATE,
    check_out_date DATE,
    room_type VARCHAR(20),
    num_guests INT,
    total_amount DECIMAL,
    currency VARCHAR(10),
    total_amount_inr DECIMAL,
    booking_status VARCHAR
);
