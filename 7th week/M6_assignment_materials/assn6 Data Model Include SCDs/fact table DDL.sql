select f_pr_or.product_key, 
f_pr_or.order_key, 
dim_suppliers.supplier_key, dim_date.date_key,
f_pr_or.ord_item_qty, f_pr_or.ord_item_amt from (
select dim_product.product_key, 
dim_orders.order_key, 
oltp.ord_item_qty, oltp.ord_item_amt,
oltp.sup_id, oltp.ord_ackn_dt
from dim_product
inner join (
select pr.prod_id, oi.ord_id, pr.sup_id, oo.ord_ackn_dt, oi.ord_item_qty, oi.ord_item_amt 
from `dav6100_db_2 as`.r_prod  pr
inner join `dav6100_db_2 as`.t_ord_item oi
on pr.prod_id = oi.prod_id
inner join `dav6100_db_2 as`.t_ord_order oo
on oi.ord_id = oo.ord_id) oltp
on oltp.prod_id = dim_product.product_id
left join dim_orders
on oltp.ord_id = dim_orders.order_id) f_pr_or
left join dim_suppliers
on f_pr_or.sup_id = dim_suppliers.supplier_id
left join dim_date
on f_pr_or.ord_ackn_dt = dim_date.date_string;


select dim_product.product_key, 
dim_orders.order_key, dim_suppliers.supplier_key, --  dim_date.date_key,
sum(ord_item_qty), sum(ord_item_amt)
from `dav6100_db_2 as`.r_prod  pr
join `dav6100_db_2 as`.t_ord_item oi on pr.prod_id = oi.prod_id
join `dav6100_db_2 as`.t_ord_order oo on oi.ord_id = oo.ord_id
join dim_product on pr.prod_id = dim_product.product_id
join dim_orders on oo.ord_id = dim_orders.order_id
join dim_suppliers on oi.sup_id = dim_suppliers.supplier_id
-- join dim_date on oo.ord_ackn_dt = dim_date.date_string
WHERE oi.ord_id > ''
group by product_key,
		order_key,
        supplier_key,
        date_key;
select * from fact_orders;
