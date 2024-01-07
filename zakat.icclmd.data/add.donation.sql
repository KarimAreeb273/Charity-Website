-- development scripts:

ALTER TABLE [zakat].[dbo].[DONATION] DROP CONSTRAINT IF EXISTS [FK_DONATION_ORGANIZATION];
GO

DROP TABLE IF EXISTS [zakat].[dbo].[DONATION]; 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [zakat].[dbo].[DONATION](
	[donationId] [int] IDENTITY(1,1) NOT NULL,
	[organizationId] [int] NULL,
	[firstName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[amount] [money] NULL,
	[donationDate] [datetime] NULL,
	[isConfirmed] [bit] NULL,
	[paypalPdtIsSuccessful] [bit] NULL,
	[paypalPdtConfirmDate] [datetime] NULL,
	[paypalPdtTransactionId] [varchar](50) NULL,
	[paypalPdtResponse] [varchar](4000) NULL,
	[paypalIpnIsSuccessful] [bit] NULL,
	[paypalIpnConfirmDate] [datetime] NULL,
	[paypalIpnTransactionId] [varchar](50) NULL,
	[paypalIpnResponse] [varchar](4000) NULL,
 CONSTRAINT [PK_DONATION] PRIMARY KEY CLUSTERED 
(
	[donationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [zakat].[dbo].[DONATION]  WITH CHECK ADD  CONSTRAINT [FK_DONATION_ORGANIZATION] FOREIGN KEY([organizationId])
REFERENCES [zakat].[dbo].[ORGANIZATION] ([organizationId])
GO
ALTER TABLE [zakat].[dbo].[DONATION] CHECK CONSTRAINT [FK_DONATION_ORGANIZATION]
GO

-- production scripts:

ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[DONATION] DROP CONSTRAINT IF EXISTS [FK_DONATION_ORGANIZATION];
GO

DROP TABLE IF EXISTS [ph14095182591_iccl_zakat].[dbo].[DONATION]; 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ph14095182591_iccl_zakat].[dbo].[DONATION](
	[donationId] [int] IDENTITY(1,1) NOT NULL,
	[organizationId] [int] NULL,
	[firstName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[amount] [money] NULL,
	[donationDate] [datetime] NULL,
	[isConfirmed] [bit] NULL,
	[paypalPdtIsSuccessful] [bit] NULL,
	[paypalPdtConfirmDate] [datetime] NULL,
	[paypalPdtTransactionId] [varchar](50) NULL,
	[paypalPdtResponse] [varchar](4000) NULL,
	[paypalIpnIsSuccessful] [bit] NULL,
	[paypalIpnConfirmDate] [datetime] NULL,
	[paypalIpnTransactionId] [varchar](50) NULL,
	[paypalIpnResponse] [varchar](4000) NULL,
 CONSTRAINT [PK_DONATION] PRIMARY KEY CLUSTERED 
(
	[donationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[DONATION]  WITH CHECK ADD  CONSTRAINT [FK_DONATION_ORGANIZATION] FOREIGN KEY([organizationId])
REFERENCES [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] ([organizationId])
GO
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[DONATION] CHECK CONSTRAINT [FK_DONATION_ORGANIZATION]
GO
