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

INSERT INTO dbo.Account (AcctNo, Fname, Lname, CreditLimit, Balance) VALUES
(12345678, 'Fred', 'Flintstone', $50, $250),
(23456789, 'Barney', 'Rubble', $4, $44),
(34567890, 'Bam-Bam', 'Rubble', $30, $10);

INSERT INTO dbo.Log (OrigAcct, LogDateTime, RecAcct, Amount) VALUES
(12345678, '2019-02-20 00:04:20.000', null, $420),
(23456789, '2018-12-25 10:10:10.010', 'Dinner Bill', $5),
(34567890, '2019-01-17 05:05:05.050', 'That thing I sent ya', $50);

END;