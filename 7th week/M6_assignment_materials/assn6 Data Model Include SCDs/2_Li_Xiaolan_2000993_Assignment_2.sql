drop database `dav6100_db_2_rpt`;
create database `dav6100_db_2_rpt`;
use `dav6100_db_2_rpt`;
-- MySQL dump 07/07/2021  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: order-database-rds.c1hgka2potxp.us-east-1.rds.amazonaws.com    Database: dav6100_db_2_rpt
-- ------------------------------------------------------
-- Server version	8.0.18

--
-- Table structure for table `dim_product`
--
drop table if exists dim_product;
create table dim_product
(
product_key int(11) AUTO_INCREMENT PRIMARY KEY,
product_id varchar(50),
item_id varchar(50),
product_description varchar(1024),
product_category int(5)
);

--
-- Table structure for table `dim_orders`
--
drop table if exists dim_orders;
create table dim_orders
(
order_key int(11) AUTO_INCREMENT PRIMARY KEY,
order_id varchar(50),
order_amount varchar(200)
);

--
-- Table structure for table `dim_suppliers`
--
drop table if exists dim_suppliers;
create table dim_suppliers
(
supplier_key int(11) AUTO_INCREMENT PRIMARY KEY,
supplier_id varchar(50),
supplier_name varchar(1024),
supplier_status varchar(100),
supplier_country varchar(100)
);

--
-- Table structure for table `dim_date`
--
drop table if exists dim_date;
create table dim_date
(
date_key int(11) AUTO_INCREMENT PRIMARY KEY,
date_string varchar(11),
date_year int(11),
date_month int(11),
date_day int(11),
date_quarter int(11),
date_weekday int(11)
);

--
-- Table structure for table `fact_orders`
--
drop table if exists fact_orders;
create table fact_orders
(
product_key int(11),
order_key int(11),
supplier_key int(11),
order_date_key int(11),
item_quantity int(11),
item_amount decimal(19,4),
KEY FK_product_key (product_key),
KEY FK_order_key (order_key),
KEY FK_supplier_key (supplier_key),
KEY FK_order_date_key (order_date_key),
CONSTRAINT FK_product_key FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
CONSTRAINT FK_order_key FOREIGN KEY (order_key) REFERENCES dim_orders(order_key),
CONSTRAINT FK_supplier_key FOREIGN KEY (supplier_key) REFERENCES dim_suppliers(supplier_key),
CONSTRAINT FK_order_date_key FOREIGN KEY (order_date_key) REFERENCES dim_date(date_key));

-- Dump completed on 2021-07-07 11:15 pm








