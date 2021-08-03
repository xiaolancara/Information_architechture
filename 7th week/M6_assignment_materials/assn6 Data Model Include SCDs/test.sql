select dim_product.product_key, 
dim_orders.order_key, dim_suppliers.supplier_key,-- dim_date.date_key,
oltp.ord_item_qty, oltp.ord_item_amt
from dim_product
inner join (
select pr.prod_id, oi.ord_id, pr.sup_id, oo.ord_ackn_dt, oi.ord_item_qty, oi.ord_item_amt 
from `dav6100_db_2 as`.r_prod  pr
inner join `dav6100_db_2 as`.t_ord_item oi
on pr.prod_id = oi.prod_id
inner join `dav6100_db_2 as`.t_ord_order oo
on oi.ord_id = oo.ord_id) oltp
on oltp.prod_id = dim_product.product_id
inner join dim_orders
on oltp.ord_id = dim_orders.order_id
inner join dim_suppliers
on oltp.sup_id = dim_suppliers.supplier_id
inner join dim_date
on oltp.ord_ackn_dt = dim_date.date_string;