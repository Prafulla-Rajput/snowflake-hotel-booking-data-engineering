/*
PROJECT: Hotel Booking Data Engineering & Analytics

PURPOSE:
This script contains the SQL queries used to power the KPI cards
and visualizations in the Hotel Bookings - Analysis Dashboard.
The queries retrieve business insights from the Gold layer tables
created in the Snowflake data pipeline.
*/

-- ==========================================
-- KPI CARDS
-- ==========================================

-- 1. Total Revenue (₹)
SELECT 
    SUM(total_amount_inr) AS total_revenue
FROM hotel_db.booking_data.gold_bookings
WHERE booking_status != 'Cancelled';


-- 2. Total Bookings
SELECT 
    COUNT(*) AS total_bookings
FROM hotel_db.booking_data.gold_bookings;


-- 3. Average Booking Value (₹)
SELECT 
    AVG(total_amount_inr) AS Average_bookings
FROM hotel_db.booking_data.gold_bookings
WHERE booking_status != 'Cancelled';


-- 4. Total Guests
SELECT 
    SUM(num_guests) AS total_guests
FROM hotel_db.booking_data.gold_bookings;



-- ==========================================
-- DASHBOARD VISUALIZATIONS
-- ==========================================

-- 5. Monthly Revenue
SELECT 
    check_in_date AS month,
    total_revenue_inr
FROM hotel_db.booking_data.gold_agg_bookings_revenue; -- Grouping by Month is handled in SNowflake Dashboard options


-- 6. Monthly Bookings
SELECT 
    check_in_date AS month,
    total_bookings
FROM hotel_db.booking_data.gold_agg_bookings_revenue; -- Grouping by Month is handled in SNowflake Dashboard options


-- 7. Revenue by City
SELECT 
    hotel_city AS city,
    total_revenue_inr AS "TOTAL REVENUE"
FROM hotel_db.booking_data.gold_agg_city_bookings_revenue
WHERE total_revenue_inr IS NOT NULL
ORDER BY total_revenue_inr DESC
LIMIT 5; -- Showing revenue for only Top 5 cities


-- 8. Bookings by City
SELECT 
    hotel_city AS city,
    total_bookings AS bookings
FROM hotel_db.booking_data.gold_agg_city_bookings_revenue
ORDER BY total_bookings DESC
LIMIT 5; -- Showing bookings for only Top 5 cities


-- 9. Bookings by Room Type
SELECT 
    room_type,
    COUNT(*) AS total_bookings
FROM hotel_db.booking_data.gold_bookings
WHERE room_type IS NOT NULL
GROUP BY room_type
ORDER BY total_bookings DESC; 


-- 10. Bookings by Status
SELECT 
    booking_status,
    COUNT(*) AS bookings
FROM hotel_db.booking_data.gold_bookings
WHERE booking_status IS NOT NULL
GROUP BY booking_status
ORDER BY bookings DESC;
