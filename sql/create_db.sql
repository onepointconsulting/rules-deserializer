DROP TABLE IF EXISTS [dbo].[rule_definition_condition];
DROP TABLE IF EXISTS [dbo].[rule_definition]
DROP TABLE IF EXISTS [dbo].[rule_condition]

CREATE TABLE [dbo].[rule_condition](
	[ID] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[FIELD] [nvarchar](250) NOT NULL,
	[OPERATOR] [nvarchar](50) NOT NULL,
	[VALUE] [nvarchar](250) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[rule_definition](
	[ID] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[NAME] [nvarchar](255) NOT NULL UNIQUE,
	[OPERATOR] [nvarchar](50) NOT NULL,
	[EVENT_TYPE] [nvarchar](50) NOT NULL,
	[EVENT_DATA] [nvarchar](250) NOT NULL,
	[PARENT] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[rule_definition_condition](
	[ID] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[RULE_ID] [int] NOT NULL,
	[CONDITION_ID] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[rule_definition_condition] WITH CHECK ADD CONSTRAINT [FK_rule_definition_condition__rule_definition] FOREIGN KEY([RULE_ID])
REFERENCES [dbo].[rule_definition] ([ID])
GO

ALTER TABLE [dbo].[rule_definition_condition] WITH CHECK ADD CONSTRAINT [FK_rule_definition_condition__rule_condition] FOREIGN KEY([CONDITION_ID])
REFERENCES [dbo].[rule_condition] ([ID])
GO