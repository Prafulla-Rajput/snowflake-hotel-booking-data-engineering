-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Create the aggregated Gold tables for booking and revenue analysis
-- =====================================================


-- 1. Monthly revenue and monthly booking --> We have to group data by check_in_date
CREATE TABLE gold_agg_bookings_revenue AS
SELECT check_in_date,
        COUNT(*) AS total_bookings,
        SUM(total_amount_inr) AS total_revenue_inr
FROM silver_hotel_bookings
WHERE total_amount_inr IS NOT NULL
GROUP BY check_in_date
ORDER BY check_in_date;


-- Verify
SELECT * 
FROM gold_agg_bookings_revenue;



-- 2. Top cities bookings & Revenue

CREATE TABLE gold_agg_city_bookings_revenue AS
SELECT hotel_city,
        COUNT(*) AS total_bookings,
        SUM(total_amount_inr) AS total_revenue_inr
FROM silver_hotel_bookings
WHERE total_amount_inr IS NOT NULL
GROUP BY hotel_city
ORDER BY total_revenue_inr DESC;


-- Verify
SELECT * 
FROM gold_agg_city_bookings_revenue 
ORDER BY total_revenue_inr DESC 
LIMIT 10;
