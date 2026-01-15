-- =========================== --
-- 1 - TOTAL REVENUE IN A YEAR --
-- =========================== --

select
	sum(total_price) AS total_revenue
from
	portofolio.sales_datasheet_raw
;


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
