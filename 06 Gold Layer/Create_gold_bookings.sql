-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: To have a Table for all the Bookings in Gold Layer
-- =====================================================


-- Why are we doing this?
-- Silver contains cleaned and transformed data.
-- Gold provides a business-ready table for reporting and analytics.

CREATE OR REPLACE TABLE gold_bookings AS
SELECT *
FROM silver_hotel_bookings;

-- Let's Verify
SELECT *
FROM gold_bookings
LIMIT 10;
