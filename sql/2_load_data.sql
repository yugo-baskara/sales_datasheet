load data local infile 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_datasheet.CSV'
into table portofolio.sales_datasheet_raw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 ROWS
;
