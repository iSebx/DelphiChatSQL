select *
from Users

INSERT INTO Users (Users.User_ID, Nick, Estado, Avatar, Email, Pass) VALUES
        ('1001','Seb',0,NULL,'sebs.liotta@gmail.com','3001'),
		('1002','Cuchu',0,NULL,'cuchu@hotmail.com','3002'),
		('1003','Coco',0,NULL,'coco@outlook.com','3002'),
        ('1004','Sara',0,NULL,'sara@saralogic.com','3003'),
		('1005','Nuria',0,NULL,'nuria@algundominio.com','3004'),
		('1006','Santiago',0,NULL,'santi87@milanesa.com.ar','3005');

go

alter proc UserExist (@user nchar(20), @pass nchar(10))
as
begin
return (select COUNT(u.User_ID)
from Users as u
where u.Nick=@user and u.Pass=@pass)
end
go

declare @res int
Exec UserExist 1001, '3001'
select @res

exec UserExist 'Stb', '3001'


select *
from Users


Select (CAST('2019-10-04 15:15:15.001' as datetime))

INSERT INTO Message (Message_ID, [Message], Sender_ID, Reciver_ID, [Date], isSend) VALUES
	(00,'Feliz Inicio!',1002,1001,CAST('2007-05-08 12:35:29. 1234567 +12:15' as datetime2),1),
	(02,'Como Estas!?',1002,1001,CAST('2007-05-08 12:35:29. 1234567 +12:15' as datetime2),0),
	(03,'Te LLegan??',1002,1001,CAST('2007-05-08 12:35:29. 1234567 +12:15' as datetime2),0),
	(04,'Me parece que no',1002,1001,CAST('2007-05-08 12:35:29. 1234567 +12:15' as datetime2),0),
	(05,':(',1002,1001,CAST('2007-05-08 12:35:29. 1234567 +12:15' as datetime2),0),
	(06,'Mañana Hablamos',1002,1001,CAST('2007-05-08 12:35:29. 1234567 +12:15' as datetime2),0);

select * 
from Users

select *
from message

-- Muestra todos los mensajes de un usuario!
go
create proc All_Message (@user int)
as 
begin
select u.User_ID, u.Nick, m.Message_ID, m.Message, IIF (m.isSend=0, 'NO RECIBIDO', 'RECIBIDO') as [State], m.Date 
from Users as u INNER JOIN Message as M on (u.User_ID=m.Reciver_ID) 
where u.User_ID=@user
order by [State] asc
return
end

exec All_Message 1001

go
-- Muestra mensajes leidos!
alter proc Message_Readed (@user int)
as 
begin
select * 
from Users as u INNER JOIN Message as M on (u.User_ID=m.Reciver_ID) 
where u.User_ID=@user and m.isSend=1

return
end

exec Message_Readed 1001

go
-- Muestra no mensajes leidos!
alter proc Message_Unreaded (@user int)
as begin
select * 
from Users as u INNER JOIN Message as M on (u.User_ID=m.Reciver_ID) 
where u.User_ID=@user and m.isSend=0
order by m.Date asc
return
end

declare  @Nick varchar(20),         @Avatar Image,    @pass varchar(10),    @email varchar(50);
		 Set @Nick ='Malcom'; Set @Avatar=NULL; Set @Pass = '3001'; Set @email = 'malcom@hotmail.com'--UserID es MAX(UserID)+1, estado en 1 
select @Nick, @Avatar, @pass, @email

go 
create proc Get_User_Data (@user int)
as
begin
	select *
	from Users as U
	where U.User_ID=@user
return
end

go
create proc Get_Message_Info (@messageID int)
as
begin
	select *
	from Message as M
	where M.Message_ID=@messageID
return
end

exec Get_Message_Info 1

go

alter proc Add_User (@UserID int, @Nick nchar(20), @Pass nchar(10), @Avatar Image, @email nchar(50), @Row_Affected int output)
as
begin
	INSERT INTO Users (User_ID, Nick, Pass, Estado, Avatar, Email) VALUES
	(@UserID, @Nick, @Pass, 1, @Avatar, @email);
	Set @Row_Affected= 1;
	return
end

declare @row int
exec Add_User 1010, 'Lucas', '3001', NULL, 'LEchazarreta@google.com', @row
select STR(@row) as Affected

select * from Users

go
create proc Get_User_Info (@user int)
as
begin
select * from Users
where Users.User_ID=@user
return
end


SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE ROUTINE_TYPE = 'PROCEDURE'
   ORDER BY ROUTINE_NAME

exec All_Message 1001

exec Get_User_Info 1001

select *
from users