-- =====================================================
-- Project: Hotel Booking Data Engineering
-- Purpose: Create CSV File Format
-- =====================================================

-- Lets Analyse our csv file structure and create a file format for it

CREATE OR REPLACE FILE FORMAT csv_ff
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
NULL_IF = ('NULL', 'null', 'Null', '');
