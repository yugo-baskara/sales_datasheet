# Sales Data Analysis using SQL

## 📌 Project Overview
This project is an end-to-end sales data analysis using SQL.  
The goal is to simulate how a data analyst supports executive-level (CEO) decision-making by transforming raw transactional data into meaningful business insights.

The dataset is provided in CSV format and processed using MySQL.
This project emphasizes data validation, structured SQL workflows, and business-oriented analysis rather than simple query writing.

---

## Tools & Environment
- Database: MySQL 8.0
- Language: SQL
- Data Source: CSV file
- Execution Environment: Local MySQL Server (MySQL Workbench)

---

## 🎯 Business Objectives
As a CEO, the following key business questions are addressed:

1. What is the total revenue generated?
2. How does each store (city/branch) perform?
3. Which product categories are the most valuable?
4. Are member customers more valuable than non-members?
5. Are there differences in purchasing behavior by gender?
6. Which branches operate most efficiently?
7. What products sell the most in each city?

---

## 🗂 Dataset Description
The dataset represents point-of-sale transactions from multiple branches and cities.
The dataset contains transactional sales data with the following attributes:


- Sale ID
- Branch
- City
- Customer Type
- Gender
- Product Name
- Product Category
- Unit Price
- Quantity
- Tax
- Total Price
- Reward Points

⚠️ **Note:**  
The dataset does not provide a reliable natural primary key.
The raw table is intentionally created without constraints to preserve data integrity and reflect real-world raw data conditions.

---

## 🔄 Data Processing Steps

### 1. Database & Table Creation
A raw table was created to mirror the CSV structure without assumptions or transformations.

``` sql

create table if not exists
	portofolio.sales_datasheet_raw
(sale_id int,
branch varchar (20),
city varchar (20),
customer_type varchar (20),
gender varchar (10),
product_name varchar (30),
product_category varchar (20),
unit_price decimal (10,2),
quantity int,
tax decimal (10,2),
total_price decimal (10,2),
reward_points int
)
;

```

---

### 2. Data Loading
The CSV file was loaded using `LOAD DATA LOCAL INFILE`.

```sql

load data local infile 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_datasheet.CSV'
into table portofolio.sales_datasheet_raw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 ROWS
;

-- File path in LOAD DATA INFILE is adjusted for local Windows environment.

```


### 3. Data Quality Checks
Data anomalies were identified, including:
- NULL values in critical columns
- Empty product names

These checks help ensure data reliability before analysis.

```sql

SELECT
	*
FROM
	portofolio.sales_datasheet_raw
WHERE
	unit_price IS NULL	
or
	quantity IS NULL 
or    
	total_price is NULL 
or
	product_name IS NULL 
or
	trim(PRODUCT_NAME) = ''
;

```

---

### 4. Business Analysis Using SQL
SQL queries were written to answer each CEO-level business question, focusing on:
- Revenue analysis
- Customer segmentation
- Product performance
- Branch efficiency

```sql
-- =========================== --
-- 1 - TOTAL REVENUE IN A YEAR --
-- =========================== --

select
	sum(total_price) AS total_revenue
from
	portofolio.sales_datasheet_raw
;

```

```sql
-- ============================= --
-- 2 - STORE PERFORMANCE IN YEAR --
-- ============================= --

select
	city,
    count(*) as total_transaction,
    sum(total_price) AS total_revenue
from
	portofolio.sales_datasheet_raw
group by
	city
order by
	total_revenue desc
;
```

```sql
-- ========================= --
-- 3 - Most valuable product --
-- ========================= --

select 
	product_category,
	sum(quantity) as item_quantity,
    sum(total_price) as grand_total
from
	portofolio.sales_datasheet_raw
group by
	product_category
order by
	grand_total desc
;
```

```sql
-- ========================== --
-- 4 - Most Valuable Customer --
-- ========================== --

select
	customer_type,
    count(*) as transaction,
    sum(total_price) as total_revenue,
    avg(total_price) as avg_spending
from
	portofolio.sales_datasheet_raw
group by
	customer_type
;
```

```sql
-- ================================ --
-- 5 - Different Gender and Revenue --
-- ================================ --

select
	gender,
    count(*) as total_transaction,
	sum(total_price) as revenue_total,
	avg(total_price) as avg_spending
from
	portofolio.sales_datasheet_raw
group by
	gender
;
```

```sql
-- ========================= --
-- 6 - Most Efficient Branch --
-- ========================= --

select
	branch,
    city,
    sum(total_price) / count(*) as revenue_per_transaction
from
	portofolio.sales_datasheet_raw
group by
	branch, city
order by
	revenue_per_transaction desc 
;
```

```sql
-- ============================ --
-- 7 - Top Product Every Branch --
-- ============================ --

select
	city,
    product_name,
    sum(quantity) as total_product
from
	portofolio.sales_datasheet_raw
group by
	city, product_name
order by
	city, total_product desc
;
```

---

## 📊 Key Insights

- Certain cities contribute disproportionately to total revenue, indicating potential focus areas for expansion.
- Some product categories generate high revenue despite lower sales volume, suggesting premium pricing effects.
- Member customers show higher average spending, supporting loyalty program effectiveness.
- Revenue per transaction varies significantly across branches, highlighting operational efficiency gaps.

---

## 📈 Future Improvements
- Create a cleaned analytical table separate from raw data
- Implement window functions to rank top products per city
- Visualize insights using BI tools such as Tableau or Power BI

---

## Project Structure

```
sales_datasheet/
│
├── data/
│    └── sales_datasheet.csv
├── sql/
│   ├── 1_create_raw_tabel.sql
│   ├── 2_load_data.sql
│   ├── 3_data_validation.sql
│   └── 4_business_analysis.sql
│
└── README.md
```

---
