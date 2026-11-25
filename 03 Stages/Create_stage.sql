-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Create Internal Stage
-- =====================================================

-- Stage to store the csv data files temporarily before loading

CREATE OR REPLACE STAGE hotel_bookings_stage
FILE_FORMAT = csv_ff;
