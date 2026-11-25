-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Explore and Profile Bronze Data
-- =====================================================


-- 1. Now lets check CUSTOMER_EMAIL column to understand the values stored in it as we can see invalied-email
SELECT customer_email
FROM bronze_hotel_bookings
WHERE customer_email NOT LIKE '%@%.%'
OR customer_email IS NULL
OR customer_email = '';


-- 2. We can see total amount column has negative values, lets understand the conditions there
SELECT total_amount
FROM bronze_hotel_bookings
WHERE total_amount < 0; -- 176 records shows negative values


-- 3. It seems the date column has some inconsistancies lets check those
SELECT check_in_date
FROM bronze_hotel_bookings
WHERE check_in_date LIKE '%-%-%'; -- 194 records have different date separators


-- 4. Lets verify same for check-out-date
SELECT check_out_date
FROM bronze_hotel_bookings
WHERE check_out_date LIKE '%-%-%'; -- 0 records have different date separators


-- 5. Check if Check_in_date > check_out_date
SELECT check_in_date, check_out_date
FROM bronze_hotel_bookings
WHERE TRY_TO_DATE(check_in_date) > TRY_TO_DATE(check_out_date); -- 71 records

-- It seems the dates have way more difference than normal, so we may drop this as these will add inaccuracies in our data


-- 6. It seems there are some typos in booking_status field, lets see
SELECT booking_status, COUNT(*)
FROM bronze_hotel_bookings
GROUP BY 1; 
-- Confirmed (588), No-Show (559), NULL (3), Confirmeeed (227), Cancelled(623)


-- We have 3 different currencies, so we need to normalise to one currency to get the final revenue, so we will convert those to INR using today's rate i.e. 1 USD = 92 Rs and 1 EUR = 102 Rs
SELECT currency, SUM(total_amount) AS total_revenue
FROM bronze_hotel_bookings
GROUP BY currency;
-- what we get --> USD Revenue = 191898.73, INR Revenue = 180661.61, EUR Revenue = 171692.22
