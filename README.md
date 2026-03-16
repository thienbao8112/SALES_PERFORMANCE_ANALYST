# Sales Performance Analyst

End-to-end sales analysis project using a Superstore dataset, SQL data modeling, Apriori market basket analysis, and a Power BI dashboard.

## Project Contents

1. `01_superstore_raw_data.csv`  
   Raw Superstore transactional dataset.

2. `02_superstore_data_modeling.sql`  
   SQL script that:
   - creates a `Store` database
   - normalizes/structures data into `customer`, `product`, `orders_shipping`, `orders`, and `RFM`
   - converts date fields (`Order Date`, `Ship Date`) to proper `DATE` format

3. `03_market_basket_analysis_apriori.ipynb`  
   Python notebook for association rule mining (Apriori).

4. `04_powerbi_sales_performance_dashboard.pbix`  
   Interactive Power BI dashboard file.

5. `05_powerbi_dashboard_export.pdf`  
   PDF export of dashboard pages.

6. `06_sales_performance_presentation.pdf`  
   Final presentation slides.

## Analytical Workflow

1. **Data source**: Superstore CSV data.
2. **Data modeling in SQL**: clean date columns and create analysis-ready tables.
3. **Market basket analysis in Python**: prepare transaction basket by `Order ID` and `Sub-Category`, then run Apriori and generate association rules.
4. **BI reporting**: build and present insights in Power BI.

## Run Instructions

### A) SQL workflow (MySQL)
- Open `02_superstore_data_modeling.sql` in your MySQL client.
- Ensure a `superstore` table is available before running transformation/table-creation steps.
- Execute script sections in order.

### B) Notebook workflow (Python)
Recommended packages:
- pandas
- numpy
- matplotlib
- seaborn
- mlxtend

Install packages:
```bash
pip install pandas numpy matplotlib seaborn mlxtend
```

Then open and run:
- `03_market_basket_analysis_apriori.ipynb`

> Note: the notebook currently loads data from a GitHub raw URL. If preferred, update it to load `01_superstore_raw_data.csv` locally.

### C) Dashboard workflow
- Open `04_powerbi_sales_performance_dashboard.pbix` in Power BI Desktop.
- Refresh data source mappings if file paths change.

## Notes

- File naming is ordered by project flow (`01` -> `06`) for quick onboarding.
- SQL script contains table names and logic used for segmentation (`RFM`) and operational analysis.
