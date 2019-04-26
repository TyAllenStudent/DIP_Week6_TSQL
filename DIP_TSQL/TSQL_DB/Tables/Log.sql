CREATE TABLE [dbo].[Log]
(
	[OrigAcct] INT NOT NULL,
	[LogDateTime] DateTime,
	[RecAcct] int,
	[Amount] Money NOT NULL,
	
	CONSTRAINT PK_LOG PRIMARY KEY (OrigAcct, LogDateTime),
	CONSTRAINT FK_LOG_ACCOUNT FOREIGN KEY (OrigAcct) REFERENCES dbo.Account(AcctID)
)