-- development scripts:
ALTER TABLE [zakat].[dbo].[APPLICATION] ADD [draftedOn] datetime;
GO

ALTER TABLE [zakat].[dbo].[APPLICATION] ADD [draftedBy] int;
GO

UPDATE [zakat].[dbo].[APPLICATION] set [zakat].[dbo].[APPLICATION].[draftedOn] = (select [zakat].[dbo].[APPLICATION].createdOn);
GO

UPDATE [zakat].[dbo].[APPLICATION] set [zakat].[dbo].[APPLICATION].[draftedBy] = (select [zakat].[dbo].[APPLICATION].createdBy);
GO

-- production scripts:
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[APPLICATION] ADD [draftedOn] datetime;
GO

ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[APPLICATION] ADD [draftedBy] int;
GO

UPDATE [ph14095182591_iccl_zakat].[dbo].[APPLICATION] set [draftedOn] = (select [ph14095182591_iccl_zakat].[dbo].[APPLICATION].createdOn);
GO

UPDATE [ph14095182591_iccl_zakat].[dbo].[APPLICATION] set [draftedBy] = (select [ph14095182591_iccl_zakat].[dbo].[APPLICATION].createdBy);
GO