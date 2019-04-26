﻿CREATE TABLE [dbo].[Account]
(
	[AcctID] INT NOT NULL,
	[Fname] NVARCHAR(50) NOT NULL,
	[Lname] NVARCHAR(50) NOT NULL,
	[CreditLimit] Money,
	[Balance] Money,
	
	CONSTRAINT PK_ACCOUNT PRIMARY KEY (AcctID),
	CONSTRAINT UQ_ACCOUNT_FNAME_LNAME UNIQUE (Fname, Lname),
	CONSTRAINT CK_ACCOUNT_CREDITLIMIT CHECK (CreditLimit < 0),
	CONSTRAINT CK_ACCOUNT_BALANCE CHECK (Balance > CreditLimit)	
)