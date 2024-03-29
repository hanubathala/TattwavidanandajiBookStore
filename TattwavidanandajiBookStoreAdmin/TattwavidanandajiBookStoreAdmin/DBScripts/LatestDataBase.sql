USE [tattvavidanandaBooksStore]
GO
/****** Object:  StoredProcedure [dbo].[CustomerLoginsValidate]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[CustomerLoginsValidate]
(@Email varchar(250) = null, @Pwd varchar(250) = null)
as
begin
Declare @cnt int

select @cnt=COUNT(*) from Customer where Email=@Email and [Password]=@Pwd

if @cnt>0
Begin
SELECT  [Id],[UserName],[MobileNo],[Email],[Password],[Address],[ZipCode],[LandMark],[AccountNo]
  FROM Customer where Email=@Email and [Password]=@Pwd
End
else
Begin

  Raiserror('Your Email and Password  are wrong',18,1);
End
End

-- [CustomerLoginsValidate] 'hnmisv@gmail.com','123'

GO
/****** Object:  StoredProcedure [dbo].[EOTPverification]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[EOTPverification]
@Email varchar(50),@Emailotp varchar(10)
as
begin

declare @cnt int

select @cnt = COUNT(*) from Customer where Email = @Email

if @cnt = 0
   begin
  
				RAISERROR ('Invalid Email address',16,1);
				return;
   end

else

begin

  select @cnt = COUNT(*) from Customer where Email = @Email and eotp = @Emailotp 
  if @cnt = 0
	begin
	  
					RAISERROR ('Invalid Email OTP',16,1);
					return;
	end
 
  else
 
   begin
     update Customer set eotp  = null where Email  = @Email  and eotp  = @Emailotp
    SELECT [Id],[UserName],[AccountNo] FROM [Customer] where Email=@Email
   
   end
 
end

end

GO
/****** Object:  StoredProcedure [dbo].[GetBookList]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetBookList]
As
Begin

SELECT [Id]
      ,[BookTitle]
      ,[BookImage]
      ,[BookStock]
      ,[BookDescription]
      ,(Select Name from Types where Id=[BookType]) as [BookType]
      ,[BookPrice]
	  ,0 as flag
	  ,Active
  FROM [Book] where Active=1 order by Id desc

  End
GO
/****** Object:  StoredProcedure [dbo].[GetBookListbyId]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetBookListbyId]
@id int 
As
Begin

SELECT [Id]
      ,[BookTitle]
      ,[BookImage]
      ,[BookStock]
      ,[BookDescription]
      ,(Select Name from Types where Id=[BookType]) as [BookType]
      ,[BookPrice]
  FROM [Book]  where Id=@Id

  End

  -- exec [GetBookListbyId] 9
GO
/****** Object:  StoredProcedure [dbo].[GetBookListConfig]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[GetBookListConfig]
(@curpage int=-1,
@maxrows int=-1)
As
Begin
DECLARE @FirstRec int, @LastRec int,@totalpages int, @totalrec int,@totalrows int

SELECT @FirstRec = (@curpage - 1) * @maxrows
SELECT @LastRec = (@curpage * @maxrows + 1);

WITH TempResult as
(SELECT ROW_NUMBER()  OVER(ORDER BY [Id] asc) as RowNum,[Id]
      ,[BookTitle]
      ,[BookImage]
      ,[BookStock]
      ,[BookDescription]
      ,(Select Name from Types where Id=[BookType]) as [BookType]
      ,[BookPrice]
	  ,0 as flag
	  ,Active
	  ,BookSKU,[BookWeight],[BookLabelId],[BookAuthor],[BookTags],[BookLanguageId],[BookNoOfPages],[BookPublisher]
  FROM [Book]
  )
  SELECT top (@LastRec-1) *
FROM TempResult
WHERE RowNum > @FirstRec	
AND RowNum < @LastRec

select @totalrec =  COUNT(*) from (SELECT ROW_NUMBER()  OVER(ORDER BY [Id] asc) as RowNum,[Id]
      ,[BookTitle]
      ,[BookImage]
      ,[BookStock]
      ,[BookDescription]
      ,(Select Name from Types where Id=[BookType]) as [BookType]
      ,[BookPrice]
	  ,0 as flag
	  ,Active
	  ,BookSKU,[BookWeight],[BookLabelId],[BookAuthor],[BookTags],[BookLanguageId],[BookNoOfPages],[BookPublisher]
  FROM [Book])as temp
	if((@totalrec%@maxrows)=0)
	select @totalpages=(@totalrec/@maxrows);
	else 
	select @totalpages=(@totalrec/@maxrows)+1;
	if((@totalrec)=0)
	select @totalrows=(@totalpages/@maxrows)+1;
	select @totalrows=(@maxrows)+1;
	 
	  
select @totalpages as totalpages, @totalrec as recordcount,@totalrows as totalrows 
  End

  --[GetBookListConfig] 1,5
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerList]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetCustomerList] 
(@curpage int=-1,
@maxrows int=-1)
As
Begin
DECLARE @FirstRec int, @LastRec int,@totalpages int, @totalrec int,@totalrows int

SELECT @FirstRec = (@curpage - 1) * @maxrows
SELECT @LastRec = (@curpage * @maxrows + 1);

WITH TempResult as
(SELECT ROW_NUMBER()  OVER(ORDER BY [Id] asc) as RowNum,[Id]
      ,[UserName]
      ,[FirstName]
      ,[LastName]
      ,[Alter MobileNo]
      ,[MobileNo]
      ,[Email]
      ,[Password]
      ,[Address]+''+[ZipCode]+''+[LandMark] as UserAddress
      ,[AccountNo]
      ,[Active]
      ,[eotp]
  FROM [Customer] )
  SELECT top (@LastRec-1) *
FROM TempResult
WHERE RowNum > @FirstRec 
AND RowNum < @LastRec

select @totalrec =  COUNT(*) from (SELECT ROW_NUMBER()  OVER(ORDER BY [Id] asc) as RowNum,[Id]
      ,[UserName]
      ,[FirstName]
      ,[LastName]
      ,[Alter MobileNo]
      ,[MobileNo]
      ,[Email]
      ,[Password]
       ,[Address]+''+[ZipCode]+''+[LandMark] as UserAddress
      ,[AccountNo]
      ,[Active]
      ,[eotp]
  FROM [Customer])as temp
	if((@totalrec%@maxrows)=0)
	select @totalpages=(@totalrec/@maxrows);
	else 
	select @totalpages=(@totalrec/@maxrows)+1;
	if((@totalrec)=0)
	select @totalrows=(@totalpages/@maxrows)+1;
	select @totalrows=(@maxrows)+1;
	 
	  
select @totalpages as totalpages, @totalrec as recordcount,@totalrows as totalrows 
  End





GO
/****** Object:  StoredProcedure [dbo].[GetCustomerOrder]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetCustomerOrder]
@custid int
as
Begin
SELECT
       ors.[OrderId]
      ,ors.[Createdon],
	  ors.[TotalAmount]
	  ,50 as Charges
	   FROM [Orders] ors 
    where ors.Customerid=@custid

SELECT ordetails.Id,
       ors.[OrderId]
      ,ors.[Createdon]
	 ,bok.BookTitle
	 ,ordetails.quanity
	  ,ordetails.Price
	  ,ordetails.Subtotal
  FROM [Orders] ors 
  left outer join OrderDetails ordetails  on ors.id=ordetails.OrderId 
  left outer join Book bok on ordetails.BookId=bok.Id
    where ors.Customerid=@custid
End

  -- GetCustomerOrder 3
GO
/****** Object:  StoredProcedure [dbo].[GetOrderDetails]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetOrderDetails] 
@orderId int 
as
Begin
SELECT orddetails.[Id]
      ,orddetails.[OrderId]
      ,orddetails.[BookId]
      ,orddetails.[quanity]
      ,orddetails.[Price]
      ,orddetails.[Subtotal]
      ,orddetails.[Createdon]
	  ,bok.[BookTitle]
	  ,bok.BookImage
  FROM [OrderDetails] orddetails
  inner join Orders ord on orddetails.[OrderId]=ord.Id 
  inner join Book bok on orddetails.[BookId]=bok.Id
  where Ord.Id=@orderId
End


GO
/****** Object:  StoredProcedure [dbo].[GetOrders]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE Procedure [dbo].[GetOrders] 
(
@curpage int=-1,
@maxrows int=-1)
As
Begin
DECLARE @FirstRec int, @LastRec int,@totalpages int, @totalrec int,@totalrows int

SELECT @FirstRec = (@curpage - 1) * @maxrows
SELECT @LastRec = (@curpage * @maxrows + 1);

WITH TempResult as
(SELECT ROW_NUMBER()  OVER(ORDER BY custorder.[id] desc) as RowNum,custorder.[id]
      ,custorder.[OrderId]
      ,custorder.[Createdon]
      ,custorder.[Updatedon]
      ,custorder.[Statusid]
	  ,(SELECT CONVERT(varchar(10),custorder.[Statusid])) as Statusid2 
	  , (select Name from Types where Id=[Statusid]) as StatusName
      ,custorder.[Quantity]
      ,custorder.[TotalAmount]
      ,custorder.[ShippingAddressId]
	  ,cust.UserName
  FROM [Orders] custorder
  inner join Customer cust on custorder.CustomerId=cust.Id) 
    SELECT top (@LastRec-1) *
FROM TempResult
WHERE RowNum > @FirstRec 
AND RowNum < @LastRec
select @totalrec =  COUNT(*) from (SELECT ROW_NUMBER()  OVER(ORDER BY custorder.[id] desc) as RowNum,custorder.[id]
      ,custorder.[OrderId]
      ,custorder.[Createdon]
      ,custorder.[Updatedon]
      ,custorder.[Statusid]
	  , (select Name from Types where Id=[Statusid]) as StatusName
      ,custorder.[Quantity]
      ,custorder.[TotalAmount]
      ,custorder.[ShippingAddressId]
	  ,cust.UserName
  FROM [Orders] custorder
  inner join Customer cust on custorder.CustomerId=cust.Id)as temp
	if((@totalrec%@maxrows)=0)
	select @totalpages=(@totalrec/@maxrows);
	else 
	select @totalpages=(@totalrec/@maxrows)+1;
	if((@totalrec)=0)
	select @totalrows=(@totalpages/@maxrows)+1;
	select @totalrows=(@maxrows)+1;
	 
	  
select @totalpages as totalpages, @totalrec as recordcount,@totalrows as totalrows 
  End
  
GO
/****** Object:  StoredProcedure [dbo].[GetTypegroups]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetTypegroups] 
(@curpage int=-1,
@maxrows int=-1)
As
Begin
DECLARE @FirstRec int, @LastRec int,@totalpages int, @totalrec int,@totalrows int

SELECT @FirstRec = (@curpage - 1) * @maxrows
SELECT @LastRec = (@curpage * @maxrows + 1);

WITH TempResult as
(SELECT ROW_NUMBER()  OVER(ORDER BY [Id] desc) as RowNum,[Id]
      ,[Name]
      ,[Description]
      ,[Active]
  FROM [TypeGroup] )
  SELECT top (@LastRec-1) *
FROM TempResult
WHERE RowNum > @FirstRec 
AND RowNum < @LastRec

select @totalrec =  COUNT(*) from (SELECT ROW_NUMBER()  OVER(ORDER BY [Id] asc) as RowNum, [Name]
      ,[Description]
      ,[Active]
  FROM [TypeGroup])as temp
	if((@totalrec%@maxrows)=0)
	select @totalpages=(@totalrec/@maxrows);
	else 
	select @totalpages=(@totalrec/@maxrows)+1;
	if((@totalrec)=0)
	select @totalrows=(@totalpages/@maxrows)+1;
	select @totalrows=(@maxrows)+1;
	 
	  
select @totalpages as totalpages, @totalrec as recordcount,@totalrows as totalrows 
  End



GO
/****** Object:  StoredProcedure [dbo].[GetTypeGroupsconfig]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetTypeGroupsconfig]
as
Begin
SELECT [Id]
      ,[Name]
      ,[Description]
      ,[Active]
  FROM [TypeGroup]
End

GO
/****** Object:  StoredProcedure [dbo].[GetTypesByPaging]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetTypesByPaging] 
(@typegrpid int=-1,
@curpage int=-1,
@maxrows int=-1)
As
Begin
DECLARE @FirstRec int, @LastRec int,@totalpages int, @totalrec int,@totalrows int

SELECT @FirstRec = (@curpage - 1) * @maxrows
SELECT @LastRec = (@curpage * @maxrows + 1);

WITH TempResult as
(SELECT ROW_NUMBER()  OVER(ORDER BY t.[Id] asc) as RowNum, t.[Id]
      ,t.[Name]
      ,t.[TGroupID]
      ,t.[Description]
      ,t.[Active]
	  ,ty.Name as TypeGroupName
	  ,ty.Id as TypeGroupId
  FROM [Types] t inner join TypeGroup ty on t.TGroupID=ty.Id  where (TGroupID=@typegrpid) or (@typegrpid=-1) )
  SELECT top (@LastRec-1) *
FROM TempResult
WHERE RowNum > @FirstRec 
AND RowNum < @LastRec

select @totalrec =  COUNT(*) from (SELECT ROW_NUMBER()  OVER(ORDER BY t.[Id] asc) as RowNum, t.[Id]
      ,t.[Name]
      ,t.[TGroupID]
      ,t.[Description]
      ,t.[Active]
	  ,ty.Name as TypeGroupName
	  ,ty.Id as TypeGroupId
  FROM [Types] t inner join TypeGroup ty on t.TGroupID=ty.Id where TGroupID=@typegrpid or (@typegrpid=-1) )as temp
	if((@totalrec%@maxrows)=0)
	select @totalpages=(@totalrec/@maxrows);
	else 
	select @totalpages=(@totalrec/@maxrows)+1;
	if((@totalrec)=0)
	select @totalrows=(@totalpages/@maxrows)+1;
	select @totalrows=(@maxrows)+1;
	 
	  
select @totalpages as totalpages, @totalrec as recordcount,@totalrows as totalrows 
  End

  -- GetTypesByPaging ,1,20
GO
/****** Object:  StoredProcedure [dbo].[Gettypesdata]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Gettypesdata]
@booktype int =-1,@labeltype int =-1,@languagetype int =-1,@status int=-1
as
Begin

if @booktype=1
Begin
SELECT [Id]
      ,[Name]
      ,[TGroupID]
      ,[Description]
      ,[Active]
  FROM [Types] where TGroupID=3
End
if @labeltype=1
Begin
SELECT [Id]
      ,[Name]
      ,[TGroupID]
      ,[Description]
      ,[Active]
  FROM [Types] where TGroupID=4
End
if @languagetype=1
Begin
SELECT [Id]
      ,[Name]
      ,[TGroupID]
      ,[Description]
      ,[Active]
  FROM [Types] where TGroupID=5
  End
  if @status=1
Begin
SELECT [Id]
	  ,(SELECT CONVERT(varchar(10),Id)) as Id2 
      ,[Name]
      ,[TGroupID]
      ,[Description]
      ,[Active]
  FROM [Types] where TGroupID=2
End
End
GO
/****** Object:  StoredProcedure [dbo].[InsOrder]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsOrder]
	-- Add the parameters for the stored procedure here
	@OrderId varchar(250)=null/*Alphanumaric unique for each order*/,
	@StatusId int=null,
	@CustomerId bigint=null,
	@Quantity int=null,
	@Total decimal(18,2)=null,
	@ShippingAddressId bigint=null ,
	@BillingAddressid bigint = null,
	@Ipaddress varchar(128)=null
	,@flag varchar
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @cnt int,@m varchar(50)

	select @m = 'OR'+replace(CONVERT(VARCHAR(1), GETDATE(), 114),':','')+ CONVERT(VARCHAR(3),DATEPART(millisecond,GETDATE()))

