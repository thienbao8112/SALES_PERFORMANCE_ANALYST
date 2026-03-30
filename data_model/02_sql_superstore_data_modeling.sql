-- =====================================
-- STAR SCHEMA - SUPERSTORE (POSTGRESQL)
-- =====================================

-- =====================
-- 0. CLEAN DATE FORMAT
-- =====================

ALTER TABLE superstore
ADD COLUMN new_order_date DATE,
ADD COLUMN new_ship_date DATE;

UPDATE superstore
SET 
    new_order_date = TO_DATE("Order Date", 'MM/DD/YYYY'),
    new_ship_date = TO_DATE("Ship Date", 'MM/DD/YYYY');

ALTER TABLE superstore
DROP COLUMN "Order Date",
DROP COLUMN "Ship Date";

ALTER TABLE superstore
RENAME COLUMN new_order_date TO "Order Date";

ALTER TABLE superstore
RENAME COLUMN new_ship_date TO "Ship Date";


-- =====================
-- 1. DIMENSIONS
-- =====================

-- DIM CUSTOMER
DROP TABLE IF EXISTS dim_customer;
CREATE TABLE dim_customer AS
SELECT 
    "Customer ID" AS customer_id,
    MAX("Customer Name") AS customer_name,
    MAX("Segment") AS segment
FROM superstore
GROUP BY "Customer ID";

ALTER TABLE dim_customer ADD PRIMARY KEY (customer_id);


-- DIM PRODUCT
DROP TABLE IF EXISTS dim_product;
CREATE TABLE dim_product AS
SELECT 
    "Product ID" AS product_id,
    MAX("Product Name") AS product_name,
    MAX("Category") AS category,
    MAX("Sub-Category") AS sub_category
FROM superstore
GROUP BY "Product ID";

ALTER TABLE dim_product ADD PRIMARY KEY (product_id);


-- DIM LOCATION
DROP TABLE IF EXISTS dim_location;
CREATE TABLE dim_location AS
SELECT DISTINCT
    Country,
    State,
    City,
    "Postal Code",
    Market,
    Region
FROM superstore;

ALTER TABLE dim_location
ADD COLUMN location_id SERIAL PRIMARY KEY;


-- =====================
-- DIM DATE (PROPER CALENDAR)
-- =====================

DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date (
    date DATE PRIMARY KEY,
    day INT,
    month INT,
    year INT,
    quarter INT,
    weekday INT,
    weekday_name TEXT,
    month_name TEXT,
    is_weekend BOOLEAN
);


-- =====================
-- 2. FACT TABLE
-- =====================

DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales AS
SELECT
    "Order ID" AS order_id,
    "Customer ID" AS customer_id,
    "Product ID" AS product_id,
    "Order Date" AS order_date,
    "Ship Mode" AS ship_mode,
    Country,
    State,
    City,
    Sales,
    Quantity,
    Discount,
    Profit,
    "Shipping Cost" AS shipping_cost
FROM superstore;


-- =====================
-- 3. ADD LOCATION KEY
-- =====================

ALTER TABLE fact_sales ADD COLUMN location_id INT;

UPDATE fact_sales f
SET location_id = d.location_id
FROM dim_location d
WHERE 
    f.Country = d.Country
    AND f.State = d.State
    AND f.City = d.City;

ALTER TABLE fact_sales
DROP COLUMN Country,
DROP COLUMN State,
DROP COLUMN City;


-- =====================
-- 4. RELATIONSHIPS
-- =====================

ALTER TABLE fact_sales
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id);

ALTER TABLE fact_sales
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id) REFERENCES dim_product(product_id);

ALTER TABLE fact_sales
ADD CONSTRAINT fk_location
FOREIGN KEY (location_id) REFERENCES dim_location(location_id);

-- ship_mode stays inside fact (NO dim_shipping)

ALTER TABLE fact_sales
ADD CONSTRAINT fk_date
FOREIGN KEY (order_date) REFERENCES dim_date(date);
