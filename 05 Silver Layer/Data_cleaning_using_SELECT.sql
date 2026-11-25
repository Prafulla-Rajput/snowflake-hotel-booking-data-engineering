-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Transform and Insert Data in Silver Table using SELECT 
-- =====================================================


-- 1. Lets first create a SELECT statement to clean the data
SELECT
    booking_id,
    TRY_TO_NUMBER(hotel_id) AS hotel_id,
    INITCAP(TRIM(hotel_city)) AS hotel_city,
    customer_id,
    INITCAP(TRIM(customer_name)) AS customer_name,
    CASE 
    WHEN customer_email LIKE '%@%.%' 
    THEN customer_email
    ELSE NULL END AS customer_email,
    TRY_TO_DATE(check_in_date) AS check_in_date,
    TRY_TO_DATE(check_out_date) AS check_out_date,
    room_type,
    TRY_TO_NUMBER(num_guests) AS num_guests,
    ABS(total_amount) AS total_amount,
    currency,
    CASE
    WHEN currency = 'INR' THEN ABS(total_amount)
    WHEN currency = 'USD' THEN ABS(total_amount) * 92
    WHEN currency = 'EUR' THEN ABS(total_amount) * 102
    ELSE NULL END AS total_amount_inr,
    CASE 
    WHEN LOWER(booking_status) IN ('confirmeeed', 'confirmed') THEN 'Confirmed'
    ELSE booking_status END AS booking_status
FROM bronze_hotel_bookings
WHERE 
    TRY_TO_DATE(check_in_date) IS NOT NULL 
    AND TRY_TO_DATE(check_out_date) IS NOT NULL
    AND TRY_TO_DATE(check_in_date) < TRY_TO_DATE(check_out_date);



-- 2. Everything is working fine so lets INSERT this data into SILVER layer table
INSERT INTO silver_hotel_bookings
SELECT
    booking_id,
    TRY_TO_NUMBER(hotel_id) AS hotel_id,
    INITCAP(TRIM(hotel_city)) AS hotel_city,
    customer_id,
    INITCAP(TRIM(customer_name)) AS customer_name,
    CASE 
    WHEN customer_email LIKE '%@%.%' 
    THEN customer_email
    ELSE NULL END AS customer_email,
    TRY_TO_DATE(check_in_date) AS check_in_date,
    TRY_TO_DATE(check_out_date) AS check_out_date,
    room_type,
    TRY_TO_NUMBER(num_guests) AS num_guests,
    ABS(total_amount) AS total_amount,
    currency,
    CASE
    WHEN currency = 'INR' THEN ABS(total_amount)
    WHEN currency = 'USD' THEN ABS(total_amount) * 92
    WHEN currency = 'EUR' THEN ABS(total_amount) * 102
    ELSE NULL END AS total_amount_inr,
    CASE 
    WHEN LOWER(booking_status) IN ('confirmeeed', 'confirmed') THEN 'Confirmed'
    ELSE booking_status END AS booking_status
FROM bronze_hotel_bookings
WHERE 
    TRY_TO_DATE(check_in_date) IS NOT NULL 
    AND TRY_TO_DATE(check_out_date) IS NOT NULL
    AND TRY_TO_DATE(check_in_date) < TRY_TO_DATE(check_out_date);