if @flag='I'
Begin
INSERT INTO [dbo].[Orders]
           (OrderId,[Createdon],[Statusid],[Customerid],[Quantity],TotalAmount)
     VALUES
           (@m,GETDATE(),@StatusId,@CustomerId,@Quantity,@Total)

		   set @cnt=SCOPE_IDENTITY();
            
			select @cnt as Id
End

	

END

GO
/****** Object:  StoredProcedure [dbo].[InsOrderDeails]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[InsOrderDeails]
@orderid int,@BookId int,@qunatity int,@price decimal(18,2),@subtotal decimal(18,2),@flag varchar
as
Begin

if @flag='I'
Begin
INSERT INTO [dbo].[OrderDetails]
           ([OrderId],[BookId],[quanity],[Price],[Subtotal],[Createdon])
     VALUES( @orderid,@BookId,@qunatity,@price,@subtotal,GETDATE())
End
End



GO
/****** Object:  StoredProcedure [dbo].[InsUpdDelAddressBook]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[InsUpdDelAddressBook]
@CustomerId int,@Address varchar(max)=null,@zipcode varchar(100)=null,@landmark varchar(250)=null,@addressfor varchar(100)=null
as
Begin
INSERT INTO [dbo].[CustomerAddressBook]
           ([CustomerId],[Address],[ZipCode],[LandMark],[Addressfor])
     VALUES(@CustomerId,@Address,@zipcode,@landmark,@addressfor)

	  select SCOPE_IDENTITY() as Id1
End


GO
/****** Object:  StoredProcedure [dbo].[InsUpdDelBook]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[InsUpdDelBook]
@BookTitle varchar(250)=null,@BookImage varchar(max)=null,@BookStock int=0,@BookDescription varchar(max)=null,@BookType int,@BoolPrice decimal(18,0)=null,@Id int,@flag varchar
,@Active int=null,@BookSKU varchar(250)=null,@BookWeight decimal(18,2)=null,@BookLabelId int=null,@BookAuthor varchar(250)=null,@BookTags varchar(250)=null,@BookLanguageId int=null,@BookNoOfPages int=null,@BookPublisher varchar(250)=null

as
Begin
declare @cnt int,@cmt int

select @cnt=COUNT(*) from Book where UPPER(BookTitle)=UPPER(@BookTitle)
if @flag='I'
Begin
if @cnt >0
Begin
RAISERROR ('Book Title already exists',16,1);
return
End

INSERT INTO [dbo].[Book]([BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice],Active,BookSKU,[BookWeight],[BookLabelId],[BookAuthor],[BookTags],[BookLanguageId],[BookNoOfPages],[BookPublisher])
				  VALUES(@BookTitle,@BookImage,@BookStock,@BookDescription,@BookType,@BoolPrice,@Active,@BookSKU,@BookWeight,@BookLabelId,@BookAuthor,@BookTags,@BookLanguageId,@BookNoOfPages,@BookPublisher)

				   set @cmt=SCOPE_IDENTITY();
select Id, [BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice],Active,BookSKU,[BookWeight],[BookLabelId],[BookAuthor],[BookTags],[BookLanguageId],[BookNoOfPages],[BookPublisher] from Book where id=@cmt
End

if @flag='U'
Begin
select @cmt=COUNT(*) from Book where Id=@Id
if @cmt=0
Begin
RAISERROR ('Book Title is not there',16,1);
return
End
else
Begin
update Book set [BookTitle]=@BookTitle,[BookImage]=@BookImage,[BookStock]=@BookStock,[BookDescription]=@BookDescription,[BookType]=@BookType,[BookPrice]=@BoolPrice,Active=@Active,
BookSKU=@BookSKU,[BookWeight]=@BookWeight,[BookLabelId]=@BookLabelId,[BookAuthor]=@BookAuthor,[BookTags]=@BookTags,[BookLanguageId]=@BookLanguageId,[BookNoOfPages]=@BookNoOfPages,[BookPublisher]=@BookPublisher  where Id=@Id 
select Id, [BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice],Active
,BookSKU,[BookWeight],[BookLabelId],[BookAuthor],[BookTags],[BookLanguageId],[BookNoOfPages],[BookPublisher] from Book
End
end
End








GO
/****** Object:  StoredProcedure [dbo].[InsUpdDelCustomer]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[InsUpdDelCustomer]
@Username varchar(250)=null,@Id int=-1,@FirstName varchar(250)=null,@LastName varchar(250)=null,@MobileNo varchar(20)=null,@Email varchar(250)=null,@Address varchar(max)=nulll,@ZipCode varchar(20)=null,@LandMark varchar(max)=null,@AccountNo varchar(250)=null,@Active int=1,@flag varchar,@Password varchar(50)=null 

--UserName,FirstName,LastName,Contact,MobileNo,Email,Address,ZipCode,LandMark,AccountNo,Active
as
Begin
 Declare @cnt int,@e varchar(4),@currentid int
select @e = replace(CONVERT(VARCHAR(1), GETDATE(), 114),':','')+ CONVERT(VARCHAR(3),DATEPART(millisecond,GETDATE()))+5
select @cnt=COUNT(*) from Customer where Email=@Email

 if @cnt=0
 Begin
 if @flag='I'
 Begin
  INSERT INTO [dbo].[Customer]
           ([UserName],[AccountNo],[Active],eotp,[Password],Email)
     VALUES(@Username,'CUST'+@MobileNo,@Active,@e,@Password,@Email)

	 set @currentid=SCOPE_IDENTITY();

	 
	 select Email,eotp from Customer where Id=@currentid


 End

 End
 else
 Begin 
   Raiserror('Already Another User used this email id',18,2);
 End
if @flag='U'
Begin
Update Customer set FirstName=@FirstName,LastName=@LastName,MobileNo=@MobileNo,Address=@Address,ZipCode=@ZipCode,LandMark=@LandMark,Active=@Active  where Id=@id
End
if @flag='D'
Begin
Delete from Customer where Id=@Id
End
End





          


GO
/****** Object:  StoredProcedure [dbo].[InsUpdTypeGroups]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsUpdTypeGroups](@Id int = -1,@Name varchar(50)
,@Description varchar(50) = null,@Active int, @insupdflag varchar(1))
as
begin
declare @dt datetime
set @dt = GETDATE()
declare @cnt int
declare @edithistoryid int
declare @oldname varchar(50)
declare @olddesc varchar(250)
declare @oldactive int

if @insupdflag = 'I'
begin

select @cnt = COUNT(*) from TypeGroup where UPPER(name) = UPPER(@Name)

if @cnt =0
begin
INSERT INTO [dbo].[TypeGroup]
           ([Name]
           ,[Description]
           ,[Active])
     VALUES
           (@Name
           ,@Description
           ,@Active)

end
else
		RAISERROR ('Type Group already exists',16,1);

end
else
if @insupdflag = 'U'
begin

select @cnt = COUNT(*) from TypeGroup where (UPPER(name) = UPPER(@Name) and Id<>@Id) and Active=@active
              
if @cnt =0
begin       
   select @oldname = name, @olddesc = description, @oldactive = active from TypeGroup where Id = @Id        

UPDATE [dbo].[TypeGroup]
   SET [Name] = @Name
      ,[Description] = @Description
      ,[Active] = @Active
 WHERE Id = @Id
	
end
else
		RAISERROR ('Type Group already exists',16,1);
end
if @insupdflag = 'D'
begin
DELETE FROM [dbo].[TypeGroup]
      WHERE Id = @Id
end
end
GO
/****** Object:  StoredProcedure [dbo].[InsUpdTypes]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsUpdTypes](@Id int,@Name varchar(50),@Description varchar(50) = null,@TypeGroupId varchar(50)
,@Active int=null,@insupdflag varchar(1))
as
begin

declare @dt datetime
set @dt = GETDATE()

declare @cnt int
declare @edithistoryid int
declare @oldname varchar(50)
declare @olddesc varchar(250)
declare @oldactive int

if @insupdflag = 'I'
begin

select @cnt = COUNT(*) from Types where UPPER(name) = UPPER(@Name) and TGroupID = @TypeGroupId

if @cnt =0
BEGIN
INSERT INTO [dbo].[Types]
           ([Name]
           ,[Description]
           ,TGroupID 
           ,[Active])
     VALUES
           (@Name
           ,@Description
           ,@TypeGroupId 
           ,@Active)
           
           
           

  END
  else
    RAISERROR('Type already exists',16,1);         
 end
else
if @insupdflag = 'U'
begin

select @cnt = COUNT(*) from Types where (UPPER(name) = UPPER(@Name)  and TGroupID = @TypeGroupId) and Active=@Active


if @cnt =0
begin

update types 
set 
[Name]=@Name
,[Active] = @Active
,[Description] = @Description

where Id = @Id

	
end
else
 RAISERROR('Duplicate Types are not allowed',16,1);
end
if @insupdflag = 'D'
begin
DELETE FROM [dbo].[Types]
      WHERE Id = @Id
end
end

GO
/****** Object:  StoredProcedure [dbo].[OrderChangeStatus]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[OrderChangeStatus] 
@Id int ,@orderId int
as
Begin
Declare @cnt int

select @cnt=COUNT(*) from  Orders where Id=@orderId

if @cnt>0
Begin

update orders set [Statusid]=@Id where Id=@orderId

SELECT ord.[id]
      ,[OrderId]
      ,[Createdon]
      ,[Updatedon]
      ,[Statusid]
      ,[Customerid]
      ,[Quantity]
      ,[TotalAmount]
      ,[ShippingAddressId]
      ,[BillingAddressid]
      ,[DeliveredOn]
      ,[IPAddress]
	  ,Cust.Email
	  ,Cust.UserName
	  ,(select Name from Types where Id=@Id) as StatusName
  FROM [Orders] ord
  inner join Customer cust on ord.[Customerid]=cust.Id
   where ord.id=@orderId

End
End


GO
/****** Object:  StoredProcedure [dbo].[UpdateActiveBooklist]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[UpdateActiveBooklist]
@Active int,@BookId int
as
Begin
Declare @cnt int

select @cnt=COUNT(*) from Book where Id=@BookId
if @cnt>0
Begin
Update Book set Active=@Active where Id=@BookId
End
select Id, [BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice],Active from Book
End
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		NA
-- Create date: 24 Nov 2019
-- Description:	Order status will be updated
-- =============================================
CREATE PROCEDURE [dbo].[UpdateOrderStatus] 
	-- Add the parameters for the stored procedure here
	@OrderId varchar(250)/*Alphanumaric unique for each order for user purpose*/,
	@id bigint, /*Identity value for development purpose*/
	@StatusId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update [dbo].[Orders]
	Set    Statusid = @StatusId,
		   Updatedon = GETDATE()
	where  id = @id
	and    OrderId = @OrderId
		

