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
