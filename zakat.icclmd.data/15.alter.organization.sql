-- development scripts:
ALTER TABLE [zakat].[dbo].[ORGANIZATION] DROP COLUMN IF EXISTS [isDonationAccepted];
GO
ALTER TABLE [zakat].[dbo].[ORGANIZATION] DROP COLUMN IF EXISTS [payPalImageURL];
GO
ALTER TABLE [zakat].[dbo].[ORGANIZATION] DROP COLUMN IF EXISTS [payPalIdentityToken];
GO

ALTER TABLE [zakat].[dbo].[ORGANIZATION] ADD [isDonationAccepted] bit;
GO
ALTER TABLE [zakat].[dbo].[ORGANIZATION] ADD [payPalImageURL] varchar(250);
GO
ALTER TABLE [zakat].[dbo].[ORGANIZATION] ADD [payPalIdentityToken] varchar(100);
GO

-- production scripts:
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] DROP COLUMN IF EXISTS [isDonationAccepted];
GO
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] DROP COLUMN IF EXISTS [payPalImageURL];
GO
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] DROP COLUMN IF EXISTS [payPalIdentityToken];
GO

ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] ADD [isDonationAccepted] bit;
GO
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] ADD [payPalImageURL] varchar(250);
GO
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] ADD [payPalIdentityToken] varchar(100);
GO