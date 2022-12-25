-- development scripts:
-- pre scripts
ALTER TABLE [zakat].[dbo].[USER] DROP COLUMN [passwordEncrypted];
GO

ALTER TABLE [zakat].[dbo].[USER] ADD [passwordEncrypted] varchar(max);
GO

ALTER TABLE [zakat].[dbo].[USER] DROP COLUMN [socialSecurityNumberEncrypted];
GO

ALTER TABLE [zakat].[dbo].[USER] ADD [socialSecurityNumberEncrypted] varchar(max);
GO

-- post scripts; execute after edmx model change
ALTER TABLE [zakat].[dbo].[USER] DROP COLUMN [password];
ALTER TABLE [zakat].[dbo].[USER] DROP COLUMN [socialSecurityNumber];
GO

-- production scripts:
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[USER] DROP COLUMN [passwordEncrypted];
GO

ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[USER] ADD [passwordEncrypted] varchar(max);
GO

ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[USER] DROP COLUMN [socialSecurityNumberEncrypted];
GO

ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[USER] ADD [socialSecurityNumberEncrypted] varchar(max);
GO

-- post scripts; execute after edmx model change
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[USER] DROP COLUMN [password];
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[USER] DROP COLUMN [socialSecurityNumber];
GO