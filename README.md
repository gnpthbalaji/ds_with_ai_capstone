# Brazilian E-Commerce Analytics: A Comprehensive Data Analysis Project

## Project Overview
An end-to-end data analytics project (Capstone - Codecademy **Data Science with AI** bootcamp) exploring customer behavior, operational efficiency, and business performance using the Brazilian E-Commerce Public Dataset by Olist. This project demonstrates descriptive, diagnostic, predictive, and prescriptive analytics capabilities.

**Dataset**: [Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Business Questions

### Primary Question
What factors drive customer satisfaction in Brazilian e-commerce, and how can we optimize operations to improve review scores and reduce delivery delays?

### Secondary Questions
1. **Descriptive**: What are the key patterns in purchase behavior across regions and product categories?
2. **Diagnostic**: Why do certain orders receive poor reviews, and what operational factors contribute?
3. **Predictive**: Can we predict customer review scores based on delivery performance and product characteristics?
4. **Prescriptive**: Which customer segments should we prioritize for retention, and what operational improvements would have the highest impact?

## Repository Structure

```
ecommerce-analytics-capstone/
│
├── README.md                          # Project overview and documentation
├── requirements.txt                   # Python dependencies
├── .gitignore                        # Git ignore file
│
├── data/
│   ├── raw/                          # Original CSV files from Kaggle (not tracked)
│   └── ecommerce.db                  # SQLite database (not tracked)
│
├── notebooks/
│   ├── 01_data_preparation.ipynb     # Data loading and database setup
│   ├── 02_exploratory_analysis.ipynb # EDA and SQL queries
│   ├── 03_descriptive_analytics.ipynb # Patterns and trends
│   ├── 04_diagnostic_analytics.ipynb  # Root cause analysis
│   ├── 05_predictive_modeling.ipynb   # ML models for review prediction
│   ├── 06_prescriptive_analytics.ipynb # Recommendations and segmentation
│   └── 07_final_report.ipynb         # Executive summary and findings
│
├── sql/
│   ├── schema.sql                    # Database schema creation
│   ├── queries/
│   │   ├── descriptive_queries.sql   # Summary statistics queries
│   │   ├── diagnostic_queries.sql    # Analysis queries
│   │   └── feature_engineering.sql   # Feature creation for ML
│   └── utils/
│       └── helper_queries.sql        # Reusable query templates
│
├── src/
│   ├── __init__.py
│   ├── data_loader.py                # Load CSVs into SQLite
│   ├── data_cleaner.py               # Data cleaning functions
│   ├── feature_engineer.py           # Feature creation functions
│   ├── models.py                     # ML model classes
│   └── visualizations.py             # Reusable plotting functions
│
├── reports/
│   ├── figures/                      # Generated visualizations
│   ├── executive_summary.md          # 1-2 page summary
│
├── tests/
│   ├── test_data_loader.py
│   └── test_feature_engineer.py
```

## Dataset Description

The Olist dataset contains information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil.

**Tables (CSV files)**:
- `olist_customers_dataset.csv` - Customer data with location
- `olist_orders_dataset.csv` - Order information and timestamps
- `olist_order_items_dataset.csv` - Items purchased per order
- `olist_order_payments_dataset.csv` - Payment details
- `olist_order_reviews_dataset.csv` - Customer reviews and ratings
- `olist_products_dataset.csv` - Product information
- `olist_sellers_dataset.csv` - Seller information
- `olist_geolocation_dataset.csv` - Brazilian zip codes and coordinates
- `product_category_name_translation.csv` - Category translations PT->EN

## Technology Stack

- **Database**: SQLite 3
- **Python**: 3.10+
- **Key Libraries**:
  - Data manipulation: `pandas`, `numpy`
  - Database: `sqlite3`, `sqlalchemy`
  - Visualization: `matplotlib`, `seaborn`, `plotly`
  - Machine Learning: `scikit-learn`, `xgboost`
  - Statistical Analysis: `scipy`, `statsmodels`

## Setup Instructions

### 1. Clone the Repository
```bash
git clone
cd ecommerce-analytics-capstone
```

### 2. Create Virtual Environment
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Download Dataset
1. Download the [Brazilian E-Commerce dataset from Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Extract all CSV files to `data/raw/`

### 5. Build SQLite Database
```bash
python src/data_loader.py
```

This will:
- Create `data/ecommerce.db`
- Load all CSV files into properly structured tables
- Create relationships and indexes
- Validate data integrity

### 6. Run Notebooks
Start with `notebooks/01_data_preparation.ipynb` and proceed sequentially.

## Analysis Workflow

### Phase 1: Data Preparation
- Load raw CSV files
- Create normalized SQLite database
- Data quality assessment
- Handle missing values and duplicates
- Create data dictionary

### Phase 2: Exploratory Analysis
- SQL queries for summary statistics
- Temporal patterns (trends, seasonality)
- Geographic distribution analysis
- Product category analysis
- Customer behavior patterns

### Phase 3: Descriptive & Diagnostic Analytics
- Revenue analysis by region/category
- Delivery performance metrics
- Review score distribution
- Correlation analysis
- Root cause analysis for poor reviews

### Phase 4: Predictive Analytics
- Feature engineering (SQL + Python)
- Baseline model (logistic regression)
- Advanced models (Random Forest, XGBoost)
- Model evaluation and comparison
- Feature importance analysis

### Phase 5: Prescriptive Analytics
- Customer segmentation (RFM analysis + K-Means)
- Seller performance recommendations
- Delivery optimization insights
- Business recommendations

### Phase 6: Reporting & Documentation
- Executive summary
- Key visualizations
- Limitations and ethical considerations
- Next steps and recommendations

## Key SQL Skills Demonstrated

1. **Database Design**: Normalized schema with foreign keys
2. **Complex Queries**: JOINs across 5+ tables
3. **Aggregations**: GROUP BY, HAVING, window functions
4. **Subqueries**: Nested queries for complex logic
5. **CTEs**: Common Table Expressions for readability
6. **Performance**: Proper indexing and query optimization
7. **Feature Engineering**: SQL-based feature creation for ML

## Deliverables

1. **Jupyter Notebooks**: 7 notebooks with outputs saved
2. **Executive Summary**: 1-2 page written report (`reports/executive_summary.md`)
3. **SQLite Database**: Fully documented schema
4. **Visualizations**: 10+ key charts and insights
5. **Code**: Clean, documented Python modules
6. **Presentation**: Optional slide deck

## Evaluation Criteria Alignment

| Criterion | How This Project Addresses It |
|-----------|------------------------------|
| Question & Scope | Clear business questions; realistic 1-week scope (capstone suggested time spent) |
| Data | Public Kaggle dataset; issues documented; data dictionary included |
| Methods | Baseline + advanced models; SQL + ML; justified iterations |
| Evaluation | Multiple metrics; train/test split; cross-validation; limitations discussed |
| Communication | Visualizations at each stage; narrative in notebooks; executive summary |
| Reproducibility | Requirements.txt; random seeds set; database build script; step-by-step notebooks |

## Success Metrics

- **Descriptive**: Identify top 3 factors affecting customer satisfaction
- **Diagnostic**: Quantify impact of delivery delays on review scores
- **Predictive**: Achieve >75% accuracy in predicting poor reviews (score ≤ 3)
- **Prescriptive**: Segment customers into 4-5 actionable groups with specific recommendations

## Future Enhancements

- Real-time dashboard with Streamlit/Dash
- Time series forecasting for demand
- NLP analysis of review text
- A/B test simulation framework
- Recommendation engine for product suggestions

## License

This project uses the [Creative Commons CCO: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) Olist dataset.

## References

- Dataset: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
- Olist: https://olist.com/
- SQLite Documentation: https://www.sqlite.org/docs.html
- Scikit-learn: https://scikit-learn.org/
