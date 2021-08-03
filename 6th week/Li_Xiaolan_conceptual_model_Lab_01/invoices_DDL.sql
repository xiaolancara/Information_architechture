CREATE DATABASE  IF NOT EXISTS `Invoices`;
Use `Invoices`; 

-- alter table FactInvoiceTransaction drop foreign key fk_date_id_fact;
-- alter table FactInvoiceTransaction drop foreign key fk_invoice_id_fact;
-- alter table DimDateInfo drop foreign key fk_invoice_id_date;


drop table if exists DimInvoiceInfo;
CREATE TABLE DimInvoiceInfo
(
	InvoicedId smallint primary key,
    PaymentAmount varchar(19),
    ActiveFlag varchar(1)
);

drop table if exists DimDateInfo;
CREATE TABLE DimDateInfo
(
	DateId smallint PRIMARY KEY,
    recievedDate varchar(23),
    paymentDate varchar(23),
    paymentYear varchar(4),
    paymentMonth varchar(2)
);

drop table if exists FactInvoiceTransaction;
CREATE TABLE FactInvoiceTransaction
(
	SurgorrateId smallint UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TransactionId smallint ,
    InvoiceId smallint,
    DateId smallint,
    PaymentAmount varchar(19),
    TurnAroundDays smallint
);
ALTER TABLE FactInvoiceTransaction ADD CONSTRAINT fk_invoice_id_fact FOREIGN KEY (InvoiceId) REFERENCES DimInvoiceInfo(InvoicedId);
ALTER TABLE FactInvoiceTransaction ADD CONSTRAINT fk_date_id_fact FOREIGN KEY (DateId) REFERENCES DimDateInfo(DateId);
