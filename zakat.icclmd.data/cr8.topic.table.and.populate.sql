-- Both Development and Production Script

/****** Object:  Table [dbo].[TOPIC]    Script Date: 5/29/2023 1:39:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOPIC](
	[topicId] [int] IDENTITY(1,1) NOT NULL,
	[topicName] [varchar](100) NULL,
	[topicContent] [varchar](max) NULL,
	[topicLink] [varchar](100) NULL,
 CONSTRAINT [PK_TOPIC] PRIMARY KEY CLUSTERED 
(
	[topicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Online Zakat Home Page','Online Zakat Login Username: Password: Or, Submit an Online Zakat Application! Current Average Duration To Process A Zakat Application: N/A (Average Duration Is From Application Submission to 2nd Qualification) Advantages of the Online Zakat System Save your online zakat application data electronically and securely Submit online zakat application(s) to one or more Islamic organizations Correspondence is sent/received via email when decisions are made Edit your saved profile as often as necessary Track the progress of your submitted online zakat application Complete the zakat form in a language that you understand Required Zakat Protocols and Documents Applicants, Prior to your completing an Online Zakat Application, please download, review and adhere to the following:','default')
INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Online Zakat Contact Us Page','Online Zakat Contact Information 7306 Contee Road Laurel, MD 20707 Ph: 301.317.4584 ICCL Office Manager: office@icclmd.org Online Zakat Administrator: zakat@icclmd.org ICCL General Website: https://www.icclmd.org Online Zakat Website: https://zakat.icclmd.org','contact')
GO

