# Sales Performance Analyst (Superstore)

- End-to-end sales analytics: SQL star schema + Apriori market basket + Power BI dashboard.

## Problem identification

- Turn raw Superstore transactions into an analysis-ready model + repeatable insights (sales, profit, shipping performance, and customer segmentation).

High discounting impact: Orders with discount rates > 20% consistently resulted in negative profit margins.
Customer growth: New customer acquisition showed limited growth, indicating a need for improved acquisition 

Strategies:
+ Identified high-frequency product pairings for cross-sell (Furnishings + Storage)
+ Customer segmentation (RFM-based strategy):
  “At Risk” customers: Apply targeted discounts to improve retention.
  Loyal customers: Reduce discount intensity, as they demonstrate lower price sensitivity.
+ Recommended strategic discounting during peak seasons to maximize revenue capture.


## Key Features

- Star-schema data model with clean date handling
- RFM customer segmentation fields for BI slicing
- Market basket analysis (Apriori) notebook for cross-sell insights
- Power BI dashboard for KPI monitoring and drilldowns

## Tech Stack

- SQL (script is PostgreSQL-style: `TO_DATE`, `SERIAL`)
- Python (Jupyter notebook)
- Power BI Desktop (`.pbix`)

## Project Structure

- `data_model/`
   - `01_data_superstore_raw.csv` (raw dataset)
   - `02_sql_superstore_data_modeling.sql` (star schema build script)
   - `diagram_superstore_er.pdf` + `er_diagram_superstore_dbdiagram.txt` (ER diagram)
   - `DATA_DICTIONARY.md` (table/column definitions)
- `notebooks_and_dash/`
   - `03_notebook_superstore_market_basket_apriori.ipynb` (Apriori notebook)
   - `04_dashboard_superstore_powerbi.pbix` (Power BI report)
- Root
   - `05_export_superstore_powerbi_dashboard.pdf` (dashboard snapshot)
   - `06_presentation_superstore_sales_performance.pdf` (slides)
   - `metadata.yml` (asset inventory)

