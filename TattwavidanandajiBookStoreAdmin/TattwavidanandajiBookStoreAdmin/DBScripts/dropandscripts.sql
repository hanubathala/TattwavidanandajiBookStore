USE [tattvavidanandaBooksStore]
GO
ALTER TABLE [dbo].[Book] DROP CONSTRAINT [DF_Book_BookPrice]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[UserRoles]
GO
/****** Object:  Table [dbo].[Types]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[Types]
GO
/****** Object:  Table [dbo].[TypeGroup]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[TypeGroup]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[Roles]
GO
/****** Object:  Table [dbo].[LoginInfo]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[LoginInfo]
GO
/****** Object:  Table [dbo].[CustomerAddressBook]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[CustomerAddressBook]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[Customer]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP TABLE [dbo].[Book]
GO
/****** Object:  StoredProcedure [dbo].[ValidationUserLogins]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[ValidationUserLogins]
GO
/****** Object:  StoredProcedure [dbo].[UpdateActiveBooklist]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[UpdateActiveBooklist]
GO
/****** Object:  StoredProcedure [dbo].[InsUpdTypes]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[InsUpdTypes]
GO
/****** Object:  StoredProcedure [dbo].[InsUpdTypeGroups]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[InsUpdTypeGroups]
GO
/****** Object:  StoredProcedure [dbo].[InsUpdDelCustomer]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[InsUpdDelCustomer]
GO
/****** Object:  StoredProcedure [dbo].[InsUpdDelBook]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[InsUpdDelBook]
GO
/****** Object:  StoredProcedure [dbo].[Gettypesdata]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[Gettypesdata]
GO
/****** Object:  StoredProcedure [dbo].[GetTypesByPaging]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[GetTypesByPaging]
GO
/****** Object:  StoredProcedure [dbo].[GetTypeGroupsconfig]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[GetTypeGroupsconfig]
GO
/****** Object:  StoredProcedure [dbo].[GetTypegroups]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[GetTypegroups]
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerList]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[GetCustomerList]
GO
/****** Object:  StoredProcedure [dbo].[GetBookListConfig]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[GetBookListConfig]
GO
/****** Object:  StoredProcedure [dbo].[GetBookListbyId]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[GetBookListbyId]
GO
/****** Object:  StoredProcedure [dbo].[GetBookList]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[GetBookList]
GO
/****** Object:  StoredProcedure [dbo].[EOTPverification]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[EOTPverification]
GO
/****** Object:  StoredProcedure [dbo].[CustomerLoginsValidate]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP PROCEDURE [dbo].[CustomerLoginsValidate]
GO
/****** Object:  User [IIS APPPOOL\VIHE_Working]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP USER [IIS APPPOOL\VIHE_Working]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP USER [NT AUTHORITY\SYSTEM]
GO
/****** Object:  User [NT Service\MSSQLSERVER]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP USER [NT Service\MSSQLSERVER]
GO
/****** Object:  User [NT SERVICE\ReportServer]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP USER [NT SERVICE\ReportServer]
GO
/****** Object:  User [NT SERVICE\SQLSERVERAGENT]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP USER [NT SERVICE\SQLSERVERAGENT]
GO
/****** Object:  User [NT SERVICE\SQLWriter]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP USER [NT SERVICE\SQLWriter]
GO
/****** Object:  User [NT SERVICE\Winmgmt]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP USER [NT SERVICE\Winmgmt]
GO
USE [master]
GO
/****** Object:  Database [tattvavidanandaBooksStore]    Script Date: 21-Nov-19 9:32:38 AM ******/
DROP DATABASE [tattvavidanandaBooksStore]
GO
/****** Object:  Database [tattvavidanandaBooksStore]    Script Date: 21-Nov-19 9:32:38 AM ******/
CREATE DATABASE [tattvavidanandaBooksStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tattvavidanandaBooksStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\tattvavidanandaBooksStore.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'tattvavidanandaBooksStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\tattvavidanandaBooksStore_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tattvavidanandaBooksStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET RECOVERY FULL 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET  MULTI_USER 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'tattvavidanandaBooksStore', N'ON'
GO
USE [tattvavidanandaBooksStore]
GO
/****** Object:  User [NT SERVICE\Winmgmt]    Script Date: 21-Nov-19 9:32:38 AM ******/
CREATE USER [NT SERVICE\Winmgmt] FOR LOGIN [NT SERVICE\Winmgmt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT SERVICE\SQLWriter]    Script Date: 21-Nov-19 9:32:38 AM ******/
CREATE USER [NT SERVICE\SQLWriter] FOR LOGIN [NT SERVICE\SQLWriter] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT SERVICE\SQLSERVERAGENT]    Script Date: 21-Nov-19 9:32:38 AM ******/
CREATE USER [NT SERVICE\SQLSERVERAGENT] FOR LOGIN [NT SERVICE\SQLSERVERAGENT] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT SERVICE\ReportServer]    Script Date: 21-Nov-19 9:32:38 AM ******/
CREATE USER [NT SERVICE\ReportServer] FOR LOGIN [NT SERVICE\ReportServer] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT Service\MSSQLSERVER]    Script Date: 21-Nov-19 9:32:38 AM ******/
CREATE USER [NT Service\MSSQLSERVER] FOR LOGIN [NT Service\MSSQLSERVER] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 21-Nov-19 9:32:38 AM ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IIS APPPOOL\VIHE_Working]    Script Date: 21-Nov-19 9:32:38 AM ******/
CREATE USER [IIS APPPOOL\VIHE_Working] FOR LOGIN [IIS APPPOOL\VIHE_Working] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT SERVICE\Winmgmt]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT SERVICE\SQLWriter]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT SERVICE\SQLSERVERAGENT]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT SERVICE\ReportServer]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT Service\MSSQLSERVER]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
ALTER ROLE [db_owner] ADD MEMBER [IIS APPPOOL\VIHE_Working]
GO
/****** Object:  StoredProcedure [dbo].[CustomerLoginsValidate]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EOTPverification]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetBookList]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetBookListbyId]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetBookListConfig]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
  FROM [Book] where Active=1
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
  FROM [Book] where Active=1)as temp
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
/****** Object:  StoredProcedure [dbo].[GetCustomerList]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetTypegroups]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetTypeGroupsconfig]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetTypesByPaging]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Gettypesdata]    Script Date: 21-Nov-19 9:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Gettypesdata]
@booktype int =-1,@labeltype int =-1,@languagetype int =-1
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
End
GO
/****** Object:  StoredProcedure [dbo].[InsUpdDelBook]    Script Date: 21-Nov-19 9:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[InsUpdDelBook]
@BookTitle varchar(250)=null,@BookImage varchar(max)=null,@BookStock int=0,@BookDescription varchar(max)=null,@BookType int,@BoolPrice decimal(18,0)=null,@Id int,@flag varchar
,@Active int=null

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

INSERT INTO [dbo].[Book]([BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice],Active)
				  VALUES(@BookTitle,@BookImage,@BookStock,@BookDescription,@BookType,@BoolPrice,1)


select Id, [BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice],Active from Book
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
update Book set [BookTitle]=@BookTitle,[BookImage]=@BookImage,[BookStock]=@BookStock,[BookDescription]=@BookDescription,[BookType]=@BookType,[BookPrice]=@BoolPrice,Active=@Active where Id=@Id 
select Id, [BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice],Active from Book
End
end
End








GO
/****** Object:  StoredProcedure [dbo].[InsUpdDelCustomer]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsUpdTypeGroups]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsUpdTypes]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateActiveBooklist]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[ValidationUserLogins]    Script Date: 21-Nov-19 9:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[ValidationUserLogins]
(@logininfo varchar(50) = null, @passkey varchar(50) = null)
as
begin
Select  us.FirstName+''+us.LastName as UserName,ur.RoleId from LoginInfo  li
           inner join Users us on li.UserId=us.Id
		   inner join UserRoles ur on us.Id=ur.UserId
		   inner join Roles rl on ur.RoleId=rl.Id
		  where li.UserLogin=@logininfo and li.PassWord=@passkey and li.Active=1 
End
GO
/****** Object:  Table [dbo].[Book]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
	[Active] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[CustomerAddressBook]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[LoginInfo]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[TypeGroup]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[Types]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 21-Nov-19 9:32:39 AM ******/
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
USE [master]
GO
ALTER DATABASE [tattvavidanandaBooksStore] SET  READ_WRITE 
GO
