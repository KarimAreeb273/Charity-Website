-- development scripts:
ALTER TABLE [zakat].[dbo].[ORGANIZATION] ADD COLUMN [abbreviation] varchar(10);;
GO

UPDATE [zakat].[dbo].[ORGANIZATION] set [abbreviation] = 'ICCL' WHERE name = 'Islamic Community Center of Laurel';
GO

-- production scripts:
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] ADD COLUMN [abbreviation] varchar(10);;
GO

UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] set [abbreviation] = 'ICCL' WHERE name = 'Islamic Community Center of Laurel';
GO