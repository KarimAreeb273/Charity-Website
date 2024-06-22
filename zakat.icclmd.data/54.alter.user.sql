-- development scripts:
ALTER TABLE [zakat].[dbo].[USER] DROP COLUMN IF EXISTS [isNotSchooled];
GO
ALTER TABLE [zakat].[dbo].[USER] ADD [isNotSchooled] bit;
GO
UPDATE [zakat].[dbo].[USER] SET [zakat].[dbo].[USER].[isNotSchooled] = 0;
GO

-- production scripts:
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[USER] DROP COLUMN IF EXISTS [isNotSchooled];
GO
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[USER] ADD [isNotSchooled] bit;
GO
UPDATE [ph14095182591_iccl_zakat].[dbo].[USER] SET [zakat].[dbo].[USER].[isNotSchooled] = 0;
GO