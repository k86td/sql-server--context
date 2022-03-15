USE [master]
GO

EXEC sys.sp_configure N'remote access', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

CREATE DATABASE [Testing];
GO

USE [Testing];
GO

CREATE TABLE [dbo.Test] (
    [id] INTEGER PRIMARY KEY
);
GO