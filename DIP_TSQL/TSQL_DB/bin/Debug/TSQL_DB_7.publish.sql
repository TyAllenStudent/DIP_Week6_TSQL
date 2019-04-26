﻿/*
Deployment script for TSQL_DB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar LoadTestData "true"
:setvar DatabaseName "TSQL_DB"
:setvar DefaultFilePrefix "TSQL_DB"
:setvar DefaultDataPath "C:\Users\Ty\AppData\Local\Microsoft\VisualStudio\SSDT"
:setvar DefaultLogPath "C:\Users\Ty\AppData\Local\Microsoft\VisualStudio\SSDT"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Dropping [dbo].[CK_ACCOUNT_CREDITLIMIT]...';


GO
ALTER TABLE [dbo].[Account] DROP CONSTRAINT [CK_ACCOUNT_CREDITLIMIT];


GO
PRINT N'Creating [dbo].[CK_ACCOUNT_CREDITLIMIT]...';


GO
ALTER TABLE [dbo].[Account] WITH NOCHECK
    ADD CONSTRAINT [CK_ACCOUNT_CREDITLIMIT] CHECK (CreditLimit > 0);


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF '$(LoadTestData)' = 'true'

BEGIN

DELETE FROM dbo.Account;
DELETE FROM dbo.Log;

INSERT INTO dbo.Account (AcctID, Fname, Lname, CreditLimit, Balance) VALUES
(12345678, 'Fred', 'Flintstone', 50, 250),
(23456789, 'Barney', 'Rubble', 4, 44),
(34567890, 'Bam-Bam', 'Rubble', 30, 10);

INSERT INTO dbo.Log (OrigAcct, LogDateTime, RecAcct, Amount) VALUES
(12345678, '2019-02-20 00:04:20.000', null, 420),
(23456789, '2018-12-25 10:10:10.010', 'Dinner Bill', 5),
(34567890, '2019-01-17 05:05:05.050', 'That thing I sent ya', 50);

END;
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Account] WITH CHECK CHECK CONSTRAINT [CK_ACCOUNT_CREDITLIMIT];


GO
PRINT N'Update complete.';


GO
