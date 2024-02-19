-- development scripts:
ALTER TABLE [zakat].[dbo].[ORGANIZATION] DROP COLUMN IF EXISTS [missionStatement];
GO
ALTER TABLE [zakat].[dbo].[ORGANIZATION] ADD [missionStatement] varchar(4000);
GO

UPDATE [zakat].[dbo].[ORGANIZATION] SET [zakat].[dbo].[ORGANIZATION].[missionStatement] = 'The Maryland Institute of Development (MID) is a non-profit established to promote traditional Islamic learning and offer services to the community.  Our educational programs includes a traditional Islamic studies curriculum, a full-time tahfeezul Quran program, a sister''s tafseer program, and a program focusing on spiritual diseases of the heart and how to cure them.  Our teachers have studied with many prominent scholars and have multiple years of teaching and counseling experience.  Our services include counseling and local distribution of charity to those in need.' 
WHERE [abbreviation] = 'MID';
UPDATE [zakat].[dbo].[ORGANIZATION] SET [zakat].[dbo].[ORGANIZATION].[missionStatement] = 'The Islamic Community Center of Laurel was founded over 30 years ago in Laurel, Maryland. The aims and objectives of the Association are to serve the best interest of Islam to the Muslims of Laurel and nearby vicinity. The mission of the Association is as follows:<br /><br />1. Arrange and hold congregational prayers and Islamic festivities at appropriate times<br />2. Establish proper educational facilities to meet the Islamic educational needs of the Muslims<br />3. Conduct religious and social activities in the traditions of Islam according to Qur’an and Sunnah<br />4. Promote unity and joint action among the Muslims<br />5. Cooperate with other Islamic organizations and their activities<br />6. Promote friendly relations between Muslims and non-Muslims<br />7. Endeavor to make Islamic teachings known to interested non-Muslims<br />'
WHERE [abbreviation] = 'ICCL';
GO

-- production scripts:
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] DROP COLUMN IF EXISTS [missionStatement];
GO
ALTER TABLE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] ADD [missionStatement] varchar(4000);
GO

UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] SET [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION].[missionStatement] = 'The Maryland Institute of Development (MID) is a non-profit established to promote traditional Islamic learning and offer services to the community.  Our educational programs includes a traditional Islamic studies curriculum, a full-time tahfeezul Quran program, a sister''s tafseer program, and a program focusing on spiritual diseases of the heart and how to cure them.  Our teachers have studied with many prominent scholars and have multiple years of teaching and counseling experience.  Our services include counseling and local distribution of charity to those in need.' 
WHERE [abbreviation] = 'MID';
UPDATE [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION] SET [ph14095182591_iccl_zakat].[dbo].[ORGANIZATION].[missionStatement] = 'The Islamic Community Center of Laurel was founded over 30 years ago in Laurel, Maryland. The aims and objectives of the Association are to serve the best interest of Islam to the Muslims of Laurel and nearby vicinity. The mission of the Association is as follows:<br /><br />1. Arrange and hold congregational prayers and Islamic festivities at appropriate times<br />2. Establish proper educational facilities to meet the Islamic educational needs of the Muslims<br />3. Conduct religious and social activities in the traditions of Islam according to Qur’an and Sunnah<br />4. Promote unity and joint action among the Muslims<br />5. Cooperate with other Islamic organizations and their activities<br />6. Promote friendly relations between Muslims and non-Muslims<br />7. Endeavor to make Islamic teachings known to interested non-Muslims<br />'
WHERE [abbreviation] = 'ICCL';
GO