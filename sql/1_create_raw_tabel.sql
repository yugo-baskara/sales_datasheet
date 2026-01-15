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
