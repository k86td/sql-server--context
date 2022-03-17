USE [master]
GO

EXEC sys.sp_configure N'remote access', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

CREATE LOGIN [__ADMIN__] WITH PASSWORD = '__PASSWORD__';
CREATE USER [__ADMIN__] FOR LOGIN [__ADMIN__];
GO

EXEC sp_addsrvrolemember @loginname = N'__ADMIN__', @rolename = N'sysadmin'
