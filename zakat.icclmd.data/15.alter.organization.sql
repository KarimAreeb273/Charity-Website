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
UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] SET [isDonationAccepted] = 1 WHERE [abbreviation] = 'ICCL';
UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] SET [payPalImageURL] = 'https://icclmd.org/wp-content/uploads/2023/09/iccl-new-design-front-oval-logo.png' WHERE [abbreviation] = 'ICCL';
UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] SET [payPalIdentityToken] = 'aBhn_hliWoUB9ncYDpRz-mWLQY6AXClPjhY85dwIbI7Wxdni7P2xcMU_3sG' WHERE [abbreviation] = 'ICCL';

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
UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] SET [isDonationAccepted] = 1 WHERE [abbreviation] = 'ICCL';
UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] SET [payPalImageURL] = 'https://icclmd.org/wp-content/uploads/2023/09/iccl-new-design-front-oval-logo.png' WHERE [abbreviation] = 'ICCL';
UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] SET [payPalIdentityToken] = '2xz9LEt6m6_4f09AfLVpUnentgrVX94ka-Me9xBhncPd0P99Rs9JAJKSOAS' WHERE [abbreviation] = 'ICCL';