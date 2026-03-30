# Superstore Star Schema – Data Dictionary

This data dictionary describes the analytical star schema created in `data_model/02_sql_superstore_data_modeling.sql` and modeled in `data_model/04_er_diagram_superstore_dbdiagram.txt` / `data_model/07_diagram_superstore_er.pdf`.

---

## Table: dim_customer

**Grain:** One row per unique customer.

| Column         | Type | Description |
|----------------|------|-------------|
| `customer_id`  | TEXT (PK) | Unique identifier for each customer, derived from `"Customer ID"` in the raw Superstore data. |
| `customer_name`| TEXT | Customer full name (max over all records for that ID). |
| `segment`      | TEXT | Customer segment (e.g., Consumer, Corporate, Home Office). |

---

## Table: dim_product

**Grain:** One row per unique product.

| Column        | Type | Description |
|---------------|------|-------------|
| `product_id`  | TEXT (PK) | Unique identifier for each product, from `"Product ID"`. |
| `product_name`| TEXT | Product name, from `"Product Name"`. |
| `category`    | TEXT | High-level product category (e.g., Furniture, Office Supplies, Technology). |
| `sub_category`| TEXT | More detailed product grouping within `category` (e.g., Chairs, Phones). |

---

## Table: dim_location

**Grain:** One row per unique (Country, State, City, Postal Code, Market, Region) combination.

| Column        | Type        | Description |
|---------------|-------------|-------------|
| `location_id` | INT (PK)    | Surrogate key assigned via `SERIAL`; used to join from `fact_sales`. |
| `country`     | TEXT        | Country of the customer/order. |
| `state`       | TEXT        | State/province within the country. |
| `city`        | TEXT        | City associated with the order. |
| `postal_code` | TEXT        | Postal or ZIP code. |
| `market`      | TEXT        | Market grouping used in Superstore (e.g., US, APAC, EU). |
| `region`      | TEXT        | Region within the market (e.g., East, West, Central, South). |

---

## Table: dim_date

**Grain:** One row per calendar date.

| Column        | Type   | Description |
|---------------|--------|-------------|
| `date`        | DATE (PK) | Calendar date used as the main time key and referenced by `fact_sales.order_date`. |
| `day`         | INT    | Day of month (1–31). |
| `month`       | INT    | Month number (1–12). |
| `year`        | INT    | Calendar year (e.g., 2014). |
| `quarter`     | INT    | Quarter of the year (1–4). |
| `weekday`     | INT    | Numeric day of week (e.g., 1–7 depending on convention). |
| `weekday_name`| TEXT   | Name of the weekday (e.g., Monday, Tuesday). |
| `month_name`  | TEXT   | Name of the month (e.g., January, February). |
| `is_weekend`  | BOOLEAN | Flag indicating whether the date falls on a weekend (`TRUE` for Saturday/Sunday, else `FALSE`). |

---

## Table: fact_sales

**Grain:** One row per order line (specific product on a specific order).

| Column         | Type    | Description |
|----------------|---------|-------------|
| `order_id`     | TEXT    | Identifier of the customer order, from `"Order ID"`. Multiple rows can share the same `order_id` when multiple products are on the same order. |
| `customer_id`  | TEXT (FK) | References `dim_customer.customer_id`; identifies the customer who placed the order. |
| `product_id`   | TEXT (FK) | References `dim_product.product_id`; identifies the product sold. |
| `order_date`   | DATE (FK) | References `dim_date.date`; date when the order was placed. |
| `ship_mode`    | TEXT    | Shipping mode used for the order (e.g., Second Class, Standard Class). |
| `location_id`  | INT (FK) | References `dim_location.location_id`; captures the geographic location of the order. |
| `sales`        | NUMERIC | Revenue amount for this line item. |
| `quantity`     | INT     | Number of units sold for this product in the order line. |
| `discount`     | NUMERIC | Discount applied to this line (fraction or amount, depending on source data). |
| `profit`       | NUMERIC | Profit for this line (sales minus costs and discounts). |
| `shipping_cost`| NUMERIC | Shipping cost allocated to this line item (from `"Shipping Cost"`). |

---

## Relationships (summary)

- `fact_sales.customer_id` → `dim_customer.customer_id`
- `fact_sales.product_id` → `dim_product.product_id`
- `fact_sales.order_date` → `dim_date.date`
- `fact_sales.location_id` → `dim_location.location_id`

This schema supports analyses such as:
- Sales and profit by customer, segment, product, category, and sub-category.
- Sales performance by geography (country, state, city, region, market).
- Time-based trends (by day, month, quarter, year, weekday vs weekend).
- Inputs to RFM segmentation and market basket (Apriori) analysis.
