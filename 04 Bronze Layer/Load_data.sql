-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Load CSV Data into Bronze Layer
-- =====================================================

-- Load CSV file into the bronze table

COPY INTO bronze_hotel_bookings
FROM @hotel_bookings_stage
ON_ERROR = CONTINUE;


-- Verify Data
SELECT * 
FROM bronze_hotel_bookings
LIMIT 50;
