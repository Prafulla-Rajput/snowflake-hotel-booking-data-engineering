# Snowflake Hotel Booking Data Engineering Project

## About the Project
For this project, I worked with hotel booking data containing information about bookings, customers, hotels, room types, dates, currencies, and booking statuses.

The idea was to take booking records from a CSV file, load them into Snowflake, work through the data quality issues, and gradually transform the raw data into a format that could be used for analysis and reporting.

I followed the Bronze, Silver, and Gold approach, with each layer handling a different part of the process. Once the data was ready, I used the Gold layer tables to build a dashboard in Snowflake Snowsight.


---


## What Was the Business Requirement?
The business scenario was fairly straightforward.

Imagine a hotel business receiving booking data but not having a clear picture of its performance. Management wants to understand how much revenue is being generated, how bookings are changing over time, and which cities are performing better.

The objective was to prepare the data and build a dashboard that could help answer questions such as:

- What is the total revenue and how many bookings have been received?
- How does revenue change from month to month?
- Which cities generate the highest revenue?
- How are bookings distributed across room types?
- What is the breakdown of bookings by status?


---

## Project Architecture

I used Snowflake's native capabilities for this project. The CSV file was uploaded to a Snowflake Internal Stage and then processed through three layers. I have used SQL for data loading, transformations, and analytical queries.


#### The overall data flow:

> **CSV File** → **Internal Stage** → **Bronze Layer** → **Silver Layer** → **Gold Layer** → **Dashboard**

Each layer had a specific purpose, as explained below.

---

## How I Built the Pipeline

### 1. Setting Up Snowflake

I started by creating the basic Snowflake objects required for the project:

-   Database: `HOTEL_DB`
-   Schema: `BOOKING_DATA`
-   Warehouse: `BOOKING_DATA_WH`
-   CSV File Format: `CSV_FF`
-   Internal Stage: `HOTEL_BOOKINGS_STAGE`

I used a Snowflake Internal Stage to store the source CSV file before loading it into the Bronze table.

I chose this approach to keep the project Snowflake-native rather than introducing an external cloud storage dependency.


### 2. Bronze Layer – Loading Raw Data

The first step was to bring the source data into Snowflake without applying transformations.

I created the Bronze table with all columns defined as `STRING`.

The reason was simple: at this stage, I wanted to accommodate the incoming source values without having data rejected because of incorrect or inconsistent data types.

I then loaded the CSV file using the `COPY INTO` command with:

```sql
ON_ERROR = CONTINUE
```

This allowed Snowflake to continue loading valid records even if some records encountered loading errors.

After loading, I verified the data and started exploring the columns to understand what needed attention.


### 3. Understanding Data Quality Issues

Before creating the Silver layer, I spent time exploring the Bronze data. This helped me identify several inconsistencies in the source dataset.

Some of the issues I found were:
| Column | Observation | Records / Details
|--|--|--|
|CUSTOMER_EMAIL  | Invalid email values | Around 400 records
TOTAL_AMOUNT | Negative amounts | 176 records |
| CHECK_IN_DATE | Inconsistent date separators | 194 records | 
CHECK_IN_DATE and CHECK_OUT_DATE | Check-in date later than check-out date | 71 records | 
| BOOKING_STATUS | Inconsistent status values | Typos, NULL values and inconsistent labels | 
| CURRENCY | Multiple currencies | USD, INR and EUR |


For example, the booking status column contained values such as `Confirmed`, `No-Show`, `Cancelled`, and a misspelled `Confirmeeed`, along with NULL values.

There were also multiple currencies, which needed to be standardized before calculating meaningful revenue figures.

This exploration helped me decide what transformations were required while moving the data into Silver.


### 4. Silver Layer – Cleaning and Transforming Data

Once I understood the source data, I created the Silver table with appropriate data types for the columns.

Instead of loading the raw data directly, I used a `SELECT` statement to apply transformations and then inserted the results into the Silver table.

Some of the transformations included:
-   Used `TRIM` to remove unwanted spaces.
-   Used `INITCAP` to standardize customer names and city names.
-   Used `CASE` expressions to handle invalid email values by converting them to NULL.
-   Converted date and numeric fields into appropriate data types.
-   Standardized currency values into INR.
    

**Currency conversion assumptions**

For this project, I used fixed conversion rates:
| Currency | Conversion Rate |
|--|--|
| USD | 1 USD = 92 INR |
| EUR | 1 EUR = 102 INR |
| INR | 1 INR = 1 INR |

These are illustrative project assumptions, not live exchange rates.


**Silver layer loading results**

The source dataset contained 2,000 records. After applying the transformations and NOT NULL conditions on `CHECK_IN_DATE` and `CHECK_OUT_DATE`, 1,729 records were loaded into Silver.

The remaining 271 records were excluded because they did not satisfy these conditions.

I also identified 71 records where the check-in date was later than the check-out date during data exploration.


### 5. Gold Layer – Preparing Data for Reporting

After cleaning the data, the next step was to prepare it for business reporting.

Here, I revisited the original business requirements and selected the data needed for the dashboard.

I created three Gold tables:

`**GOLD_BOOKINGS**-
Contains the cleaned booking-level details needed for downstream reporting, so dashboard queries can work directly with the Gold layer.


**GOLD_AGG_BOOKINGS_REVENUE**`-
Contains aggregated booking and revenue metrics by check-in date, supporting booking and revenue trend analysis.


`**GOLD_AGG_CITY_BOOKINGS_REVENUE**
Contains booking and revenue aggregations by hotel city, helping identify city-level performance.

I also excluded cancelled bookings from revenue calculations so that cancelled booking amounts would not contribute to reported revenue.

For this project, I kept the Gold layer relatively simple rather than implementing a full dimensional model.

---

## Dashboard – Hotel Bookings Analysis

Once the Gold tables were ready, I used Snowflake Snowsight Dashboards to present the results.

The dashboard is titled **Hotel Bookings - Analysis Dashboard**.

It includes four KPI cards:
-   Total Revenue
-   Total Bookings
-   Average Booking Value
-   Total Guests


It also includes the following visualizations:
-   Monthly Revenue
-   Monthly Bookings
-   Revenue by City
-   Bookings by City
-   Bookings by Room Type
-   Bookings by Status
    

### Dashboard Preview
<img width="1920" height="2088" alt="Hotel-Bookings-Dashboard" src="https://github.com/user-attachments/assets/83cbba3d-9d2a-411e-820f-b60711a1a2d8" />


---

## Project Structure

The repository is arranged into folders based on the different stages of the project, making it easier to follow the SQL scripts from the initial Snowflake setup through the Gold layer and dashboard.

---

## A Note Before You Go

> Thanks for taking the time to explore my project! I hope it gives you a good understanding of the work I've done with Snowflake and SQL. Your feedback and suggestions are always welcome.
