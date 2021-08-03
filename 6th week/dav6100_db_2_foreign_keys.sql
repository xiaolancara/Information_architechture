USE `dav6100_db_2`;
set foreign_key_checks = 0;
ALTER TABLE `t_ord_delivery`
ADD CONSTRAINT `FK_ord_id_delivery`
FOREIGN KEY (`ord_id`) REFERENCES `t_ord_order` (`ord_id`);

ALTER TABLE `t_ord_delivery`
ADD CONSTRAINT `FK_status_code_delivery`
FOREIGN KEY (`status_code`) REFERENCES `r_base_stat` (`status_code`);
