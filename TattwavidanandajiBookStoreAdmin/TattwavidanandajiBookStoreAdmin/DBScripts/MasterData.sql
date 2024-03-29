
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
INSERT [dbo].[TypeGroup] ([Id], [Name], [Description], [Active]) VALUES (4, N'Label', N'This is label type', 1)
INSERT [dbo].[TypeGroup] ([Id], [Name], [Description], [Active]) VALUES (5, N'Language', N'This is language type', 1)
SET IDENTITY_INSERT [dbo].[TypeGroup] OFF
SET IDENTITY_INSERT [dbo].[Types] ON 

INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (1, N'No Stock', 1, N'Empty Stock', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (2, N'Success', 2, N'This is Status', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (3, N'Failed', 2, N'This is Status', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (4, N'Pending', 2, N'This is Status', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (5, N'Available', 1, N'Stock Available', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (6, N'Paper Bond', 3, N'This is paper bond', 1)
INSERT [dbo].[Types] ([Id], [Name], [TGroupID], [Description], [Active]) VALUES (7, N'Hard Bond', 3, N'This is hard bond', 1)
SET IDENTITY_INSERT [dbo].[Types] OFF
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([Id], [UserId], [RoleId]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [ContactNo], [EmailId], [EmpNo], [Gender], [Active], [RoleId]) VALUES (1, N'Admin', N'Admin', N'7893890990', N'a@gmail.com', NULL, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
