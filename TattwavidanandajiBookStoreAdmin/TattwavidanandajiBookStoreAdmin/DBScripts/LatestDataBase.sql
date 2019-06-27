USE [tattvavidanandaBooksStore]
GO
/****** Object:  StoredProcedure [dbo].[GetBookList]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
      --,(Select Name from Types where Id=BookStock) as [BookStock]
	  ,[BookStock]
      ,[BookDescription]
      ,(Select Name from Types where Id=[BookType]) as [BookType]
      ,[BookPrice]
  FROM [Book]

  End
GO
/****** Object:  StoredProcedure [dbo].[Gettypesdata]    Script Date: 25-Jun-19 9:58:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Gettypesdata]
@booktype int =-1
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
End
GO
/****** Object:  StoredProcedure [dbo].[InsUpdDelBook]    Script Date: 25-Jun-19 9:58:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[InsUpdDelBook]
@BookTitle varchar(250)=null,@BookImage varchar(max)=null,@BookStock int=0,
@BookDescription varchar(max)=null,@BookType int,@BoolPrice decimal(18,0)=null,@Id int=null,@flag varchar
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

INSERT INTO [dbo].[Book]([BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice])
				  VALUES(@BookTitle,@BookImage,@BookStock,@BookDescription,@BookType,@BoolPrice)


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
begin
update Book set [BookTitle]=@BookTitle,[BookImage]=@BookImage,[BookStock]=@BookStock,[BookDescription]=@BookDescription,[BookType]=@BookType,[BookPrice]=@BoolPrice where Id=@Id 
select Id, [BookTitle],[BookImage],[BookStock],[BookDescription],[BookType],[BookPrice],Active from Book
End
End

end
GO
/****** Object:  StoredProcedure [dbo].[UpdateActiveBooklist]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
/****** Object:  StoredProcedure [dbo].[ValidationUserLogins]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
/****** Object:  Table [dbo].[Book]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
/****** Object:  Table [dbo].[LoginInfo]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
/****** Object:  Table [dbo].[TypeGroup]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
/****** Object:  Table [dbo].[Types]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 25-Jun-19 9:58:00 AM ******/
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
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([Id], [BookTitle], [BookImage], [BookStock], [BookDescription], [BookType], [BookPrice], [Active]) VALUES (1, N'Jnana Yoga', NULL, 5, NULL, 7, CAST(0 AS Decimal(18, 0)), 1)
INSERT [dbo].[Book] ([Id], [BookTitle], [BookImage], [BookStock], [BookDescription], [BookType], [BookPrice], [Active]) VALUES (2, N'KarmaYoga', NULL, 5, NULL, 7, CAST(0 AS Decimal(18, 0)), 1)
SET IDENTITY_INSERT [dbo].[Book] OFF
SET IDENTITY_INSERT [dbo].[LoginInfo] ON 

INSERT [dbo].[LoginInfo] ([Id], [UserLogin], [PassWord], [UserId], [Active]) VALUES (1, N'Admin', N'Admin', 1, 1)
SET IDENTITY_INSERT [dbo].[LoginInfo] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [Name], [Description], [Active]) VALUES (1, N'Admin', N'Full Access the site', 1)
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[TypeGroup] ON 

INSERT [dbo].[TypeGroup] ([Id], [Name], [Description], [Active]) VALUES (1, N'Stock', N'This is Stock', 1)
INSERT [dbo].[TypeGroup] ([Id], [Name], [Description], [Active]) VALUES (2, N'Status', N'This is Status', 1)
INSERT [dbo].[TypeGroup] ([Id], [Name], [Description], [Active]) VALUES (3, N'BookType', N'This is book type', 1)
SET IDENTITY_INSERT [dbo].[TypeGroup] OFF
SET IDENTITY_INSERT [dbo].[Types] ON 

INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (1, N'No Stock', 1, N'Empty Stock', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (2, N'Success', 2, N'This is Status', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (3, N'Failed', 2, N'This is Status', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (4, N'Pending', 2, N'This is Status', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (5, N'NotEmpty', 1, N'Not Empty', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (6, N'Paper Bond', 3, N'This is paper bond', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (7, N'Hard Bond', 3, N'This is hard bond', 1)
SET IDENTITY_INSERT [dbo].[Types] OFF
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([Id], [UserId], [RoleId]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [ContactNo], [EmailId], [EmpNo], [Gender], [Active], [RoleId]) VALUES (1, N'Admin', N'Admin', N'7893890990', N'a@gmail.com', NULL, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_BookPrice]  DEFAULT ((0)) FOR [BookPrice]
GO
