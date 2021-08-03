use dav6100_db_2_rpt;

alter table dim_orders add column order_status varchar(50) default null;
alter table dim_orders add column eff_date varchar(50) default null;
alter table dim_orders add column end_date varchar(50) default null;

select * from dav6100_db_2_rpt.dim_orders where order_id in('1543');

drop trigger if exists `dav6100_db_2 as`.t_ord_order_update_trigger;
delimiter $
CREATE TRIGGER  `dav6100_db_2 as`.t_ord_order_update_trigger
	AFTER update ON `dav6100_db_2 as`.t_ord_order FOR EACH ROW 
	BEGIN
        DECLARE order_key_tmp int;
        DECLARE order_amount_tmp varchar(200);
        select order_key, order_amount INTO order_key_tmp, order_amount_tmp 
			from dav6100_db_2_rpt.dim_orders 
            where order_id = old.ord_id and end_date is null; -- get the current record info
        
        -- update current record
		update dav6100_db_2_rpt.dim_orders set eff_date = new.ord_disp_dt, order_status = new.status_code where order_key = order_key_tmp;
        
        -- keep the history adding end date
        INSERT INTO `dav6100_db_2_rpt`.`dim_orders`(`order_id`, `order_amount`, `order_status`, `eff_date`, `end_date`) values
            (old.ord_id, order_amount_tmp, old.status_code, old.ord_disp_dt, new.ord_disp_dt);
	END $
    
-- update script
update `dav6100_db_2 as`.t_ord_order
set 
ord_id = '1543',
status_code = 'ini',
ord_disp_dt = '02/21/2020'
where 
ord_id in('1543');

update `dav6100_db_2 as`.t_ord_item
set 
ord_id = '1543',
status_code = 'cur'
where 
oitem_id in('2142', '8044', '476', '7462');

-- execute the transformation script
select * from dav6100_db_2_rpt.dim_orders where order_id in('1543');

-- Query result
-- order_key,order_id,order_amount,order_status,eff_date,end_date
-- 603,1543,223.92,ini,02/21/2020,NULL
-- 2048,1543,223.92,venr,09/19/2019,02/21/2020
