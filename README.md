# Brazilian E-Commerce Analytics: A Comprehensive Data Analysis Project

## Quick Navigation

**Complete Analysis Notebooks:**
- [01 - Data Preparation](../notebooks/01_data_preparation.ipynb)
- [02 - Exploratory Analysis](../notebooks/02_exploratory_analysis.ipynb)
- [03 - Descriptive Analytics](../notebooks/03_descriptive_analytics.ipynb)
- [04 - Diagnostic Analytics](../notebooks/04_diagnostic_analytics_REVISED.ipynb)
- [05 - Predictive Modeling](../notebooks/05_predictive_modeling.ipynb)
- [06 - Prescriptive Analytics](../notebooks/06_prescriptive_analytics.ipynb)

**Key Visualizations:** All charts saved in `reports/figures/`

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

## Executive Summary

### Business Problem

The Brazilian e-commerce platform faces a **critical retention crisis**:
- **97% of customers never return** after their first purchase
- Only **3% repeat purchase rate** despite 58% five-star reviews
- **46% of orders delayed**, causing significant customer dissatisfaction
- **1.73 star average drop** in reviews for delayed deliveries

**Core Question:** What drives customer satisfaction, and how can we optimize operations to maximize customer lifetime value?

---

### Complete Analysis Journey: Notebook-by-Notebook

#### **Notebook 01: Data Preparation** ✅
**📓 [View Notebook](/notebooks/01_data_preparation.ipynb)**

**Objective:** Load, validate, and prepare data for analysis

**Dataset Overview:**
- **9 relational tables** with proper foreign key relationships
- **1.6M total records** across all tables
- **99.7% review coverage** of delivered orders (excellent data quality)
- **Zero referential integrity issues** (clean, production-quality data)

**Key Data Points:**
- Orders: 99,441 (97% delivered, 2% shipped, 1% other)
- Customers: 99,441 unique (1 order each on average)
- Products: 32,951 across 71 categories
- Sellers: 3,095 across 27 states
- Reviews: 99,224 (57.8% gave 5 stars)

**Anomaly Detected & Resolved:**
- 102% review-to-order ratio (some orders have multiple reviews)
- Investigation showed legitimate multi-review pattern


#### **Notebook 02: Exploratory Data Analysis** 📊
**📓 [View Notebook](/notebooks/02_exploratory_analysis.ipynb)**

**Objective:** Discover patterns and generate hypotheses

##### **Finding 1: Platform Growth Trajectory**

**Growth Phases Identified:**
1. **Launch Phase** (Sept-Dec 2016): 0-300 orders/month
2. **Rapid Growth** (Jan-Oct 2017): 4,613% monthly growth
3. **Maturity Phase** (Nov 2017-Aug 2018): Stable 6,000-7,000 orders/month

![Monthly Order Growth](/reports/figures/monthly_order_trends.png)
*Figure 1: Exponential growth followed by plateau at maturity*

##### **Finding 2: Delivery Performance Crisis**

**Delay Distribution:**
- **54% on-time** deliveries
- **46% delayed** orders (massive problem!)
- Average delay: 2.3 days when late
- Maximum delay: 189 days (extreme outlier)

**Impact on Reviews:**
```
On-time orders:    4.23 stars average
Delayed orders:    2.50 stars average
Impact:            -1.73 stars (MASSIVE!)
```

![Delivery Delay Impact](/reports/figures/delay_impact_analysis.png)
*Figure 2: Clear negative correlation between delays and review scores*

##### **Finding 3: Geographic Concentration**

**Top 10 States by Order Volume:**
1. **SP (São Paulo):** 42% of all orders (41,746 orders)
2. **RJ (Rio de Janeiro):** 13% (12,852 orders)
3. **MG (Minas Gerais):** 12% (11,635 orders)
4. **RS, PR, SC, BA, DF, GO, ES:** Remaining top 10

**Insight:** Urban concentration creates logistics advantages for SP customers

![Geographic Distribution](/reports/figures/geographic_analysis.png)
*Figure 3: Massive concentration in SP state*

##### **Finding 4: Category Performance**

**Top 15 Categories by Revenue:**
1. **health_beauty:** BRL 1.2M (8,647 orders, avg BRL 143)
2. **watches_gifts:** BRL 950K
3. **bed_bath_table:** BRL 888K
4. **sports_leisure:** BRL 812K
5. **computers_accessories:** BRL 755K

**Performance Matrix (4 Quadrants):**
- **Stars:** High volume + High satisfaction (health_beauty, sports_leisure)
- **Niche:** Low volume + High satisfaction (specialty items)
- **Cash Cows:** High volume + Medium satisfaction (bed_bath_table)
- **Problem:** Any low satisfaction categories (none critical)

![Category Performance Matrix](/reports/figures/category_performance.png)
*Figure 4: Category performance across volume and satisfaction dimensions*

##### **Finding 5: Order Value vs Reviews - No Correlation!**

**Discovery:**
- Correlation coefficient: ~0.02 (essentially zero)
- **Expensive orders get NO better treatment**
- This is a missed opportunity (no VIP service)

![Order Value vs Review Score](/reports/figures/premium_vs_budget.png)
*Figure 5: Flat relationship confirms no premium customer treatment*



-----

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
│   │   └── eda_queries.sql           # Queries from EDA file
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
git clone https://github.com/gnpthbalaji/ds_with_ai_capstone.git
cd ds_with_ai_capstone
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
python src/data_load.py
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

## Future Enhancements (Potential)

- Real-time dashboard with Streamlit/Dash
- Time series forecasting for demand
- NLP analysis of review text
- A/B test simulation framework
- Recommendation engine for product suggestions

## License

This project uses the [Creative Commons CCO: Public Domain](https://creativecommons.org/licenses/by-nc-sa/4.0/) Olist dataset.

## References

- Dataset: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
- Olist: https://olist.com/
- SQLite Documentation: https://www.sqlite.org/docs.html
- Scikit-learn: https://scikit-learn.org/
