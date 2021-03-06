use `dav6100_db_2_rpt`;

--
-- Dumping data for table `dim_suppliers`
--
insert into dim_suppliers(supplier_id, supplier_name, supplier_status, supplier_country) 
(
select distinct tp_sup.sup_id, tp_sup.sup_name_en, tp_st.status_label_en, tp_ct.country_label_en 
from `dav6100_db_2 as`.t_sup_supplier tp_sup, `dav6100_db_2 as`.r_ctry tp_ct, `dav6100_db_2 as`.r_base_stat tp_st
where tp_sup.country_code = tp_ct.country_code
and tp_sup.status_code = tp_st.status_code
and tp_st.tdesc_name = 't_sup_supplier');
select * from dim_suppliers;

--
-- Dumping data for table `dim_product`
--
insert into dim_product(product_id, item_id, product_description, product_category) 
(
select tp_prod.prod_id, tp_prod.item_id, tp_prod.prod_desc, tp_prod.fam_node 
from `dav6100_db_2 as`.r_prod tp_prod
);
select * from dim_product;

--
-- Dumping data for table `dim_orders`
--
insert into dim_orders(order_id, order_amount) 
(
select oltp.ord_id, sum(oltp.ord_item_amt) from `dav6100_db_2 as`.t_ord_item oltp
WHERE oltp.ord_id > ''
group by oltp.ord_id
);
select * from dim_orders;

--
-- Dumping data for table `dim_date`
--
insert into dim_date(date_string, date_year, date_month, date_day, date_quarter, date_weekday) 
(
select  ord_disp_dt, Year(dd), 
        Month(dd), Day(dd),
        QUARTER(dd), Weekday(dd)
        from
        (select distinct tp_or.ord_disp_dt, str_to_date(tp_or.ord_disp_dt, '%m/%d/%Y') dd
from `dav6100_db_2 as`.t_ord_item oltp
inner join `dav6100_db_2 as`.t_ord_order tp_or
on oltp.ord_id = tp_or.ord_id
WHERE oltp.ord_id > ''
group by oltp.ord_id) dt
);
select * from dim_date;

--
-- Dumping data for table `fact_orders`
--
insert into fact_orders(product_key, order_key, supplier_key, order_date_key, item_quantity, item_amount) 
(
select dim_product.product_key, dim_orders.order_key, dim_suppliers.supplier_key, dim_date.date_key, 
sum(oltp.ord_item_qty), sum(oltp.ord_item_amt) 
 from (
	  select oo.ord_id, oo.ord_disp_dt, oi.prod_id, oi.sup_id, oi.ord_item_qty, oi.ord_item_amt from 
	 `dav6100_db_2 as`.t_ord_order oo, 
	 `dav6100_db_2 as`.t_ord_item oi, 
	 `dav6100_db_2 as`.r_prod pr
	 where oo.ord_id = oi.ord_id 
	 and oi.prod_id = pr.prod_id
 ) oltp, 
dav6100_db_2_rpt.dim_orders,
dav6100_db_2_rpt.dim_product,
dav6100_db_2_rpt.dim_suppliers,
dav6100_db_2_rpt.dim_date
where  oltp.prod_id = dim_product.product_id
and oltp.ord_id = dim_orders.order_id
and oltp.sup_id = dim_suppliers.supplier_id
and oltp.ord_disp_dt = dim_date.date_string
group by dim_product.product_key, dim_orders.order_key, dim_suppliers.supplier_key, dim_date.date_key);
select * from fact_orders;