-- Q1:
select count(*) as "Count of Suppliers" , status_code as "Status" from(
select * from dav6100_db.t_ctr_amt
where status_code in ('val')
group by sup_id) as tb_1
union all
select count(distinct sup_id) as "Count of Suppliers" , status_code as "Status" from(
select * from dav6100_db.t_ctr_amt
where sup_id not in(
select sup_id from dav6100_db.t_ctr_amt
where status_code in ('val')
group by sup_id)) as tb_2;

-- verify the result
select count(distinct sup_id) from dav6100_db.t_ctr_amt;


-- Q2:
select country_label_en as "Country", sum(orig_max_am) as "Total Contract Dollars" from 
dav6100_db.t_sup_supplier as sup
inner join dav6100_db.t_ctr_amt as am
on sup.sup_id = am.sup_id
inner join dav6100_db.r_ctry as ct
on sup.country_code=ct.country_code
where sup.country_code="US";

-- Q3:
SELECT sup.country_code "Country code",
SUM(IF(am.doc_bfy = 2015, am.orig_max_am, 0)) AS "2015",
SUM(IF(am.doc_bfy = 2016, am.orig_max_am, 0)) AS "2016",
SUM(IF(am.doc_bfy = 2017, am.orig_max_am, 0)) AS "2017",
SUM(IF(am.doc_bfy = 2018, am.orig_max_am, 0)) AS "2018",
SUM(IF(am.doc_bfy = 2019, am.orig_max_am, 0)) AS "2019",
SUM(IF(am.doc_bfy = 2020, am.orig_max_am, 0)) AS "2020",
SUM(IF(am.doc_bfy = 9999, am.orig_max_am, 0)) AS "9999"
from dav6100_db.t_sup_supplier as sup
inner join dav6100_db.t_ctr_amt as am
ON sup.sup_id = am.sup_id
where am.status_code='val'
group by sup.country_code
order by sup.country_code;

