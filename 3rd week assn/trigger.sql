drop table if exists Persons;
CREATE TABLE Persons (
    PersonID int,
    Name varchar(255),
    Address varchar(255),
    City varchar(255)
);
INSERT INTO Persons
VALUES (1, 'LittleBlue','91762','Ontario');

drop table if exists tb_trigger_log;
CREATE TABLE tb_trigger_log
(
Id int IDENTITY(1,1),
NewName varchar(20),
Update_time datetime
);

drop trigger if exists TriggerInsert;

CREATE TRIGGER TriggerInsert
   ON  Persons
   AFTER INSERT
AS 
BEGIN
    declare @Name varchar(20);
	select @Name=Name from inserted;
	insert into tb_trigger_log(NewName,Update_time)
	values(@Name, GETDATE());

END
GO

insert into Persons
values(3, 'Cara','91762','Ontario');
select * from Persons;
select * from [dbo].[tb_trigger_log];