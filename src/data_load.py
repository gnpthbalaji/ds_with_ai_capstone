import sqlite3
import pandas as pd
from pathlib import Path

def create_db():

    raw_data_path = Path("data/raw")
    db_path = 'data/ecommerce.db'

    conn = sqlite3.connect(db_path)

    print(f"Connected to Db : {db_path}")

    csv_files = [
        ('olist_customers_dataset.csv', 'customers'),
        ('olist_geolocation_dataset.csv', 'geolocation'),
        ('olist_order_items_dataset.csv', 'order_items'),
        ('olist_order_payments_dataset.csv', 'order_payments'),
        ('olist_order_reviews_dataset.csv', 'order_reviews'),
        ('olist_orders_dataset.csv', 'orders'),
        ('olist_products_dataset.csv', 'products'),
        ('olist_sellers_dataset.csv', 'sellers'),
        ('product_category_name_translation.csv', 'product_category_name_translation')
    ]

    for csv_file, table_name in csv_files:
        csv_path = raw_data_path / csv_file
        if not csv_path.exists():
            print(f"File {csv_path} does not exist. Skipping.")
            continue
        print(f"Loading {csv_path} into {table_name} table...")
        df = pd.read_csv(csv_path)
        df.to_sql(table_name, conn, if_exists='replace', index=False)
        print(f"Loaded {len(df)} records into {table_name} table.")

    print("\n Database Summary")
    # Query each table to get count of rows
    for _, table_name in csv_files:
        cursor = conn.execute(f"SELECT COUNT(*) FROM {table_name}")
        count = cursor.fetchone()[0]
        print(f"{table_name}: {count} records")
    conn.close()
    print("\nDatabase connection closed.")

    print("Database creation and data loading completed successfully.")

if __name__ == "__main__":
    print("Brazian E-commerce Database Creation Script")
    create_db()


