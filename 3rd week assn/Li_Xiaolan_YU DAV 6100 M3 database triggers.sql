drop table if exists t_sup_supplier_hist;
CREATE TABLE t_sup_supplier_hist
(
sup_id varchar(50) NOT NULL,
-- last_modified varchar(50),
last_modified date,
PRIMARY KEY(sup_id)
);

drop trigger if exists ins_date;
DELIMITER $$
CREATE TRIGGER ins_date AFTER INSERT ON t_sup_supplier
FOR EACH ROW 
BEGIN
    INSERT INTO t_sup_supplier_hist(sup_id, last_modified)
	VALUES(new.sup_id, curdate());  
END$$    
DELIMITER ;

drop trigger if exists update_date;
DELIMITER $$
CREATE TRIGGER update_date AFTER UPDATE ON t_sup_supplier
FOR EACH ROW 
BEGIN
    INSERT INTO t_sup_supplier_hist(sup_id, last_modified)
	VALUES(new.sup_id, curdate());
END$$    
DELIMITER ;

drop trigger if exists delete_date;
DELIMITER $$
CREATE TRIGGER delete_date Before DELETE ON t_sup_supplier
FOR EACH ROW 
BEGIN
    INSERT INTO t_sup_supplier_hist(sup_id, last_modified)
	VALUES(old.sup_id, curdate());
END$$    
DELIMITER ;


INSERT INTO t_sup_supplier
VALUES('2904474', 'val', 'CA','Cara Inc');

UPDATE t_sup_supplier
SET status_code = 'ini'
WHERE sup_id = '2904473';

select * from t_sup_supplier_hist;



