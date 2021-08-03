SET @exec_time =  DATE_FORMAT(NOW(), '%Y%m%d%H%i%s');

set @sql = concat("
SELECT  distinct
ord_disp_dt as 'Date String',
YEAR(str_to_date(ord_disp_dt,'%m/%d/%Y')) as Year,
MONTH(str_to_date(ord_disp_dt,'%m/%d/%Y')) as Month,
Day(str_to_date(ord_disp_dt,'%m/%d/%Y')) as Day,
Quarter(str_to_date(ord_disp_dt,'%m/%d/%Y')) as Quarter,
WeekDay(str_to_date(ord_disp_dt,'%m/%d/%Y')) as WeekDay,
Week(str_to_date(ord_disp_dt,'%m/%d/%Y')) as Week
FROM dav6100_db_2.t_ord_order
ORDER BY YEAR,MONTH, DAY
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/date_dim_",@exec_time,".csv' 
FIELDS TERMINATED BY '||' 
ENCLOSED BY '' 
LINES TERMINATED BY '\r\n' 
TERMINATED BY '\r\n';"


);

prepare s1 from @sql;
execute s1; 

set @sql2 = concat("
SELECT DISTINCT sup_id as 'supplier_id',
sup_name_en as 'supplier_name' ,
dav6100_db_2.r_base_stat.status_label_en as 'supplier_status',
dav6100_db_2.r_ctry.country_label_en as 'supplier_country'
FROM dav6100_db_2.t_sup_supplier 
JOIN dav6100_db_2.r_base_stat on dav6100_db_2.t_sup_supplier.status_code = dav6100_db_2.r_base_stat.status_code
AND dav6100_db_2.r_base_stat.tdesc_name = 't_sup_supplier'
JOIN dav6100_db_2.r_ctry on dav6100_db_2.t_sup_supplier.country_code = dav6100_db_2.r_ctry.country_code
ORDER BY CAST(supplier_id AS SIGNED INTEGER)
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/supplier_dim_",@exec_time,".csv' 
FIELDS TERMINATED BY '||' 
ENCLOSED BY '' 
LINES TERMINATED BY '\r\n' 
TERMINATED BY '\r\n';"
);

prepare s2 from @sql2;
execute s2;

set @sql3 = concat("
SELECT DISTINCT prod_id AS 'product_id',
item_id as 'item_id',
prod_desc as 'product_description',
comm_cd  as 'product_category'
FROM dav6100_db_2.r_prod
ORDER BY CAST(product_id AS SIGNED INTEGER)
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_dim_",@exec_time,".csv' 
FIELDS TERMINATED BY '||' 
ENCLOSED BY '' 
LINES TERMINATED BY '\r\n' 
TERMINATED BY '\r\n';"
);

prepare s3 from @sql3;
execute s3;




set @sql4 = concat("
SELECT order_id, order_amount
FROM(SELECT
CASE WHEN ord_id = '' THEN 'UNKNOWN ORDER' 
ELSE ord_id  END as 'order_id', 
(CASE WHEN SUM(ord_item_amt) = 1000 THEN 'LESS THAN 1000' 
WHEN SUM(ord_item_amt) =1000  AND SUM(ord_item_amt) =3000  THEN 'BETWEEN 1000 AND 3000' 
WHEN SUM(ord_item_amt) =3000  AND SUM(ord_item_amt) =6000  THEN 'BETWEEN 3000 AND 6000' 
WHEN SUM(ord_item_amt) =6000  AND SUM(ord_item_amt) =10000  THEN 'BETWEEN 6000 AND 10000' 
WHEN SUM(ord_item_amt) =10000  THEN 'GREATER THAN 10000'  END ) AS 'order_amount'
FROM dav6100_db_2.t_ord_item 
GROUP BY ord_id order by order_id DESC) as a
WHERE order_id NOT IN ('UNKNOWN ORDER')
ORDER BY CAST(order_id AS SIGNED INTEGER)
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_dim_",@exec_time,".csv' 
FIELDS TERMINATED BY '||' 
ENCLOSED BY '' 
LINES TERMINATED BY '\r\n' 
TERMINATED BY '\r\n';"
);

prepare s4 from @sql4;
execute s4;

