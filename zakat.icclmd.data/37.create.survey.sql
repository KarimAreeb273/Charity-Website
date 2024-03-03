--Development Script
USE [zakat]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[SURVEY]
GO

CREATE TABLE [dbo].[SURVEY](
	[surveyId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[email] [varchar](60) NULL,
	[phone] [varchar](10) NULL,
	[isFollowUp] [bit] NULL,
	[question1Stars] [int] NULL,
	[question2Stars] [int] NULL,
	[question3Stars] [int] NULL,
	[question4Option1] [bit] NULL,
	[question4Option2] [bit] NULL,
	[question4Option3] [bit] NULL,
	[question4Option4] [bit] NULL,
	[question4Option5] [bit] NULL,
	[question4Option6] [bit] NULL,
	[question4Option6Value] [varchar](50) NULL,
	[question5Option1] [bit] NULL,
	[question5Option2] [bit] NULL,
	[question5Option3] [bit] NULL,
	[question5Option4] [bit] NULL,
	[question5Option5] [bit] NULL,
	[question5Option6] [bit] NULL,
	[question5Option6Value] [varchar](50) NULL,
	[question6] [varchar](1000) NULL,
	[question7] [varchar](1000) NULL,
	[createdOn] [datetime] NULL,
 CONSTRAINT [PK_SURVEY] PRIMARY KEY CLUSTERED 
(
	[surveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Production Script
USE [ph14095182591_iccl_zakat]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [ph14095182591_iccl_zakat].[dbo].[SURVEY]
GO

CREATE TABLE [ph14095182591_iccl_zakat].[dbo].[SURVEY](
	[surveyId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[email] [varchar](60) NULL,
	[phone] [varchar](10) NULL,
	[isFollowUp] [bit] NULL,
	[question1Stars] [int] NULL,
	[question2Stars] [int] NULL,
	[question3Stars] [int] NULL,
	[question4Option1] [bit] NULL,
	[question4Option2] [bit] NULL,
	[question4Option3] [bit] NULL,
	[question4Option4] [bit] NULL,
	[question4Option5] [bit] NULL,
	[question4Option6] [bit] NULL,
	[question4Option6Value] [varchar](50) NULL,
	[question5Option1] [bit] NULL,
	[question5Option2] [bit] NULL,
	[question5Option3] [bit] NULL,
	[question5Option4] [bit] NULL,
	[question5Option5] [bit] NULL,
	[question5Option6] [bit] NULL,
	[question5Option6Value] [varchar](50) NULL,
	[question6] [varchar](1000) NULL,
	[question7] [varchar](1000) NULL,
	[createdOn] [datetime] NULL,
 CONSTRAINT [PK_SURVEY] PRIMARY KEY CLUSTERED 
(
	[surveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO