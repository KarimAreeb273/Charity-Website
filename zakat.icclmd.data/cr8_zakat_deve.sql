USE [zakat]
GO
/****** Object:  Table [dbo].[APPLICATION]    Script Date: 3/15/2020 9:44:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APPLICATION](
	[applicationId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[organizationId] [int] NOT NULL,
	[isDrafted] [bit] NULL,
	[isSubmitted] [bit] NULL,
	[isValidated] [bit] NULL,
	[isInvestigated] [bit] NULL,
	[isQualified1] [bit] NULL,
	[isQualified2] [bit] NULL,
	[isDispersed] [bit] NULL,
	[isRejected] [bit] NULL,
	[applicationStatus] [varchar](20) NULL,
	[totalValueCash] [money] NULL,
	[totalValueGold] [money] NULL,
	[totalValueSilver] [money] NULL,
	[totalValueInvestment] [money] NULL,
	[hasRetirement] [bit] NULL,
	[totalValueRetirement] [money] NULL,
	[hasOutstandingDebts] [bit] NULL,
	[totalValueOutstandingDebts] [money] NULL,
	[hasHealthInsurance] [varchar](10) NULL,
	[medicaidNumber] [varchar](9) NULL,
	[medicareNumber] [varchar](11) NULL,
	[healthInsuranceProviderName] [varchar](100) NULL,
	[healthInsuranceProviderPolicyNumber] [varchar](25) NULL,
	[hasLifeInsurance] [bit] NULL,
	[totalValueLifeInsurance] [money] NULL,
	[hasChildSupport] [bit] NULL,
	[totalChildSupport] [money] NULL,
	[frequencyChildSupport] [varchar](15) NULL,
	[hasFoodStamps] [bit] NULL,
	[totalFoodStamps] [money] NULL,
	[frequencyFoodStamps] [varchar](15) NULL,
	[hasTemporaryCashAssistance] [bit] NULL,
	[sourceTemporaryCashAssistance] [varchar](100) NULL,
	[totalTemporaryCashAssistance] [money] NULL,
	[isEmployerCurrent] [bit] NULL,
	[employerName] [varchar](100) NULL,
	[positionTitle] [varchar](100) NULL,
	[totalMonthlyGrossSalary] [money] NULL,
	[employmentStartDate] [datetime] NULL,
	[employmentEndtDate] [datetime] NULL,
	[employerStreet] [varchar](100) NULL,
	[employerCity] [varchar](50) NULL,
	[employerStateAbbr] [varchar](15) NULL,
	[employerZip] [varchar](5) NULL,
	[employerPhone] [varchar](10) NULL,
	[personalNeedStatement] [varchar](1000) NULL,
	[submittedOn] [datetime] NULL,
	[submittedBy] [int] NULL,
	[validatedOn] [datetime] NULL,
	[validatedBy] [int] NULL,
	[investigatedOn] [datetime] NULL,
	[investigatedBy] [int] NULL,
	[qualified1On] [datetime] NULL,
	[qualified1By] [int] NULL,
	[qualified2On] [datetime] NULL,
	[qualified2By] [int] NULL,
	[dispersedOn] [datetime] NULL,
	[dispersedBy] [int] NULL,
	[rejectedOn] [datetime] NULL,
	[rejectedBy] [int] NULL,
	[createdOn] [datetime] NULL,
	[createdBy] [int] NULL,
	[updatedOn] [datetime] NULL,
	[updatedBy] [int] NULL,
 CONSTRAINT [PK_APPLICATION] PRIMARY KEY CLUSTERED 
(
	[applicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARTIFACT]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTIFACT](
	[artifactId] [int] IDENTITY(1,1) NOT NULL,
	[applicationId] [int] NULL,
	[artifact] [varbinary](max) NULL,
 CONSTRAINT [PK_ARTIFACT] PRIMARY KEY CLUSTERED 
(
	[artifactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CERTIFICATION_SKILL]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CERTIFICATION_SKILL](
	[certificationSkillId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[certificationSkill] [varchar](100) NULL,
 CONSTRAINT [PK_CERTIFICATION_SKILL] PRIMARY KEY CLUSTERED 
(
	[certificationSkillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEPENDENT]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEPENDENT](
	[dependentId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[firstName] [varchar](30) NULL,
	[middleName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[dob] [datetime] NULL,
	[gender] [varchar](10) NULL,
	[relationship] [varchar](20) NULL,
 CONSTRAINT [PK_DEPDENDENTS] PRIMARY KEY CLUSTERED 
(
	[dependentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LANGUAGE]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LANGUAGE](
	[languageId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NULL,
 CONSTRAINT [PK_LANGUAGE] PRIMARY KEY CLUSTERED 
(
	[languageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NATIONALITY]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NATIONALITY](
	[nationalityId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_NATIONALITY] PRIMARY KEY CLUSTERED 
(
	[nationalityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORGANIZATION]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORGANIZATION](
	[organizationId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[street] [varchar](100) NULL,
	[city] [varchar](50) NULL,
	[stateAbbr] [varchar](15) NULL,
	[zip] [varchar](5) NULL,
	[email] [varchar](60) NULL,
	[phone] [varchar](10) NULL,
	[website] [varchar](250) NULL,
 CONSTRAINT [PK_ORGANIZATION] PRIMARY KEY CLUSTERED 
(
	[organizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REFERENCE]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REFERENCE](
	[referenceId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[firstName] [varchar](30) NULL,
	[middleName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[phone] [varchar](10) NULL,
	[knownSince] [datetime] NULL,
	[relationship] [varchar](10) NULL,
	[street] [varchar](100) NULL,
	[city] [varchar](50) NULL,
	[stateAbbr] [varchar](15) NULL,
	[zip] [varchar](5) NULL,
 CONSTRAINT [PK_REFERENCE] PRIMARY KEY CLUSTERED 
(
	[referenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REVIEW]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REVIEW](
	[reviewId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[applicationId] [int] NULL,
	[reviewAction] [varchar](20) NULL,
	[reviewComment] [varchar](1000) NULL,
	[reviewDate] [datetime] NULL,
 CONSTRAINT [PK_COMMENT] PRIMARY KEY CLUSTERED 
(
	[reviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE](
	[roleId] [int] NOT NULL,
	[name] [varchar](20) NULL,
	[description] [varchar](250) NULL,
 CONSTRAINT [PK_ROLE] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STATE]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STATE](
	[stateAbbr] [varchar](15) NOT NULL,
	[stateName] [varchar](30) NULL,
 CONSTRAINT [PK_STATE] PRIMARY KEY CLUSTERED 
(
	[stateAbbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](60) NOT NULL,
	[password] [varchar](20) NULL,
	[firstName] [varchar](30) NOT NULL,
	[middleName] [varchar](30) NULL,
	[lastName] [varchar](30) NOT NULL,
	[gender] [varchar](10) NULL,
	[maritalStatus] [varchar](15) NULL,
	[dob] [datetime] NULL,
	[socialSecurityNumber] [varchar](9) NULL,
	[nationalityId] [int] NULL,
	[citizenshipStatus] [varchar](20) NULL,
	[phone] [varchar](10) NULL,
	[street] [varchar](100) NULL,
	[city] [varchar](50) NULL,
	[stateAbbr] [varchar](15) NULL,
	[zip] [varchar](5) NULL,
	[beganLivingDate] [datetime] NULL,
	[homeType] [varchar](15) NULL,
	[homeTypeOther] [varchar](50) NULL,
	[husbandFirstName] [varchar](30) NULL,
	[husbandMiddleName] [varchar](30) NULL,
	[husbandLastName] [varchar](30) NULL,
	[husbandPhone] [varchar](10) NULL,
	[husbandEmail] [varchar](60) NULL,
	[husbandHasAppliedForZakat] [varchar](10) NULL,
	[husbandZakatExplanation] [varchar](4000) NULL,
	[highestEducationCompleted] [varchar](50) NULL,
	[schoolName] [varchar](100) NULL,
	[schoolStreet] [varchar](100) NULL,
	[schoolCity] [varchar](50) NULL,
	[schoolStateAbbr] [varchar](15) NULL,
	[schoolZip] [varchar](5) NULL,
	[primaryMasjidName] [varchar](100) NULL,
	[primaryMasjidPhone] [varchar](10) NULL,
	[createdOn] [datetime] NULL,
	[createdBy] [int] NULL,
	[updatedOn] [datetime] NULL,
	[updatedBy] [int] NULL,
 CONSTRAINT [PK_MEMBER] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER_LANGUAGE]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER_LANGUAGE](
	[userLanguageId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[languageId] [int] NULL,
 CONSTRAINT [PK_USER_LANGUAGE] PRIMARY KEY CLUSTERED 
(
	[userLanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER_ROLE]    Script Date: 4/2/2020 5:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER_ROLE](
	[userRoleId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[roleId] [int] NULL,
	[organizationId] [int] NULL,
 CONSTRAINT [PK_USER_ROLE] PRIMARY KEY CLUSTERED 
(
	[userRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_isSaved]  DEFAULT ((1)) FOR [isDrafted]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_isSubmitted]  DEFAULT ((0)) FOR [isSubmitted]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_isValidated]  DEFAULT ((0)) FOR [isValidated]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_isInvestigated]  DEFAULT ((0)) FOR [isInvestigated]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_isQualified]  DEFAULT ((0)) FOR [isQualified1]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_isQualified11]  DEFAULT ((0)) FOR [isQualified2]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_IsDispersed]  DEFAULT ((0)) FOR [isDispersed]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_createdOn1]  DEFAULT (getdate()) FOR [submittedOn]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_createdOn]  DEFAULT (getdate()) FOR [createdOn]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_updatedOn]  DEFAULT (getdate()) FOR [updatedOn]
GO
ALTER TABLE [dbo].[REVIEW] ADD  CONSTRAINT [DF_REVIEW_reviewDate]  DEFAULT (getdate()) FOR [reviewDate]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_createdOn]  DEFAULT (getdate()) FOR [createdOn]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_updatedOn]  DEFAULT (getdate()) FOR [updatedOn]
GO
ALTER TABLE [dbo].[APPLICATION]  WITH CHECK ADD  CONSTRAINT [FK_APPLICATION_ORGANIZATION] FOREIGN KEY([organizationId])
REFERENCES [dbo].[ORGANIZATION] ([organizationId])
GO
ALTER TABLE [dbo].[APPLICATION] CHECK CONSTRAINT [FK_APPLICATION_ORGANIZATION]
GO
ALTER TABLE [dbo].[APPLICATION]  WITH CHECK ADD  CONSTRAINT [FK_APPLICATION_STATE] FOREIGN KEY([employerStateAbbr])
REFERENCES [dbo].[STATE] ([stateAbbr])
GO
ALTER TABLE [dbo].[APPLICATION] CHECK CONSTRAINT [FK_APPLICATION_STATE]
GO
ALTER TABLE [dbo].[APPLICATION]  WITH CHECK ADD  CONSTRAINT [FK_APPLICATION_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[APPLICATION] CHECK CONSTRAINT [FK_APPLICATION_USER]
GO
ALTER TABLE [dbo].[ARTIFACT]  WITH CHECK ADD  CONSTRAINT [FK_ARTIFACT_APPLICATION] FOREIGN KEY([applicationId])
REFERENCES [dbo].[APPLICATION] ([applicationId])
GO
ALTER TABLE [dbo].[ARTIFACT] CHECK CONSTRAINT [FK_ARTIFACT_APPLICATION]
GO
ALTER TABLE [dbo].[CERTIFICATION_SKILL]  WITH CHECK ADD  CONSTRAINT [FK_CERTIFICATION_SKILL_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[CERTIFICATION_SKILL] CHECK CONSTRAINT [FK_CERTIFICATION_SKILL_USER]
GO
ALTER TABLE [dbo].[DEPENDENT]  WITH CHECK ADD  CONSTRAINT [FK_DEPDENDENTS_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[DEPENDENT] CHECK CONSTRAINT [FK_DEPDENDENTS_USER]
GO
ALTER TABLE [dbo].[ORGANIZATION]  WITH CHECK ADD  CONSTRAINT [FK_ORGANIZATION_STATE] FOREIGN KEY([stateAbbr])
REFERENCES [dbo].[STATE] ([stateAbbr])
GO
ALTER TABLE [dbo].[ORGANIZATION] CHECK CONSTRAINT [FK_ORGANIZATION_STATE]
GO
ALTER TABLE [dbo].[REFERENCE]  WITH CHECK ADD  CONSTRAINT [FK_REFERENCE_STATE] FOREIGN KEY([stateAbbr])
REFERENCES [dbo].[STATE] ([stateAbbr])
GO
ALTER TABLE [dbo].[REFERENCE] CHECK CONSTRAINT [FK_REFERENCE_STATE]
GO
ALTER TABLE [dbo].[REFERENCE]  WITH CHECK ADD  CONSTRAINT [FK_REFERENCE_USER1] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[REFERENCE] CHECK CONSTRAINT [FK_REFERENCE_USER1]
GO
ALTER TABLE [dbo].[REVIEW]  WITH CHECK ADD  CONSTRAINT [FK_COMMENT_APPLICATION] FOREIGN KEY([applicationId])
REFERENCES [dbo].[APPLICATION] ([applicationId])
GO
ALTER TABLE [dbo].[REVIEW] CHECK CONSTRAINT [FK_COMMENT_APPLICATION]
GO
ALTER TABLE [dbo].[REVIEW]  WITH CHECK ADD  CONSTRAINT [FK_COMMENT_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[REVIEW] CHECK CONSTRAINT [FK_COMMENT_USER]
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD  CONSTRAINT [FK_USER_NATIONALITY1] FOREIGN KEY([nationalityId])
REFERENCES [dbo].[NATIONALITY] ([nationalityId])
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_NATIONALITY1]
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD  CONSTRAINT [FK_USER_STATE] FOREIGN KEY([stateAbbr])
REFERENCES [dbo].[STATE] ([stateAbbr])
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_STATE]
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD  CONSTRAINT [FK_USER_STATE1] FOREIGN KEY([schoolStateAbbr])
REFERENCES [dbo].[STATE] ([stateAbbr])
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_STATE1]
GO
ALTER TABLE [dbo].[USER_LANGUAGE]  WITH CHECK ADD  CONSTRAINT [FK_USER_LANGUAGE_LANGUAGE] FOREIGN KEY([languageId])
REFERENCES [dbo].[LANGUAGE] ([languageId])
GO
ALTER TABLE [dbo].[USER_LANGUAGE] CHECK CONSTRAINT [FK_USER_LANGUAGE_LANGUAGE]
GO
ALTER TABLE [dbo].[USER_LANGUAGE]  WITH CHECK ADD  CONSTRAINT [FK_USER_LANGUAGE_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[USER_LANGUAGE] CHECK CONSTRAINT [FK_USER_LANGUAGE_USER]
GO
ALTER TABLE [dbo].[USER_ROLE]  WITH CHECK ADD  CONSTRAINT [FK_USER_ROLE_ORGANIZATION] FOREIGN KEY([organizationId])
REFERENCES [dbo].[ORGANIZATION] ([organizationId])
GO
ALTER TABLE [dbo].[USER_ROLE] CHECK CONSTRAINT [FK_USER_ROLE_ORGANIZATION]
GO
ALTER TABLE [dbo].[USER_ROLE]  WITH CHECK ADD  CONSTRAINT [FK_USER_ROLE_ROLE] FOREIGN KEY([roleId])
REFERENCES [dbo].[ROLE] ([roleId])
GO
ALTER TABLE [dbo].[USER_ROLE] CHECK CONSTRAINT [FK_USER_ROLE_ROLE]
GO
ALTER TABLE [dbo].[USER_ROLE]  WITH CHECK ADD  CONSTRAINT [FK_USER_ROLE_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[USER_ROLE] CHECK CONSTRAINT [FK_USER_ROLE_USER]
GO


USE [zakat]
GO


INSERT INTO LANGUAGE (name) VALUES ('Abkhaz');
INSERT INTO LANGUAGE (name) VALUES ('Afar');
INSERT INTO LANGUAGE (name) VALUES ('Afrikaans');
INSERT INTO LANGUAGE (name) VALUES ('Akan');
INSERT INTO LANGUAGE (name) VALUES ('Albanian');
INSERT INTO LANGUAGE (name) VALUES ('Amharic');
INSERT INTO LANGUAGE (name) VALUES ('Arabic');
INSERT INTO LANGUAGE (name) VALUES ('Aragonese');
INSERT INTO LANGUAGE (name) VALUES ('Armenian');
INSERT INTO LANGUAGE (name) VALUES ('Assamese');
INSERT INTO LANGUAGE (name) VALUES ('Avaric');
INSERT INTO LANGUAGE (name) VALUES ('Avestan');
INSERT INTO LANGUAGE (name) VALUES ('Aymara');
INSERT INTO LANGUAGE (name) VALUES ('Azerbaijani');
INSERT INTO LANGUAGE (name) VALUES ('Bambara');
INSERT INTO LANGUAGE (name) VALUES ('Bashkir');
INSERT INTO LANGUAGE (name) VALUES ('Basque');
INSERT INTO LANGUAGE (name) VALUES ('Belarusian');
INSERT INTO LANGUAGE (name) VALUES ('Bengali');
INSERT INTO LANGUAGE (name) VALUES ('Bihari');
INSERT INTO LANGUAGE (name) VALUES ('Bislama');
INSERT INTO LANGUAGE (name) VALUES ('Bosnian');
INSERT INTO LANGUAGE (name) VALUES ('Breton');
INSERT INTO LANGUAGE (name) VALUES ('Bulgarian');
INSERT INTO LANGUAGE (name) VALUES ('Burmese');
INSERT INTO LANGUAGE (name) VALUES ('Catalan');
INSERT INTO LANGUAGE (name) VALUES ('Chamorro');
INSERT INTO LANGUAGE (name) VALUES ('Chechen');
INSERT INTO LANGUAGE (name) VALUES ('Chichewa');
INSERT INTO LANGUAGE (name) VALUES ('Chinese');
INSERT INTO LANGUAGE (name) VALUES ('Chuvash');
INSERT INTO LANGUAGE (name) VALUES ('Cornish');
INSERT INTO LANGUAGE (name) VALUES ('Corsican');
INSERT INTO LANGUAGE (name) VALUES ('Cree');
INSERT INTO LANGUAGE (name) VALUES ('Croatian');
INSERT INTO LANGUAGE (name) VALUES ('Czech');
INSERT INTO LANGUAGE (name) VALUES ('Danish');
INSERT INTO LANGUAGE (name) VALUES ('Divehi');
INSERT INTO LANGUAGE (name) VALUES ('Dutch');
INSERT INTO LANGUAGE (name) VALUES ('English');
INSERT INTO LANGUAGE (name) VALUES ('Esperanto');
INSERT INTO LANGUAGE (name) VALUES ('Estonian');
INSERT INTO LANGUAGE (name) VALUES ('Ewe');
INSERT INTO LANGUAGE (name) VALUES ('Faroese');
INSERT INTO LANGUAGE (name) VALUES ('Fijian');
INSERT INTO LANGUAGE (name) VALUES ('Finnish');
INSERT INTO LANGUAGE (name) VALUES ('French');
INSERT INTO LANGUAGE (name) VALUES ('Fula');
INSERT INTO LANGUAGE (name) VALUES ('Galician');
INSERT INTO LANGUAGE (name) VALUES ('Georgian');
INSERT INTO LANGUAGE (name) VALUES ('German');
INSERT INTO LANGUAGE (name) VALUES ('Greek');
INSERT INTO LANGUAGE (name) VALUES ('Guaran');
INSERT INTO LANGUAGE (name) VALUES ('Gujarati');
INSERT INTO LANGUAGE (name) VALUES ('Haitian');
INSERT INTO LANGUAGE (name) VALUES ('Hausa');
INSERT INTO LANGUAGE (name) VALUES ('Hebrew');
INSERT INTO LANGUAGE (name) VALUES ('Herero');
INSERT INTO LANGUAGE (name) VALUES ('Hindi');
INSERT INTO LANGUAGE (name) VALUES ('Hiri Motu');
INSERT INTO LANGUAGE (name) VALUES ('Hungarian');
INSERT INTO LANGUAGE (name) VALUES ('Interlingua');
INSERT INTO LANGUAGE (name) VALUES ('Indonesian');
INSERT INTO LANGUAGE (name) VALUES ('Interlingue');
INSERT INTO LANGUAGE (name) VALUES ('Irish');
INSERT INTO LANGUAGE (name) VALUES ('Igbo');
INSERT INTO LANGUAGE (name) VALUES ('Inupiaq');
INSERT INTO LANGUAGE (name) VALUES ('Ido');
INSERT INTO LANGUAGE (name) VALUES ('Icelandic');
INSERT INTO LANGUAGE (name) VALUES ('Italian');
INSERT INTO LANGUAGE (name) VALUES ('Inuktitut');
INSERT INTO LANGUAGE (name) VALUES ('Japanese');
INSERT INTO LANGUAGE (name) VALUES ('Javanese');
INSERT INTO LANGUAGE (name) VALUES ('Kalaallisut');
INSERT INTO LANGUAGE (name) VALUES ('Kannada');
INSERT INTO LANGUAGE (name) VALUES ('Kanuri');
INSERT INTO LANGUAGE (name) VALUES ('Kashmiri');
INSERT INTO LANGUAGE (name) VALUES ('Kazakh');
INSERT INTO LANGUAGE (name) VALUES ('Khmer');
INSERT INTO LANGUAGE (name) VALUES ('Kikuyu');
INSERT INTO LANGUAGE (name) VALUES ('Kinyarwanda');
INSERT INTO LANGUAGE (name) VALUES ('Kirghiz');
INSERT INTO LANGUAGE (name) VALUES ('Komi');
INSERT INTO LANGUAGE (name) VALUES ('Kongo');
INSERT INTO LANGUAGE (name) VALUES ('Korean');
INSERT INTO LANGUAGE (name) VALUES ('Kurdish');
INSERT INTO LANGUAGE (name) VALUES ('Kwanyama');
INSERT INTO LANGUAGE (name) VALUES ('Latin');
INSERT INTO LANGUAGE (name) VALUES ('Luxembourgish');
INSERT INTO LANGUAGE (name) VALUES ('Luganda');
INSERT INTO LANGUAGE (name) VALUES ('Limburgish');
INSERT INTO LANGUAGE (name) VALUES ('Lingala');
INSERT INTO LANGUAGE (name) VALUES ('Lao');
INSERT INTO LANGUAGE (name) VALUES ('Lithuanian');
INSERT INTO LANGUAGE (name) VALUES ('Luba-Katanga');
INSERT INTO LANGUAGE (name) VALUES ('Latvian');
INSERT INTO LANGUAGE (name) VALUES ('Manx');
INSERT INTO LANGUAGE (name) VALUES ('Macedonian');
INSERT INTO LANGUAGE (name) VALUES ('Malagasy');
INSERT INTO LANGUAGE (name) VALUES ('Malay');
INSERT INTO LANGUAGE (name) VALUES ('Malayalam');
INSERT INTO LANGUAGE (name) VALUES ('Maltese');
INSERT INTO LANGUAGE (name) VALUES ('MÄori');
INSERT INTO LANGUAGE (name) VALUES ('Marathi');
INSERT INTO LANGUAGE (name) VALUES ('Marshallese');
INSERT INTO LANGUAGE (name) VALUES ('Mongolian');
INSERT INTO LANGUAGE (name) VALUES ('Nauru');
INSERT INTO LANGUAGE (name) VALUES ('Navajo');
INSERT INTO LANGUAGE (name) VALUES ('Norwegian');
INSERT INTO LANGUAGE (name) VALUES ('North Ndebele');
INSERT INTO LANGUAGE (name) VALUES ('Nepali');
INSERT INTO LANGUAGE (name) VALUES ('Ndonga');
INSERT INTO LANGUAGE (name) VALUES ('Norwegian Nynorsk');
INSERT INTO LANGUAGE (name) VALUES ('Norwegian');
INSERT INTO LANGUAGE (name) VALUES ('Nuosu');
INSERT INTO LANGUAGE (name) VALUES ('South Ndebele');
INSERT INTO LANGUAGE (name) VALUES ('Occitan');
INSERT INTO LANGUAGE (name) VALUES ('Ojibwe');
INSERT INTO LANGUAGE (name) VALUES ('Slavonic');
INSERT INTO LANGUAGE (name) VALUES ('Oromo');
INSERT INTO LANGUAGE (name) VALUES ('Oriya');
INSERT INTO LANGUAGE (name) VALUES ('Ossetian');
INSERT INTO LANGUAGE (name) VALUES ('Panjabi');
INSERT INTO LANGUAGE (name) VALUES ('Pali');
INSERT INTO LANGUAGE (name) VALUES ('Persian');
INSERT INTO LANGUAGE (name) VALUES ('Polish');
INSERT INTO LANGUAGE (name) VALUES ('Pashto');
INSERT INTO LANGUAGE (name) VALUES ('Portuguese');
INSERT INTO LANGUAGE (name) VALUES ('Quechua');
INSERT INTO LANGUAGE (name) VALUES ('Romansh');
INSERT INTO LANGUAGE (name) VALUES ('Kirundi');
INSERT INTO LANGUAGE (name) VALUES ('Romanian');
INSERT INTO LANGUAGE (name) VALUES ('Russian');
INSERT INTO LANGUAGE (name) VALUES ('Sanskrit');
INSERT INTO LANGUAGE (name) VALUES ('Sardinian');
INSERT INTO LANGUAGE (name) VALUES ('Sindhi');
INSERT INTO LANGUAGE (name) VALUES ('Northern Sami');
INSERT INTO LANGUAGE (name) VALUES ('Samoan');
INSERT INTO LANGUAGE (name) VALUES ('Sango');
INSERT INTO LANGUAGE (name) VALUES ('Serbian');
INSERT INTO LANGUAGE (name) VALUES ('Scottish');
INSERT INTO LANGUAGE (name) VALUES ('Shona');
INSERT INTO LANGUAGE (name) VALUES ('Sign Language');
INSERT INTO LANGUAGE (name) VALUES ('Sinhala');
INSERT INTO LANGUAGE (name) VALUES ('Slovak');
INSERT INTO LANGUAGE (name) VALUES ('Slovene');
INSERT INTO LANGUAGE (name) VALUES ('Somali');
INSERT INTO LANGUAGE (name) VALUES ('Southern Sotho');
INSERT INTO LANGUAGE (name) VALUES ('Spanish');
INSERT INTO LANGUAGE (name) VALUES ('Sundanese');
INSERT INTO LANGUAGE (name) VALUES ('Swahili');
INSERT INTO LANGUAGE (name) VALUES ('Swati');
INSERT INTO LANGUAGE (name) VALUES ('Swedish');
INSERT INTO LANGUAGE (name) VALUES ('Tamil');
INSERT INTO LANGUAGE (name) VALUES ('Telugu');
INSERT INTO LANGUAGE (name) VALUES ('Tajik');
INSERT INTO LANGUAGE (name) VALUES ('Thai');
INSERT INTO LANGUAGE (name) VALUES ('Tigrinya');
INSERT INTO LANGUAGE (name) VALUES ('Tibetan');
INSERT INTO LANGUAGE (name) VALUES ('Turkmen');
INSERT INTO LANGUAGE (name) VALUES ('Tagalog');
INSERT INTO LANGUAGE (name) VALUES ('Tswana');
INSERT INTO LANGUAGE (name) VALUES ('Tonga');
INSERT INTO LANGUAGE (name) VALUES ('Turkish');
INSERT INTO LANGUAGE (name) VALUES ('Tsonga');
INSERT INTO LANGUAGE (name) VALUES ('Tatar');
INSERT INTO LANGUAGE (name) VALUES ('Twi');
INSERT INTO LANGUAGE (name) VALUES ('Tahitian');
INSERT INTO LANGUAGE (name) VALUES ('Uighur');
INSERT INTO LANGUAGE (name) VALUES ('Ukrainian');
INSERT INTO LANGUAGE (name) VALUES ('Urdu');
INSERT INTO LANGUAGE (name) VALUES ('Uzbek');
INSERT INTO LANGUAGE (name) VALUES ('Venda');
INSERT INTO LANGUAGE (name) VALUES ('Vietnamese');
INSERT INTO LANGUAGE (name) VALUES ('Volapük');
INSERT INTO LANGUAGE (name) VALUES ('Walloon');
INSERT INTO LANGUAGE (name) VALUES ('Welsh');
INSERT INTO LANGUAGE (name) VALUES ('Wolof');
INSERT INTO LANGUAGE (name) VALUES ('Western Frisian');
INSERT INTO LANGUAGE (name) VALUES ('Xhosa');
INSERT INTO LANGUAGE (name) VALUES ('Yiddish');
INSERT INTO LANGUAGE (name) VALUES ('Yoruba');
INSERT INTO LANGUAGE (name) VALUES ('Zhuang');

INSERT INTO NATIONALITY (name) VALUES ('(Select One)');
INSERT INTO NATIONALITY (name) VALUES ('Afghan');
INSERT INTO NATIONALITY (name) VALUES ('Albanian');
INSERT INTO NATIONALITY (name) VALUES ('Algerian');
INSERT INTO NATIONALITY (name) VALUES ('American');
INSERT INTO NATIONALITY (name) VALUES ('Andorran');
INSERT INTO NATIONALITY (name) VALUES ('Angolan');
INSERT INTO NATIONALITY (name) VALUES ('Antiguans');
INSERT INTO NATIONALITY (name) VALUES ('Argentinean');
INSERT INTO NATIONALITY (name) VALUES ('Armenian');
INSERT INTO NATIONALITY (name) VALUES ('Australian');
INSERT INTO NATIONALITY (name) VALUES ('Austrian');
INSERT INTO NATIONALITY (name) VALUES ('Azerbaijani');
INSERT INTO NATIONALITY (name) VALUES ('Bahamian');
INSERT INTO NATIONALITY (name) VALUES ('Bahraini');
INSERT INTO NATIONALITY (name) VALUES ('Bangladeshi');
INSERT INTO NATIONALITY (name) VALUES ('Barbadian');
INSERT INTO NATIONALITY (name) VALUES ('Barbudans');
INSERT INTO NATIONALITY (name) VALUES ('Batswana');
INSERT INTO NATIONALITY (name) VALUES ('Belarusian');
INSERT INTO NATIONALITY (name) VALUES ('Belgian');
INSERT INTO NATIONALITY (name) VALUES ('Belizean');
INSERT INTO NATIONALITY (name) VALUES ('Beninese');
INSERT INTO NATIONALITY (name) VALUES ('Bhutanese');
INSERT INTO NATIONALITY (name) VALUES ('Bolivian');
INSERT INTO NATIONALITY (name) VALUES ('Bosnian');
INSERT INTO NATIONALITY (name) VALUES ('Brazilian');
INSERT INTO NATIONALITY (name) VALUES ('British');
INSERT INTO NATIONALITY (name) VALUES ('Bruneian');
INSERT INTO NATIONALITY (name) VALUES ('Bulgarian');
INSERT INTO NATIONALITY (name) VALUES ('Burkinabe');
INSERT INTO NATIONALITY (name) VALUES ('Burmese');
INSERT INTO NATIONALITY (name) VALUES ('Burundian');
INSERT INTO NATIONALITY (name) VALUES ('Cambodian');
INSERT INTO NATIONALITY (name) VALUES ('Cameroonian');
INSERT INTO NATIONALITY (name) VALUES ('Canadian');
INSERT INTO NATIONALITY (name) VALUES ('Cape Verdean');
INSERT INTO NATIONALITY (name) VALUES ('Central African');
INSERT INTO NATIONALITY (name) VALUES ('Chadian');
INSERT INTO NATIONALITY (name) VALUES ('Chilean');
INSERT INTO NATIONALITY (name) VALUES ('Chinese');
INSERT INTO NATIONALITY (name) VALUES ('Colombian');
INSERT INTO NATIONALITY (name) VALUES ('Comoran');
INSERT INTO NATIONALITY (name) VALUES ('Congolese');
INSERT INTO NATIONALITY (name) VALUES ('Costa Rican');
INSERT INTO NATIONALITY (name) VALUES ('Croatian');
INSERT INTO NATIONALITY (name) VALUES ('Cuban');
INSERT INTO NATIONALITY (name) VALUES ('Cypriot');
INSERT INTO NATIONALITY (name) VALUES ('Czech');
INSERT INTO NATIONALITY (name) VALUES ('Danish');
INSERT INTO NATIONALITY (name) VALUES ('Djibouti');
INSERT INTO NATIONALITY (name) VALUES ('Dominican');
INSERT INTO NATIONALITY (name) VALUES ('Dutch');
INSERT INTO NATIONALITY (name) VALUES ('East Timorese');
INSERT INTO NATIONALITY (name) VALUES ('Ecuadorean');
INSERT INTO NATIONALITY (name) VALUES ('Egyptian');
INSERT INTO NATIONALITY (name) VALUES ('Emirian');
INSERT INTO NATIONALITY (name) VALUES ('Equatorial Guinean');
INSERT INTO NATIONALITY (name) VALUES ('Eritrean');
INSERT INTO NATIONALITY (name) VALUES ('Estonian');
INSERT INTO NATIONALITY (name) VALUES ('Ethiopian');
INSERT INTO NATIONALITY (name) VALUES ('Fijian');
INSERT INTO NATIONALITY (name) VALUES ('Filipino');
INSERT INTO NATIONALITY (name) VALUES ('Finnish');
INSERT INTO NATIONALITY (name) VALUES ('French');
INSERT INTO NATIONALITY (name) VALUES ('Gabonese');
INSERT INTO NATIONALITY (name) VALUES ('Gambian');
INSERT INTO NATIONALITY (name) VALUES ('Georgian');
INSERT INTO NATIONALITY (name) VALUES ('German');
INSERT INTO NATIONALITY (name) VALUES ('Ghanaian');
INSERT INTO NATIONALITY (name) VALUES ('Greek');
INSERT INTO NATIONALITY (name) VALUES ('Grenadian');
INSERT INTO NATIONALITY (name) VALUES ('Guatemalan');
INSERT INTO NATIONALITY (name) VALUES ('Guinea-Bissauan');
INSERT INTO NATIONALITY (name) VALUES ('Guinean');
INSERT INTO NATIONALITY (name) VALUES ('Guyanese');
INSERT INTO NATIONALITY (name) VALUES ('Haitian');
INSERT INTO NATIONALITY (name) VALUES ('Herzegovinian');
INSERT INTO NATIONALITY (name) VALUES ('Honduran');
INSERT INTO NATIONALITY (name) VALUES ('Hungarian');
INSERT INTO NATIONALITY (name) VALUES ('I-Kiribati');
INSERT INTO NATIONALITY (name) VALUES ('Icelander');
INSERT INTO NATIONALITY (name) VALUES ('Indian');
INSERT INTO NATIONALITY (name) VALUES ('Indonesian');
INSERT INTO NATIONALITY (name) VALUES ('Iranian');
INSERT INTO NATIONALITY (name) VALUES ('Iraqi');
INSERT INTO NATIONALITY (name) VALUES ('Irish');
INSERT INTO NATIONALITY (name) VALUES ('Israeli');
INSERT INTO NATIONALITY (name) VALUES ('Italian');
INSERT INTO NATIONALITY (name) VALUES ('Ivorian');
INSERT INTO NATIONALITY (name) VALUES ('Jamaican');
INSERT INTO NATIONALITY (name) VALUES ('Japanese');
INSERT INTO NATIONALITY (name) VALUES ('Jordanian');
INSERT INTO NATIONALITY (name) VALUES ('Kazakhstani');
INSERT INTO NATIONALITY (name) VALUES ('Kenyan');
INSERT INTO NATIONALITY (name) VALUES ('Kittian and Nevisian');
INSERT INTO NATIONALITY (name) VALUES ('Kuwaiti');
INSERT INTO NATIONALITY (name) VALUES ('Kyrgyz');
INSERT INTO NATIONALITY (name) VALUES ('Laotian');
INSERT INTO NATIONALITY (name) VALUES ('Latvian');
INSERT INTO NATIONALITY (name) VALUES ('Lebanese');
INSERT INTO NATIONALITY (name) VALUES ('Liberian');
INSERT INTO NATIONALITY (name) VALUES ('Libyan');
INSERT INTO NATIONALITY (name) VALUES ('Liechtensteiner');
INSERT INTO NATIONALITY (name) VALUES ('Lithuanian');
INSERT INTO NATIONALITY (name) VALUES ('Luxembourger');
INSERT INTO NATIONALITY (name) VALUES ('Macedonian');
INSERT INTO NATIONALITY (name) VALUES ('Malagasy');
INSERT INTO NATIONALITY (name) VALUES ('Malawian');
INSERT INTO NATIONALITY (name) VALUES ('Malaysian');
INSERT INTO NATIONALITY (name) VALUES ('Maldivian');
INSERT INTO NATIONALITY (name) VALUES ('Malian');
INSERT INTO NATIONALITY (name) VALUES ('Maltese');
INSERT INTO NATIONALITY (name) VALUES ('Marshallese');
INSERT INTO NATIONALITY (name) VALUES ('Mauritanian');
INSERT INTO NATIONALITY (name) VALUES ('Mauritian');
INSERT INTO NATIONALITY (name) VALUES ('Mexican');
INSERT INTO NATIONALITY (name) VALUES ('Micronesian');
INSERT INTO NATIONALITY (name) VALUES ('Moldovan');
INSERT INTO NATIONALITY (name) VALUES ('Monacan');
INSERT INTO NATIONALITY (name) VALUES ('Mongolian');
INSERT INTO NATIONALITY (name) VALUES ('Moroccan');
INSERT INTO NATIONALITY (name) VALUES ('Mosotho');
INSERT INTO NATIONALITY (name) VALUES ('Motswana');
INSERT INTO NATIONALITY (name) VALUES ('Mozambican');
INSERT INTO NATIONALITY (name) VALUES ('Namibian');
INSERT INTO NATIONALITY (name) VALUES ('Nauruan');
INSERT INTO NATIONALITY (name) VALUES ('Nepalese');
INSERT INTO NATIONALITY (name) VALUES ('New Zealander');
INSERT INTO NATIONALITY (name) VALUES ('Ni-Vanuatu');
INSERT INTO NATIONALITY (name) VALUES ('Nicaraguan');
INSERT INTO NATIONALITY (name) VALUES ('Nigerian');
INSERT INTO NATIONALITY (name) VALUES ('Nigerien');
INSERT INTO NATIONALITY (name) VALUES ('North Korean');
INSERT INTO NATIONALITY (name) VALUES ('Northern Irish');
INSERT INTO NATIONALITY (name) VALUES ('Norwegian');
INSERT INTO NATIONALITY (name) VALUES ('Omani');
INSERT INTO NATIONALITY (name) VALUES ('Pakistani');
INSERT INTO NATIONALITY (name) VALUES ('Palauan');
INSERT INTO NATIONALITY (name) VALUES ('Panamanian');
INSERT INTO NATIONALITY (name) VALUES ('Papua New Guinean');
INSERT INTO NATIONALITY (name) VALUES ('Paraguayan');
INSERT INTO NATIONALITY (name) VALUES ('Peruvian');
INSERT INTO NATIONALITY (name) VALUES ('Polish');
INSERT INTO NATIONALITY (name) VALUES ('Portuguese');
INSERT INTO NATIONALITY (name) VALUES ('Qatari');
INSERT INTO NATIONALITY (name) VALUES ('Romanian');
INSERT INTO NATIONALITY (name) VALUES ('Russian');
INSERT INTO NATIONALITY (name) VALUES ('Rwandan');
INSERT INTO NATIONALITY (name) VALUES ('Saint Lucian');
INSERT INTO NATIONALITY (name) VALUES ('Salvadoran');
INSERT INTO NATIONALITY (name) VALUES ('Samoan');
INSERT INTO NATIONALITY (name) VALUES ('San Marinese');
INSERT INTO NATIONALITY (name) VALUES ('Sao Tomean');
INSERT INTO NATIONALITY (name) VALUES ('Saudi');
INSERT INTO NATIONALITY (name) VALUES ('Scottish');
INSERT INTO NATIONALITY (name) VALUES ('Senegalese');
INSERT INTO NATIONALITY (name) VALUES ('Serbian');
INSERT INTO NATIONALITY (name) VALUES ('Seychellois');
INSERT INTO NATIONALITY (name) VALUES ('Sierra Leonean');
INSERT INTO NATIONALITY (name) VALUES ('Singaporean');
INSERT INTO NATIONALITY (name) VALUES ('Slovakian');
INSERT INTO NATIONALITY (name) VALUES ('Slovenian');
INSERT INTO NATIONALITY (name) VALUES ('Solomon Islander');
INSERT INTO NATIONALITY (name) VALUES ('Somali');
INSERT INTO NATIONALITY (name) VALUES ('South African');
INSERT INTO NATIONALITY (name) VALUES ('South Korean');
INSERT INTO NATIONALITY (name) VALUES ('Spanish');
INSERT INTO NATIONALITY (name) VALUES ('Sri Lankan');
INSERT INTO NATIONALITY (name) VALUES ('Sudanese');
INSERT INTO NATIONALITY (name) VALUES ('Surinamer');
INSERT INTO NATIONALITY (name) VALUES ('Swazi');
INSERT INTO NATIONALITY (name) VALUES ('Swedish');
INSERT INTO NATIONALITY (name) VALUES ('Swiss');
INSERT INTO NATIONALITY (name) VALUES ('Syrian');
INSERT INTO NATIONALITY (name) VALUES ('Taiwanese');
INSERT INTO NATIONALITY (name) VALUES ('Tajik');
INSERT INTO NATIONALITY (name) VALUES ('Tanzanian');
INSERT INTO NATIONALITY (name) VALUES ('Thai');
INSERT INTO NATIONALITY (name) VALUES ('Togolese');
INSERT INTO NATIONALITY (name) VALUES ('Tongan');
INSERT INTO NATIONALITY (name) VALUES ('Trinidadian or Tobagonian');
INSERT INTO NATIONALITY (name) VALUES ('Tunisian');
INSERT INTO NATIONALITY (name) VALUES ('Turkish');
INSERT INTO NATIONALITY (name) VALUES ('Tuvaluan');
INSERT INTO NATIONALITY (name) VALUES ('Ugandan');
INSERT INTO NATIONALITY (name) VALUES ('Ukrainian');
INSERT INTO NATIONALITY (name) VALUES ('Uruguayan');
INSERT INTO NATIONALITY (name) VALUES ('Uzbekistani');
INSERT INTO NATIONALITY (name) VALUES ('Venezuelan');
INSERT INTO NATIONALITY (name) VALUES ('Vietnamese');
INSERT INTO NATIONALITY (name) VALUES ('Welsh');
INSERT INTO NATIONALITY (name) VALUES ('Yemenite');
INSERT INTO NATIONALITY (name) VALUES ('Zambian');
INSERT INTO NATIONALITY (name) VALUES ('Zimbabwean');

INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	1	,	'Applicant'	,	'This role provides a user the ability to save profile data, submit zakat application(s), and monitor zakat application status'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	2	,	'Validator'	,	'This role provides a user the ability to review a zakat application for completeness'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	3	,	'Investigator'	,	'This role provides a user the ability to review the zakat case to determine that a need exists'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	4	,	'Qualifier'	,	'This role provides a user the ability to determine zakat eligibility based on Islamic jurisprudence'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	5	,	'Administrator'	,	'This role provides a user the ability to administer various reference data related to the system'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	6	,	'Financier'	,	'This role provides a user the ability to be notified about an approved zakat application so that funds can be dispursed'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	7	,	'General'	,	'This role provides no privileges'	);

INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'(Select One)'	,	'(Select One)'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'AL'	,	'Alabama'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'AK'	,	'Alaska'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'AZ'	,	'Arizona'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'AR'	,	'Arkansas'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'CA'	,	'California'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'CO'	,	'Colorado'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'CT'	,	'Connecticut'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'DE'	,	'Delaware'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'FL'	,	'Florida'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'GA'	,	'Georgia'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'HI'	,	'Hawaii'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'ID'	,	'Idaho'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'IL'	,	'Illinois'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'IN'	,	'Indiana'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'IA'	,	'Iowa'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'KS'	,	'Kansas'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'KY'	,	'Kentucky'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'LA'	,	'Louisiana'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'ME'	,	'Maine'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'MD'	,	'Maryland'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'MA'	,	'Massachusetts'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'MI'	,	'Michigan'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'MN'	,	'Minnesota'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'MS'	,	'Mississippi'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'MO'	,	'Missouri'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'MT'	,	'Montana'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'NE'	,	'Nebraska'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'NV'	,	'Nevada'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'NH'	,	'New Hampshire'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'NJ'	,	'New Jersey'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'NM'	,	'New Mexico'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'NY'	,	'New York'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'NC'	,	'North Carolina'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'ND'	,	'North Dakota'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'OH'	,	'Ohio'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'OK'	,	'Oklahoma'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'OR'	,	'Oregon'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'PA'	,	'Pennsylvania'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'RI'	,	'Rhode Island'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'SC'	,	'South Carolina'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'SD'	,	'South Dakota'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'TN'	,	'Tennessee'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'TX'	,	'Texas'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'UT'	,	'Utah'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'VT'	,	'Vermont'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'VA'	,	'Virginia'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'WA'	,	'Washington'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'WV'	,	'West Virginia'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'WI'	,	'Wisconsin'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'WY'	,	'Wyoming'	);
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'DC'	,	'District of Columbia'	);

INSERT INTO [dbo].[USER] (email,	password,	firstName,	lastName) VALUES ('zakat@icclmd.org'	,	'12121212'	,	'ICCL Zakat', 'Administrator');
INSERT INTO [dbo].[USER] (email,	password,	firstName,	lastName) VALUES ('admin@icclmd.org'	,	'12121212'	,	'Administrator', 'Administrator');
INSERT INTO [dbo].[USER] (email,	password,	firstName,	lastName) VALUES ('applicant@icclmd.org'	,	'12121212'	,	'Applicant', 'Applicant');
INSERT INTO [dbo].[USER] (email,	password,	firstName,	lastName) VALUES ('validator@icclmd.org'	,	'12121212'	,	'Validator', 'Validator');
INSERT INTO [dbo].[USER] (email,	password,	firstName,	lastName) VALUES ('investigator@icclmd.org'	,	'12121212'	,	'Investigator', 'Investigator');
INSERT INTO [dbo].[USER] (email,	password,	firstName,	lastName) VALUES ('qualifier@icclmd.org'	,	'12121212'	,	'Qualifier', 'Qualifier');
INSERT INTO [dbo].[USER] (email,	password,	firstName,	lastName) VALUES ('financier@icclmd.org'	,	'12121212'	,	'Financier', 'Financier');

INSERT INTO [dbo].[ORGANIZATION] ([name]) VALUES ('Placeholder')
INSERT INTO [dbo].[ORGANIZATION] ([name],[street],[city],[stateAbbr],[zip],[email],[phone],[website]) VALUES ('Islamic Community Center of Laurel','7306 Contee Road','Laurel','MD','20707','office@icclmd.org','3013174584', 'https://www.icclmd.org')

INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (1, 1, 5);
