import pandas as pd
import pyodbc

# Load CSV file
df = pd.read_csv("Dataset/Sample - Superstore.csv", encoding='ISO-8859-1')

# Connect to SQL Server
conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=ABDUL-HAMEED;"  # or use your server name
    "DATABASE=projects_DB;"
    "Trusted_Connection=yes;"
)
cursor = conn.cursor()

# Insert data row by row
for index, row in df.iterrows():
    cursor.execute("""
        INSERT INTO staging_sales (
            Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode,
            Customer_ID, Customer_Name, Segment, Country, City,
            State, Postal_Code, Region, Product_ID, Category,
            Sub_Category, Product_Name, Sales, Quantity, Discount, Profit
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """,
        row['Row ID'], row['Order ID'], row['Order Date'], row['Ship Date'],
        row['Ship Mode'], row['Customer ID'], row['Customer Name'],
        row['Segment'], row['Country'], row['City'], row['State'],
        row['Postal Code'], row['Region'], row['Product ID'],
        row['Category'], row['Sub-Category'], row['Product Name'],
        row['Sales'], row['Quantity'], row['Discount'], row['Profit']
    )

conn.commit()
cursor.close()
conn.close()