END



GO
/****** Object:  StoredProcedure [dbo].[ValidationUserLogins]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ValidationUserLogins]
(@logininfo varchar(50) = null, @passkey varchar(50) = null)
as
begin
Select us.Id,  us.FirstName+''+us.LastName as UserName,ur.RoleId from LoginInfo  li
           inner join Users us on li.UserId=us.Id
		   inner join UserRoles ur on us.Id=ur.UserId
		   inner join Roles rl on ur.RoleId=rl.Id
		  where li.UserLogin=@logininfo and li.PassWord=@passkey and li.Active=1 
End
GO
/****** Object:  Table [dbo].[Book]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Book](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookTitle] [varchar](250) NULL,
	[BookImage] [varchar](max) NULL,
	[BookStock] [int] NULL,
	[BookDescription] [varchar](max) NULL,
	[BookType] [int] NULL,
	[BookPrice] [decimal](18, 0) NULL,
	[Active] [int] NULL,
	[BookSKU] [varchar](250) NULL,
	[BookWeight] [decimal](18, 2) NULL,
	[BookLabelId] [int] NULL,
	[BookAuthor] [varchar](250) NULL,
	[BookTags] [varchar](250) NULL,
	[BookLanguageId] [int] NULL,
	[BookNoOfPages] [int] NULL,
	[BookPublisher] [varchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](250) NULL,
	[FirstName] [varchar](250) NULL,
	[LastName] [varchar](250) NULL,
	[Alter MobileNo] [varchar](50) NULL,
	[MobileNo] [varchar](50) NULL,
	[Email] [varchar](250) NULL,
	[Password] [varchar](50) NULL,
	[Address] [varchar](max) NULL,
	[ZipCode] [varchar](50) NULL,
	[LandMark] [varchar](max) NULL,
	[AccountNo] [varchar](500) NULL,
	[Active] [int] NULL,
	[eotp] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerAddressBook]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerAddressBook](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Address] [varchar](max) NULL,
	[ZipCode] [varchar](50) NULL,
	[LandMark] [varchar](max) NULL,
	[Addressfor] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoginInfo]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserLogin] [varchar](50) NOT NULL,
	[PassWord] [varchar](50) NOT NULL,
	[UserId] [int] NOT NULL,
	[Active] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[BookId] [int] NULL,
	[quanity] [int] NULL,
	[Price] [decimal](18, 2) NULL,
	[Subtotal] [decimal](18, 2) NULL,
	[Createdon] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [nvarchar](64) NULL,
	[Createdon] [datetime] NULL,
	[Updatedon] [datetime] NULL,
	[Statusid] [int] NULL,
	[Customerid] [bigint] NULL,
	[Quantity] [int] NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[ShippingAddressId] [int] NULL,
	[BillingAddressid] [int] NULL,
	[DeliveredOn] [datetime] NULL,
	[IPAddress] [nvarchar](128) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[Active] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TypeGroup]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TypeGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Description] [varchar](50) NULL,
	[Active] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Types]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Types](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[TGroupID] [int] NULL,
	[Description] [varchar](50) NULL,
	[Active] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 05-Dec-19 9:04:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[ContactNo] [varchar](15) NULL,
	[EmailId] [varchar](50) NULL,
	[EmpNo] [varchar](50) NULL,
	[Gender] [int] NULL,
	[Active] [int] NULL,
	[RoleId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_BookPrice]  DEFAULT ((0)) FOR [BookPrice]
GO
