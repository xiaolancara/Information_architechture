SELECT * FROM dav6100_db_2.t_ord_delivery a
left join dav6100_db_2.t_ord_order b
on a.ord_id = b.ord_id
where b.ord_id is null;

DELETE FROM dav6100_db_2.t_ord_delivery
WHERE ord_id = 368 or ord_id = 369;

