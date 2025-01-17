USE [zakat]
GO
ALTER TABLE [dbo].[USER_ROLE] DROP CONSTRAINT [FK_USER_ROLE_USER]
GO
ALTER TABLE [dbo].[USER_ROLE] DROP CONSTRAINT [FK_USER_ROLE_ROLE]
GO
ALTER TABLE [dbo].[USER_ROLE] DROP CONSTRAINT [FK_USER_ROLE_ORGANIZATION]
GO
ALTER TABLE [dbo].[USER_LANGUAGE] DROP CONSTRAINT [FK_USER_LANGUAGE_USER]
GO
ALTER TABLE [dbo].[USER_LANGUAGE] DROP CONSTRAINT [FK_USER_LANGUAGE_LANGUAGE]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [FK_USER_STATE]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [FK_USER_STATE1]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [FK_USER_NATIONALITY]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [FK_USER_COUNTRY]
GO
ALTER TABLE [dbo].[REVIEW] DROP CONSTRAINT [FK_COMMENT_USER]
GO
ALTER TABLE [dbo].[REVIEW] DROP CONSTRAINT [FK_COMMENT_APPLICATION]
GO
ALTER TABLE [dbo].[REFERENCE] DROP CONSTRAINT [FK_REFERENCE_USER]
GO
ALTER TABLE [dbo].[REFERENCE] DROP CONSTRAINT [FK_REFERENCE_STATE]
GO
ALTER TABLE [dbo].[ORGANIZATION] DROP CONSTRAINT [FK_ORGANIZATION_STATE]
GO
ALTER TABLE [dbo].[DEPENDENT] DROP CONSTRAINT [FK_DEPENDENT_USER]
GO
ALTER TABLE [dbo].[DONATION] DROP CONSTRAINT [FK_DONATION_ORGANIZATION]
GO
ALTER TABLE [dbo].[CERTIFICATION_SKILL] DROP CONSTRAINT [FK_CERTIFICATION_SKILL_USER]
GO
ALTER TABLE [dbo].[ARTIFACT] DROP CONSTRAINT [FK_ARTIFACT_ARTIFACT_TYPE]
GO
ALTER TABLE [dbo].[ARTIFACT] DROP CONSTRAINT [FK_ARTIFACT_APPLICATION]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [FK_APPLICATION_USER]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [FK_APPLICATION_STATE]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [FK_APPLICATION_ORGANIZATION]
GO
ALTER TABLE [dbo].[POST] DROP CONSTRAINT [FK_POST_POST_CATEGORY]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_updatedOn]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_createdOn]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_isInternationalSchool]
GO
ALTER TABLE [dbo].[REVIEW] DROP CONSTRAINT [DF_REVIEW_reviewDate]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_updatedOn]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_createdOn]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_createdOn1]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_isNotEmployed]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_IsDispersed]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_isQualified11]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_isQualified]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_isInvestigated]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_isValidated]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_isSubmitted]
GO
ALTER TABLE [dbo].[APPLICATION] DROP CONSTRAINT [DF_APPLICATION_isSaved]
GO
ALTER TABLE [dbo].[ORGANIZATION] DROP CONSTRAINT [DF_ORGANIZATION_isDonationAccepted]
GO
/****** Object:  Table [dbo].[TOPIC]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TOPIC]') AND type in (N'U'))
DROP TABLE [dbo].[TOPIC]
GO
/****** Object:  Table [dbo].[TRANSLATION]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TRANSLATION]') AND type in (N'U'))
DROP TABLE [dbo].[TRANSLATION]
GO
/****** Object:  Table [dbo].[USER_ROLE]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USER_ROLE]') AND type in (N'U'))
DROP TABLE [dbo].[USER_ROLE]
GO
/****** Object:  Table [dbo].[USER_LANGUAGE]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USER_LANGUAGE]') AND type in (N'U'))
DROP TABLE [dbo].[USER_LANGUAGE]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USER]') AND type in (N'U'))
DROP TABLE [dbo].[USER]
GO
/****** Object:  Table [dbo].[STATE]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SURVEY]') AND type in (N'U'))
DROP TABLE [dbo].[STATE]
GO
/****** Object:  Table [dbo].[SURVEY]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STATE]') AND type in (N'U'))
DROP TABLE [dbo].[SURVEY]
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ROLE]') AND type in (N'U'))
DROP TABLE [dbo].[ROLE]
GO
/****** Object:  Table [dbo].[REVIEW]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REVIEW]') AND type in (N'U'))
DROP TABLE [dbo].[REVIEW]
GO
/****** Object:  Table [dbo].[REFERENCE]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REFERENCE]') AND type in (N'U'))
DROP TABLE [dbo].[REFERENCE]
GO
/****** Object:  Table [dbo].[ORGANIZATION]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ORGANIZATION]') AND type in (N'U'))
DROP TABLE [dbo].[ORGANIZATION]
GO
/****** Object:  Table [dbo].[DONATION]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DONATION]') AND type in (N'U'))
DROP TABLE [dbo].[DONATION]
GO
/****** Object:  Table [dbo].[POST]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POST]') AND type in (N'U'))
DROP TABLE [dbo].[POST]
GO
/****** Object:  Table [dbo].[POST_CATEGORY]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POST_CATEGORY]') AND type in (N'U'))
DROP TABLE [dbo].[POST_CATEGORY]
GO
/****** Object:  Table [dbo].[NATIONALITY]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NATIONALITY]') AND type in (N'U'))
DROP TABLE [dbo].[NATIONALITY]
GO
/****** Object:  Table [dbo].[LANGUAGE]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LANGUAGE]') AND type in (N'U'))
DROP TABLE [dbo].[LANGUAGE]
GO
/****** Object:  Table [dbo].[DEPENDENT]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DEPENDENT]') AND type in (N'U'))
DROP TABLE [dbo].[DEPENDENT]
GO
/****** Object:  Table [dbo].[COUNTRY]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[COUNTRY]') AND type in (N'U'))
DROP TABLE [dbo].[COUNTRY]
GO
/****** Object:  Table [dbo].[CERTIFICATION_SKILL]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CERTIFICATION_SKILL]') AND type in (N'U'))
DROP TABLE [dbo].[CERTIFICATION_SKILL]
GO
/****** Object:  Table [dbo].[ARTIFACT_TYPE]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ARTIFACT_TYPE]') AND type in (N'U'))
DROP TABLE [dbo].[ARTIFACT_TYPE]
GO
/****** Object:  Table [dbo].[ARTIFACT]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ARTIFACT]') AND type in (N'U'))
DROP TABLE [dbo].[ARTIFACT]
GO
/****** Object:  Table [dbo].[APPLICATION]    Script Date: 12/18/2022 10:46:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APPLICATION]') AND type in (N'U'))
DROP TABLE [dbo].[APPLICATION]
GO
/****** Object:  Table [dbo].[APPLICATION]    Script Date: 12/18/2022 10:46:03 AM ******/
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
	[husbandHasAppliedForZakat] [varchar](10) NULL,
	[husbandZakatExplanation] [varchar](1000) NULL,
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
	[isNotEmployed] [bit] NULL,
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
	[draftedOn] [datetime] NULL,
	[draftedBy] [int] NULL,
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
	[dispersedAmount] [money] NULL,
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARTIFACT]    Script Date: 12/18/2022 10:46:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTIFACT](
	[artifactId] [int] IDENTITY(1,1) NOT NULL,
	[artifactTypeId] [int] NULL,
	[applicationId] [int] NULL,
	[filename] [varchar](50) NULL,
	[contentType] [varchar](400) NULL,
	[data] [varbinary](max) NULL,
 CONSTRAINT [PK_ARTIFACT] PRIMARY KEY CLUSTERED 
(
	[artifactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARTIFACT_TYPE]    Script Date: 12/18/2022 10:46:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTIFACT_TYPE](
	[artifactTypeId] [int] NOT NULL,
	[name] [varchar](35) NULL,
 CONSTRAINT [PK_ARTIFACT_TYPE] PRIMARY KEY CLUSTERED 
(
	[artifactTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CERTIFICATION_SKILL]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COUNTRY]    Script Date: 12/18/2022 10:46:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COUNTRY](
	[countryId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_COUNTRY] PRIMARY KEY CLUSTERED 
(
	[countryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEPENDENT]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LANGUAGE]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NATIONALITY]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORGANIZATION]    Script Date: 12/18/2022 10:46:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORGANIZATION](
	[organizationId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[abbreviation] [varchar](10) NULL,
	[street] [varchar](100) NULL,
	[city] [varchar](50) NULL,
	[stateAbbr] [varchar](15) NULL,
	[zip] [varchar](5) NULL,
	[email] [varchar](60) NULL,
	[phone] [varchar](10) NULL,
	[website] [varchar](250) NULL,
	[missionStatement] varchar(4000) NULL,
	[isDonationAccepted] [bit] NULL,
	[payPalImageURL] [varchar](250) NULL,
	[payPalIdentityToken] [varchar](100) NULL
	
 CONSTRAINT [PK_ORGANIZATION] PRIMARY KEY CLUSTERED 
(
	[organizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DONATION]    Script Date: 12/18/2022 10:46:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DONATION](
	[donationId] [int] IDENTITY(1,1) NOT NULL,
	[organizationId] [int] NULL,
	[firstName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[amount] [money] NULL,
	[donationDate] [datetime] NULL,
	[isConfirmed] [bit] NOT NULL,
	[paypalPdtIsSuccessful] [bit] NULL,
	[paypalPdtConfirmDate] [datetime] NULL,
	[paypalPdtTransactionId] [varchar](50) NULL,
	[paypalPdtResponse] [varchar](4000) NULL,
	[paypalIpnIsSuccessful] [bit] NULL,
	[paypalIpnConfirmDate] [datetime] NULL,
	[paypalIpnTransactionId] [varchar](50) NULL,
	[paypalIpnResponse] [varchar](4000) NULL
 CONSTRAINT [PK_DONATION] PRIMARY KEY CLUSTERED 
(
	[donationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[POST_CATEGORY]    Script Date: 12/18/2022 10:46:03 AM ******/
CREATE TABLE [dbo].[POST_CATEGORY](
	[postCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](500) NULL,
	[countOfPosts] [int] DEFAULT 0 NOT NULL
 CONSTRAINT [PK_POST_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[postCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[POST]    Script Date: 12/18/2022 10:46:03 AM ******/
CREATE TABLE [dbo].[POST](
	[postId] [int] IDENTITY(1,1) NOT NULL,
	[postParentId] [int] NULL,
	[postCategoryId] [int] NOT NULL,
	[postTitle] [varchar](50) NOT NULL,
	[postContent] [varchar](750) NOT NULL,
	[countOfReplies] [int] DEFAULT 0 NOT NULL,
	[postCreatedOn] [datetime] NOT NULL,
	[postUpdatedOn] [datetime] NULL,
	[postCreatedBy] [int] NULL,
 CONSTRAINT [PK_POST] PRIMARY KEY CLUSTERED 
(
	[postId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[REFERENCE]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REVIEW]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STATE]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[SURVEY]    Script Date: 12/18/2022 10:46:03 AM ******/
CREATE TABLE [dbo].[SURVEY](
	[surveyId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[email] [varchar](60) NULL,
	[phone] [varchar](10) NULL,
	[isFollowUp] [bit] NULL,
	[question1Stars] [int] NULL,
	[question2Stars] [int] NULL,
	[question3Stars] [int] NULL,
	[question4Option1] [bit] NULL,
	[question4Option2] [bit] NULL,
	[question4Option3] [bit] NULL,
	[question4Option4] [bit] NULL,
	[question4Option5] [bit] NULL,
	[question4Option6] [bit] NULL,
	[question4Option6Value] [varchar](50) NULL,
	[question5Option1] [bit] NULL,
	[question5Option2] [bit] NULL,
	[question5Option3] [bit] NULL,
	[question5Option4] [bit] NULL,
	[question5Option5] [bit] NULL,
	[question5Option6] [bit] NULL,
	[question5Option6Value] [varchar](50) NULL,
	[question6] [varchar](1000) NULL,
	[question7] [varchar](1000) NULL,
	[createdOn] [datetime] NULL,
 CONSTRAINT [PK_SURVEY] PRIMARY KEY CLUSTERED 
(
	[surveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

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
/****** Object:  Table [dbo].[TRANSLATION]    Script Date: 9/27/2023 6:13:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TRANSLATION](
	[translationId] [int] NOT NULL,
	[translationNameEnglish] [varchar](250) NULL,
	[translationNameNative] [varchar](250) NULL,
	[translationURL] [varchar](250) NULL,
 CONSTRAINT [PK_TRANSLATION] PRIMARY KEY CLUSTERED 
(
	[translationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 12/18/2022 10:46:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](60) NOT NULL,
	[passwordEncrypted] [varchar](max) NULL,
	[socialSecurityNumberEncrypted] [varchar](max) NULL,
	[firstName] [varchar](30) NOT NULL,
	[middleName] [varchar](30) NULL,
	[lastName] [varchar](30) NOT NULL,
	[gender] [varchar](10) NULL,
	[maritalStatus] [varchar](15) NULL,
	[dob] [datetime] NULL,
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
	[highestEducationCompleted] [varchar](50) NULL,
	[isInternationalSchool] [bit] NULL,
	[schoolName] [varchar](100) NULL,
	[schoolCountryId] [int] NULL,
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER_LANGUAGE]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER_ROLE]    Script Date: 12/18/2022 10:46:03 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Create views for Dashboard:
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_APPLICATIONS_AVG_PROCESSING_DAYS] AS
SELECT 
    a.applicationId,
    YEAR(a.submittedOn) AS year,
    MONTH(a.submittedOn) AS month, 
    a.submittedOn, 
    a.qualified2On
FROM [APPLICATION] a
WHERE a.submittedOn IS NOT NULL
AND a.qualified2On IS NOT NULL
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_APPLICATIONS_BY_USER_AGE] AS
SELECT a.applicationId, a.userId, a.isSubmitted, a.isDispersed, a.isRejected, DATEDIFF(hour,u.dob,GETDATE())/8766 AS Age
FROM [APPLICATION] a, [USER] u
WHERE a.userId = u.userId
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_APPLICATIONS_DISPERSED_BY_YEAR] AS
SELECT YEAR(dispersedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isDispersed = 1
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_APPLICATIONS_DRAFTED_BY_YEAR] AS
SELECT YEAR(draftedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isDrafted = 1
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_APPLICATIONS_INVESTIGATED_BY_YEAR] AS
SELECT YEAR(investigatedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isInvestigated = 1
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_APPLICATIONS_QUALIFIED_BY_YEAR] AS
SELECT YEAR(qualified2On) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isQualified2 = 1
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_APPLICATIONS_TOTAL_DISPERSED] AS
SELECT 
    a.applicationId,
    YEAR(a.dispersedOn) AS year,
    MONTH(a.dispersedOn) AS month, 
    a.dispersedAmount
FROM [APPLICATION] a
WHERE a.dispersedAmount IS NOT NULL
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_APPLICATIONS_REJECTED_BY_YEAR] AS
SELECT YEAR(rejectedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isRejected = 1
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_APPLICATIONS_SUBMITTED_BY_YEAR] AS
SELECT YEAR(submittedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isSubmitted = 1
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_APPLICATIONS_VALIDATED_BY_YEAR] AS
SELECT YEAR(validatedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isValidated = 1
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
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_isNotEmployed]  DEFAULT ((0)) FOR [isNotEmployed]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_createdOn1]  DEFAULT (getdate()) FOR [submittedOn]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_createdOn]  DEFAULT (getdate()) FOR [createdOn]
GO
ALTER TABLE [dbo].[APPLICATION] ADD  CONSTRAINT [DF_APPLICATION_updatedOn]  DEFAULT (getdate()) FOR [updatedOn]
GO
ALTER TABLE [dbo].[ORGANIZATION] ADD  CONSTRAINT [DF_ORGANIZATION_isDonationAccepted]  DEFAULT ((0)) FOR [isDonationAccepted]
GO
ALTER TABLE [dbo].[REVIEW] ADD  CONSTRAINT [DF_REVIEW_reviewDate]  DEFAULT (getdate()) FOR [reviewDate]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_isInternationalSchool]  DEFAULT ((0)) FOR [isInternationalSchool]
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
ALTER TABLE [dbo].[ARTIFACT]  WITH CHECK ADD  CONSTRAINT [FK_ARTIFACT_ARTIFACT_TYPE] FOREIGN KEY([artifactTypeId])
REFERENCES [dbo].[ARTIFACT_TYPE] ([artifactTypeId])
GO
ALTER TABLE [dbo].[ARTIFACT] CHECK CONSTRAINT [FK_ARTIFACT_ARTIFACT_TYPE]
GO
ALTER TABLE [dbo].[CERTIFICATION_SKILL]  WITH CHECK ADD  CONSTRAINT [FK_CERTIFICATION_SKILL_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[CERTIFICATION_SKILL] CHECK CONSTRAINT [FK_CERTIFICATION_SKILL_USER]
GO
ALTER TABLE [dbo].[DEPENDENT]  WITH CHECK ADD  CONSTRAINT [FK_DEPENDENT_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[DEPENDENT] CHECK CONSTRAINT [FK_DEPENDENT_USER]
GO
ALTER TABLE [dbo].[DONATION]  WITH CHECK ADD  CONSTRAINT [FK_DONATION_ORGANIZATION] FOREIGN KEY([organizationId])
REFERENCES [dbo].[ORGANIZATION] ([organizationId])
GO
ALTER TABLE [dbo].[DONATION] CHECK CONSTRAINT [FK_DONATION_ORGANIZATION]

ALTER TABLE [dbo].[ORGANIZATION]  WITH CHECK ADD  CONSTRAINT [FK_ORGANIZATION_STATE] FOREIGN KEY([stateAbbr])
REFERENCES [dbo].[STATE] ([stateAbbr])
GO
ALTER TABLE [dbo].[ORGANIZATION] CHECK CONSTRAINT [FK_ORGANIZATION_STATE]
GO
ALTER TABLE [dbo].[POST]  WITH CHECK ADD  CONSTRAINT [FK_POST_POST_CATEGORY] FOREIGN KEY([postCategoryId])
REFERENCES [dbo].[POST_CATEGORY] ([postCategoryId])
GO
ALTER TABLE [dbo].[POST] CHECK CONSTRAINT [FK_POST_POST_CATEGORY]
GO
ALTER TABLE [dbo].[REFERENCE]  WITH CHECK ADD  CONSTRAINT [FK_REFERENCE_STATE] FOREIGN KEY([stateAbbr])
REFERENCES [dbo].[STATE] ([stateAbbr])
GO
ALTER TABLE [dbo].[REFERENCE] CHECK CONSTRAINT [FK_REFERENCE_STATE]
GO
ALTER TABLE [dbo].[REFERENCE]  WITH CHECK ADD  CONSTRAINT [FK_REFERENCE_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[REFERENCE] CHECK CONSTRAINT [FK_REFERENCE_USER]
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
ALTER TABLE [dbo].[USER]  WITH CHECK ADD  CONSTRAINT [FK_USER_COUNTRY] FOREIGN KEY([schoolCountryId])
REFERENCES [dbo].[COUNTRY] ([countryId])
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_COUNTRY]
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD  CONSTRAINT [FK_USER_NATIONALITY] FOREIGN KEY([nationalityId])
REFERENCES [dbo].[NATIONALITY] ([nationalityId])
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_NATIONALITY]
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
INSERT INTO NATIONALITY (name) VALUES ('Palestinian');
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

INSERT INTO country (name) VALUES ('(Select One)');
INSERT INTO country (name) VALUES ('Afghanistan');
INSERT INTO country (name) VALUES ('Aland Islands');
INSERT INTO country (name) VALUES ('Albania');
INSERT INTO country (name) VALUES ('Algeria');
INSERT INTO country (name) VALUES ('American Samoa');
INSERT INTO country (name) VALUES ('Andorra');
INSERT INTO country (name) VALUES ('Angola');
INSERT INTO country (name) VALUES ('Anguilla');
INSERT INTO country (name) VALUES ('Antarctica');
INSERT INTO country (name) VALUES ('Antigua and Barbuda');
INSERT INTO country (name) VALUES ('Argentina');
INSERT INTO country (name) VALUES ('Armenia');
INSERT INTO country (name) VALUES ('Aruba');
INSERT INTO country (name) VALUES ('Australia');
INSERT INTO country (name) VALUES ('Austria');
INSERT INTO country (name) VALUES ('Azerbaijan');
INSERT INTO country (name) VALUES ('Bahamas');
INSERT INTO country (name) VALUES ('Bahrain');
INSERT INTO country (name) VALUES ('Bangladesh');
INSERT INTO country (name) VALUES ('Barbados');
INSERT INTO country (name) VALUES ('Belarus');
INSERT INTO country (name) VALUES ('Belgium');
INSERT INTO country (name) VALUES ('Belize');
INSERT INTO country (name) VALUES ('Benin');
INSERT INTO country (name) VALUES ('Bermuda');
INSERT INTO country (name) VALUES ('Bhutan');
INSERT INTO country (name) VALUES ('Bolivia');
INSERT INTO country (name) VALUES ('Bosnia and Herzegovina');
INSERT INTO country (name) VALUES ('Botswana');
INSERT INTO country (name) VALUES ('Bouvet Island');
INSERT INTO country (name) VALUES ('Brazil');
INSERT INTO country (name) VALUES ('British Indian Ocean Territory');
INSERT INTO country (name) VALUES ('Brunei Darussalam');
INSERT INTO country (name) VALUES ('Bulgaria');
INSERT INTO country (name) VALUES ('Burkina Faso');
INSERT INTO country (name) VALUES ('Burundi');
INSERT INTO country (name) VALUES ('Cambodia');
INSERT INTO country (name) VALUES ('Cameroon');
INSERT INTO country (name) VALUES ('Canada');
INSERT INTO country (name) VALUES ('Cape Verde');
INSERT INTO country (name) VALUES ('Cayman Islands');
INSERT INTO country (name) VALUES ('Central African Republic');
INSERT INTO country (name) VALUES ('Chad');
INSERT INTO country (name) VALUES ('Chile');
INSERT INTO country (name) VALUES ('China');
INSERT INTO country (name) VALUES ('Christmas Island');
INSERT INTO country (name) VALUES ('Cocos (Keeling) Islands');
INSERT INTO country (name) VALUES ('Colombia');
INSERT INTO country (name) VALUES ('Comoros');
INSERT INTO country (name) VALUES ('Congo');
INSERT INTO country (name) VALUES ('Congo, The Democratic Republic of the');
INSERT INTO country (name) VALUES ('Cook Islands');
INSERT INTO country (name) VALUES ('Costa Rica');
INSERT INTO country (name) VALUES ('Cote D Ivoire');
INSERT INTO country (name) VALUES ('Croatia');
INSERT INTO country (name) VALUES ('Cuba');
INSERT INTO country (name) VALUES ('Cyprus');
INSERT INTO country (name) VALUES ('Czech Republic');
INSERT INTO country (name) VALUES ('Denmark');
INSERT INTO country (name) VALUES ('Djibouti');
INSERT INTO country (name) VALUES ('Dominica');
INSERT INTO country (name) VALUES ('Dominican Republic');
INSERT INTO country (name) VALUES ('Ecuador');
INSERT INTO country (name) VALUES ('Egypt');
INSERT INTO country (name) VALUES ('El Salvador');
INSERT INTO country (name) VALUES ('Equatorial Guinea');
INSERT INTO country (name) VALUES ('Eritrea');
INSERT INTO country (name) VALUES ('Estonia');
INSERT INTO country (name) VALUES ('Ethiopia');
INSERT INTO country (name) VALUES ('Falkland Islands (Malvinas)');
INSERT INTO country (name) VALUES ('Faroe Islands');
INSERT INTO country (name) VALUES ('Fiji');
INSERT INTO country (name) VALUES ('Finland');
INSERT INTO country (name) VALUES ('France');
INSERT INTO country (name) VALUES ('French Guiana');
INSERT INTO country (name) VALUES ('French Polynesia');
INSERT INTO country (name) VALUES ('French Southern Territories');
INSERT INTO country (name) VALUES ('Gabon');
INSERT INTO country (name) VALUES ('Gambia');
INSERT INTO country (name) VALUES ('Georgia');
INSERT INTO country (name) VALUES ('Germany');
INSERT INTO country (name) VALUES ('Ghana');
INSERT INTO country (name) VALUES ('Gibraltar');
INSERT INTO country (name) VALUES ('Greece');
INSERT INTO country (name) VALUES ('Greenland');
INSERT INTO country (name) VALUES ('Grenada');
INSERT INTO country (name) VALUES ('Guadeloupe');
INSERT INTO country (name) VALUES ('Guam');
INSERT INTO country (name) VALUES ('Guatemala');
INSERT INTO country (name) VALUES ('Guernsey');
INSERT INTO country (name) VALUES ('Guinea');
INSERT INTO country (name) VALUES ('Guinea-Bissau');
INSERT INTO country (name) VALUES ('Guyana');
INSERT INTO country (name) VALUES ('Haiti');
INSERT INTO country (name) VALUES ('Heard Island and Mcdonald Islands');
INSERT INTO country (name) VALUES ('Holy See (Vatican City State)');
INSERT INTO country (name) VALUES ('Honduras');
INSERT INTO country (name) VALUES ('Hong Kong');
INSERT INTO country (name) VALUES ('Hungary');
INSERT INTO country (name) VALUES ('Iceland');
INSERT INTO country (name) VALUES ('India');
INSERT INTO country (name) VALUES ('Indonesia');
INSERT INTO country (name) VALUES ('Iran, Islamic Republic Of');
INSERT INTO country (name) VALUES ('Iraq');
INSERT INTO country (name) VALUES ('Ireland');
INSERT INTO country (name) VALUES ('Isle of Man');
INSERT INTO country (name) VALUES ('Israel');
INSERT INTO country (name) VALUES ('Italy');
INSERT INTO country (name) VALUES ('Jamaica');
INSERT INTO country (name) VALUES ('Japan');
INSERT INTO country (name) VALUES ('Jersey');
INSERT INTO country (name) VALUES ('Jordan');
INSERT INTO country (name) VALUES ('Kazakhstan');
INSERT INTO country (name) VALUES ('Kenya');
INSERT INTO country (name) VALUES ('Kiribati');
INSERT INTO country (name) VALUES ('Korea, Democratic Peoples Republic of');
INSERT INTO country (name) VALUES ('Korea, Republic of');
INSERT INTO country (name) VALUES ('Kuwait');
INSERT INTO country (name) VALUES ('Kyrgyzstan');
INSERT INTO country (name) VALUES ('Lao Peoples Democratic Republic');
INSERT INTO country (name) VALUES ('Latvia');
INSERT INTO country (name) VALUES ('Lebanon');
INSERT INTO country (name) VALUES ('Lesotho');
INSERT INTO country (name) VALUES ('Liberia');
INSERT INTO country (name) VALUES ('Libyan Arab Jamahiriya');
INSERT INTO country (name) VALUES ('Liechtenstein');
INSERT INTO country (name) VALUES ('Lithuania');
INSERT INTO country (name) VALUES ('Luxembourg');
INSERT INTO country (name) VALUES ('Macao');
INSERT INTO country (name) VALUES ('Macedonia, The Former Yugoslav Republic of');
INSERT INTO country (name) VALUES ('Madagascar');
INSERT INTO country (name) VALUES ('Malawi');
INSERT INTO country (name) VALUES ('Malaysia');
INSERT INTO country (name) VALUES ('Maldives');
INSERT INTO country (name) VALUES ('Mali');
INSERT INTO country (name) VALUES ('Malta');
INSERT INTO country (name) VALUES ('Marshall Islands');
INSERT INTO country (name) VALUES ('Martinique');
INSERT INTO country (name) VALUES ('Mauritania');
INSERT INTO country (name) VALUES ('Mauritius');
INSERT INTO country (name) VALUES ('Mayotte');
INSERT INTO country (name) VALUES ('Mexico');
INSERT INTO country (name) VALUES ('Micronesia, Federated States of');
INSERT INTO country (name) VALUES ('Moldova, Republic of');
INSERT INTO country (name) VALUES ('Monaco');
INSERT INTO country (name) VALUES ('Mongolia');
INSERT INTO country (name) VALUES ('Montserrat');
INSERT INTO country (name) VALUES ('Morocco');
INSERT INTO country (name) VALUES ('Mozambique');
INSERT INTO country (name) VALUES ('Myanmar');
INSERT INTO country (name) VALUES ('Namibia');
INSERT INTO country (name) VALUES ('Nauru');
INSERT INTO country (name) VALUES ('Nepal');
INSERT INTO country (name) VALUES ('Netherlands');
INSERT INTO country (name) VALUES ('Netherlands Antilles');
INSERT INTO country (name) VALUES ('New Caledonia');
INSERT INTO country (name) VALUES ('New Zealand');
INSERT INTO country (name) VALUES ('Nicaragua');
INSERT INTO country (name) VALUES ('Niger');
INSERT INTO country (name) VALUES ('Nigeria');
INSERT INTO country (name) VALUES ('Niue');
INSERT INTO country (name) VALUES ('Norfolk Island');
INSERT INTO country (name) VALUES ('Northern Mariana Islands');
INSERT INTO country (name) VALUES ('Norway');
INSERT INTO country (name) VALUES ('Oman');
INSERT INTO country (name) VALUES ('Pakistan');
INSERT INTO country (name) VALUES ('Palau');
INSERT INTO country (name) VALUES ('Palestinian Territory, Occupied');
INSERT INTO country (name) VALUES ('Panama');
INSERT INTO country (name) VALUES ('Papua New Guinea');
INSERT INTO country (name) VALUES ('Paraguay');
INSERT INTO country (name) VALUES ('Peru');
INSERT INTO country (name) VALUES ('Philippines');
INSERT INTO country (name) VALUES ('Pitcairn');
INSERT INTO country (name) VALUES ('Poland');
INSERT INTO country (name) VALUES ('Portugal');
INSERT INTO country (name) VALUES ('Puerto Rico');
INSERT INTO country (name) VALUES ('Qatar');
INSERT INTO country (name) VALUES ('Reunion');
INSERT INTO country (name) VALUES ('Romania');
INSERT INTO country (name) VALUES ('Russian Federation');
INSERT INTO country (name) VALUES ('RWANDA');
INSERT INTO country (name) VALUES ('Saint Helena');
INSERT INTO country (name) VALUES ('Saint Kitts and Nevis');
INSERT INTO country (name) VALUES ('Saint Lucia');
INSERT INTO country (name) VALUES ('Saint Pierre and Miquelon');
INSERT INTO country (name) VALUES ('Saint Vincent and the Grenadines');
INSERT INTO country (name) VALUES ('Samoa');
INSERT INTO country (name) VALUES ('San Marino');
INSERT INTO country (name) VALUES ('Sao Tome and Principe');
INSERT INTO country (name) VALUES ('Saudi Arabia');
INSERT INTO country (name) VALUES ('Senegal');
INSERT INTO country (name) VALUES ('Serbia and Montenegro');
INSERT INTO country (name) VALUES ('Seychelles');
INSERT INTO country (name) VALUES ('Sierra Leone');
INSERT INTO country (name) VALUES ('Singapore');
INSERT INTO country (name) VALUES ('Slovakia');
INSERT INTO country (name) VALUES ('Slovenia');
INSERT INTO country (name) VALUES ('Solomon Islands');
INSERT INTO country (name) VALUES ('Somalia');
INSERT INTO country (name) VALUES ('South Africa');
INSERT INTO country (name) VALUES ('South Georgia and the South Sandwich Islands');
INSERT INTO country (name) VALUES ('Spain');
INSERT INTO country (name) VALUES ('Sri Lanka');
INSERT INTO country (name) VALUES ('Sudan');
INSERT INTO country (name) VALUES ('Suriname');
INSERT INTO country (name) VALUES ('Svalbard and Jan Mayen');
INSERT INTO country (name) VALUES ('Swaziland');
INSERT INTO country (name) VALUES ('Sweden');
INSERT INTO country (name) VALUES ('Switzerland');
INSERT INTO country (name) VALUES ('Syrian Arab Republic');
INSERT INTO country (name) VALUES ('Taiwan, Province of China');
INSERT INTO country (name) VALUES ('Tajikistan');
INSERT INTO country (name) VALUES ('Tanzania, United Republic of');
INSERT INTO country (name) VALUES ('Thailand');
INSERT INTO country (name) VALUES ('Timor-Leste');
INSERT INTO country (name) VALUES ('Togo');
INSERT INTO country (name) VALUES ('Tokelau');
INSERT INTO country (name) VALUES ('Tonga');
INSERT INTO country (name) VALUES ('Trinidad and Tobago');
INSERT INTO country (name) VALUES ('Tunisia');
INSERT INTO country (name) VALUES ('Turkey');
INSERT INTO country (name) VALUES ('Turkmenistan');
INSERT INTO country (name) VALUES ('Turks and Caicos Islands');
INSERT INTO country (name) VALUES ('Tuvalu');
INSERT INTO country (name) VALUES ('Uganda');
INSERT INTO country (name) VALUES ('Ukraine');
INSERT INTO country (name) VALUES ('United Arab Emirates');
INSERT INTO country (name) VALUES ('United Kingdom');
INSERT INTO country (name) VALUES ('United States');
INSERT INTO country (name) VALUES ('United States Minor Outlying Islands');
INSERT INTO country (name) VALUES ('Uruguay');
INSERT INTO country (name) VALUES ('Uzbekistan');
INSERT INTO country (name) VALUES ('Vanuatu');
INSERT INTO country (name) VALUES ('Venezuela');
INSERT INTO country (name) VALUES ('Viet Nam');
INSERT INTO country (name) VALUES ('Virgin Islands, British');
INSERT INTO country (name) VALUES ('Virgin Islands, U.S.');
INSERT INTO country (name) VALUES ('Wallis and Futuna');
INSERT INTO country (name) VALUES ('Western Sahara');
INSERT INTO country (name) VALUES ('Yemen');
INSERT INTO country (name) VALUES ('Zambia');
INSERT INTO country (name) VALUES ('Zimbabwe');

INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	1	,	'Applicant'	,	'This role provides a user the ability to save profile data, submit zakat application(s), and monitor zakat application status'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	2	,	'Validator'	,	'This role provides a user the ability to review a zakat application for completeness'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	3	,	'Investigator'	,	'This role provides a user the ability to review the zakat case to determine that a need exists'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	4	,	'Qualifier'	,	'This role provides a user the ability to determine zakat eligibility based on Islamic jurisprudence'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	5	,	'Administrator'	,	'This role provides a user the ability to administer various reference data related to the system'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	6	,	'Financier'	,	'This role provides a user the ability to be notified about an approved zakat application so that funds can be dispersed'	);
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
INSERT INTO STATE (	stateAbbr	,	stateName	) VALUES (	'OT'	,	'Other'	);

INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	1	,	'(Select One)');
INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	2	,	'Government Photo Identification');
INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	3	,	'Lease/Mortgage Bill');
INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	4	,	'Utility Bill');
INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	5	,	'Medical Bill');
INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	6	,	'Tuition Bill');
INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	7	,	'Eviction Notice');
INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	8	,	'Local Masjid Reference Letter');
INSERT INTO ARTIFACT_TYPE (	artifactTypeId	,	name) VALUES (	9	,	'Other');

INSERT INTO [dbo].[USER] (email,	[passwordEncrypted],	firstName,	lastName, phone) VALUES ('zakat@icclmd.org'	,	'gTEsGnri3KlAMeqLLgPaPLLcG+W41gS48eTNnAXCEcc='	,	'ICCL Zakat', 'Administrator', '3013174584');
INSERT INTO [dbo].[USER] (email,	[passwordEncrypted],	firstName,	lastName, phone) VALUES ('eiad.sayyad@gmail.com'	,	'gTEsGnri3KlAMeqLLgPaPLLcG+W41gS48eTNnAXCEcc='	,	'Applicant', 'Applicant', '3013174584');
INSERT INTO [dbo].[USER] (email,	[passwordEncrypted],	firstName,	lastName, phone) VALUES ('eiad.sayyad@outlook.com'	,	'gTEsGnri3KlAMeqLLgPaPLLcG+W41gS48eTNnAXCEcc='	,	'Qualifier', 'Qualifier', '3013174584');
INSERT INTO [dbo].[USER] (email,	[passwordEncrypted],	firstName,	lastName, phone) VALUES ('mohammed.sayyad@gmail.com'	,	'gTEsGnri3KlAMeqLLgPaPLLcG+W41gS48eTNnAXCEcc='	,	'Mohammed', 'Sayyad', '3013174584');
INSERT INTO [dbo].[USER] (email,	[passwordEncrypted],	firstName,	lastName, phone) VALUES ('masbhaiyat@gmail.com'	,	'gTEsGnri3KlAMeqLLgPaPLLcG+W41gS48eTNnAXCEcc='	,	'Masihullah', 'Bhaiyat', '3013174584');
INSERT INTO [dbo].[USER] (email,	[passwordEncrypted],	firstName,	lastName, phone) VALUES ('areebakarim99@gmail.com'	,	'gTEsGnri3KlAMeqLLgPaPLLcG+W41gS48eTNnAXCEcc='	,	'Areeb', 'Karim', '3013174584');


INSERT INTO [dbo].[ORGANIZATION] ([name],[abbreviation],[street],[city],[stateAbbr],[zip],[email],[phone],[website]) VALUES ('Islamic Community Center of Laurel','ICCL','7306 Contee Road','Laurel','MD','20707','office@icclmd.org','3013174584', 'https://www.icclmd.org')
INSERT INTO [dbo].[ORGANIZATION] ([name],[abbreviation],[street],[city],[stateAbbr],[zip],[email],[phone],[website]) VALUES ('Maryland Institute of Development','MID','7306 Contee Road','Laurel','MD','20707','office@icclmd.org','3013174584', 'https://www.marylandinstitute.org/')

INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (1, 1, 5);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (2, 1, 5);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (3, 1, 5);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (4, 1, 2);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (4, 1, 3);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (4, 1, 4);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (4, 1, 5);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (4, 1, 6);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (5, 1, 2);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (5, 1, 3);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (5, 1, 4);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (5, 1, 5);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (5, 1, 6);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (6, 1, 2);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (6, 1, 3);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (6, 1, 4);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (6, 1, 5);
INSERT INTO [dbo].[USER_ROLE] (userId, organizationId, roleId) VALUES (6, 1, 6);


INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Online Zakat Home Page','Online Zakat Login Username: Password: Or, Submit an Online Zakat Application! Current Average Duration To Process A Zakat Application: N/A (Average Duration Is From Application Submission to 2nd Qualification) Advantages of the Online Zakat System Save your online zakat application data electronically and securely Submit online zakat application(s) to one or more Islamic organizations Correspondence is sent/received via email when decisions are made Edit your saved profile as often as necessary Track the progress of your submitted online zakat application Complete the zakat form in a language that you understand Required Zakat Protocols and Documents Applicants, Prior to your completing an Online Zakat Application, please download, review and adhere to the following:','default')
INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Online Zakat Contact Us Page','Online Zakat Contact Information 7306 Contee Road Laurel, MD 20707 Ph: 301.317.4584 ICCL Office Manager: office@icclmd.org Online Zakat Administrator: zakat@icclmd.org ICCL General Website: https://www.icclmd.org Online Zakat Website: https://zakat.icclmd.org','contact')
INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Online Zakat About Us Page','About Online Zakat Welcome to Online Zakat, a groundbreaking platform dedicated to facilitating the distribution of zakat as well as empowering communities in need. At Online Zakat, we believe in the transformative power of Zakat, an essential pillar of Islamic faith, to bring positive change to the lives of individuals and society as a whole. Our platform serves as a unified hub for local Masajid (mosques) to upload their information, enabling us to effectively assess eligibility and allocate Zakat funds to deserving recipients. We have created a streamlined process that ensures transparency, efficiency, and impactful distribution of Zakat contributions. With a deep commitment to social welfare and upliftment, Online Zakat strives to make a meaningful difference by connecting those who have Zakat funds to share with those who require support. By leveraging technology and a user-friendly interface, we have simplified the process of Zakat distribution, making it accessible to Masajid and individuals alike. Our mission goes beyond mere financial assistance. We firmly believe in fostering empowerment and sustainable change within communities. By providing a platform for Masajid to upload their information, we strengthen the network of support and enable local institutions to play an active role in addressing the needs of their congregants. Online Zakat is built on the principles of accountability and trust. We ensure that every contribution is utilized judiciously and reaches the intended recipients. Our stringent verification process and rigorous eligibility criteria enable us to maintain the highest standards of fairness and equity. Join us on this journey of compassion and solidarity by becoming a vital part of our shared vision to create a society where the blessings of Zakat reach those who truly need it. Together, let us uplift lives, strengthen communities, and fulfill the divine mandate of Zakat. Thank you for being a part of Online Zakat, and for making a difference in the lives of those in need.','about')
INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Organizations Affiliated with Online Zakat','Organizations Affiliated with Online Zakat View Affiliated Organizations: Name Phone Email Website View Islamic Community Center of Laurel (ICCL) 301-317-4584	office@icclmd.org https://www.icclmd.org Maryland Institute of Development (MID) 571-338-5053 admin@marylandinstitute.org https://www.marylandinstitute.org/','organizations')
INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Online Zakat Privacy Notice','Privacy Notice This privacy notice discloses the privacy practices for https://zakat.icclmd.org. This privacy notice applies solely to information collected by this website. It will notify you of the following: What personally identifiable information is collected from you through the website, how it is used and with whom it may be shared. What choices are available to you regarding the use of your data. The security procedures in place to protect the misuse of your information. How you can correct any inaccuracies in the information. Information Collection, Use, and Sharing We are the sole owners of the information collected on this site. We only have access to/collect information that you voluntarily give us via email or other direct contact from you. We will not sell or rent this information to anyone. We will use your information to respond to you, regarding the reason you contacted us. We will not share your information with any third party outside of our organization, other than as necessary to fulfill your request (e.g., to record zakat profile information, dependent information, and zakat payments). Unless you ask us not to, we may contact you via email in the future to tell you about services and/or changes to this privacy policy. Your Access to and Control Over Information You may opt out of any future contacts from us at any time by contacting the association and informing us of your decision. You can do the following at any time by contacting us via the email address or phone number given on our website: See what data we have about you, if any. Change/correct any data we have about you. Have us delete any data we have about you. Express any concern you have about our use of your data. Security We take precautions to protect your information. When you submit sensitive information via the website, your information is protected both online and offline. Wherever we collect sensitive information and personally identifiable information (such as name and date of birth), that information is encrypted and transmitted to us in a secure way. You can verify this by looking for a lock icon in the address bar and looking for "https" at the beginning of the address of the Web page. While we use encryption to protect sensitive information transmitted online, we also protect your information offline. Only select members of the association who need the information to perform a specific job (for example, approving zakat applications or those performing maintenance and administration) are granted access to personally identifiable information. The computers/servers in which we store personally identifiable information are kept in a secure environment with a hosting provider. If you feel that we are not abiding by this privacy policy, you should contact us immediately via telephone at 301.317.4584 or via email at: zakat@icclmd.org.','privacy')
INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Online Zakat Application Protocols & Required Documents','Online Zakat Application Protocols & Required (Supporting) Documents Complete the Online Zakat application form FULLY by answering all questions with the most accurate information available. Together with your application, submit and observe/abide by the following requirements: Provide a valid copy of a Driver''s License or Government issued photo identification Provide copies of all documents related to and/or supporting financial hardship Any submitted Online Zakat application and their related documents once processed and approved, CANNOT be used for other zakat applications. Online zakat application and related supporting documents are required and MUST be submitted for each new application Applicants shall NOT apply/submit multiple zakat applications within same calendar month or within number of days less than one calendar month Incomplete or partially completed applications will delay timely processing & may/could result into the application being denied An applicant who is claimed as a dependent shall NOT apply at the same time/period with the applicant who has claimed him/her Note: Applicant is responsible for making and providing copies of all required documents.','protocols')
INSERT INTO [dbo].[TOPIC] ([topicName],[topicContent],[topicLink]) VALUES ('Online Zakat User Forum','Create a Post Post Search Tools Search Post Content: type & click enter Search By Category: Application (3) Communication (1) Dispersal (24) Other (0) Process (14) Timeliness (0) Translation (3) Welcome to the Zakat Network User Form, a place where our zakat applicants can share ideas amongst one another and gain advice prior to submitting zakat applications. We ask that all content created by existing users to remain civil and please note we reserve the right to remove content which is not suitable for the Zakat Network User Form. Categories Search Posts See a list of posts based on category by click on the category in our navigation pane. Search for a post across all categories by entering keywords in the search textbox. If you can find an existing post based on those from other users, create your own.','discussion')

INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (1,'Arabic','العربية','https://translate.google.com/translate?sl=en&tl=ar&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (2,'Chechen','Нохчийн мотт','https://zakat-icclmd-org.translate.goog/?_x_tr_sl=en&_x_tr_tl=ru&_x_tr_hl=en&_x_tr_pto=wapp');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (3,'English','English','https://zakat.icclmd.org/');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (4,'French','Français','https://translate.google.com/translate?hl=&sl=en&tl=fr&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (5,'German','Deutsch','https://zakat-icclmd-org.translate.goog/?_x_tr_sl=en&_x_tr_tl=de&_x_tr_hl=en&_x_tr_pto=wapp');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (6,'Indonesian','Bahasa Indonesia','https://translate.google.com/translate?hl=&sl=en&tl=id&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (7,'Italian','italiano','https://zakat-icclmd-org.translate.goog/?_x_tr_sl=en&_x_tr_tl=it&_x_tr_hl=en&_x_tr_pto=wapp');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (8,'Hindi','हिन्दी','https://zakat-icclmd-org.translate.goog/?_x_tr_sl=en&_x_tr_tl=hi&_x_tr_hl=en&_x_tr_pto=wapp');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (9,'Kurdish','کوردی','https://zakat-icclmd-org.translate.goog/?_x_tr_sl=en&_x_tr_tl=ckb&_x_tr_hl=en&_x_tr_pto=wapp');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (10,'Malay','Bahasa Melayu','https://translate.google.com/translate?hl=&sl=en&tl=ms&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (11,'Pashto','پښتو','https://translate.google.com/translate?hl=&sl=en&tl=ps&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (12,'Persian','فارسى','https://translate.google.com/translate?hl=&sl=en&tl=fa&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (13,'Somali','اَف سٝومالِ','https://translate.google.com/translate?hl=&sl=en&tl=so&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (14,'Spanish','español','https://translate.google.com/translate?hl=&sl=en&tl=es&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (15,'Thai','ภาษาไทย','https://translate.google.com/translate?hl=&sl=en&tl=th&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (16,'Turkish','Türkçe','https://translate.google.com/translate?hl=&sl=en&tl=tr&u=https%3A%2F%2Fzakat.icclmd.org%2F');
INSERT INTO [dbo].[TRANSLATION] (translationId,translationNameEnglish,translationNameNative,translationURL) VALUES (17,'Urdu','اردو','https://translate.google.com/translate?hl=&sl=en&tl=ur&u=https%3A%2F%2Fzakat.icclmd.org%2F');
GO

INSERT INTO [zakat].[dbo].[POST_CATEGORY] ([name], [description], [countOfPosts]) VALUES ('Process', 'Process', 0)
INSERT INTO [zakat].[dbo].[POST_CATEGORY] ([name], [description], [countOfPosts]) VALUES ('Dispersal', 'Dispersal', 0)
INSERT INTO [zakat].[dbo].[POST_CATEGORY] ([name], [description], [countOfPosts]) VALUES ('Communication', 'Communication', 0)
INSERT INTO [zakat].[dbo].[POST_CATEGORY] ([name], [description], [countOfPosts]) VALUES ('Timeliness', 'Timeliness', 0)
INSERT INTO [zakat].[dbo].[POST_CATEGORY] ([name], [description], [countOfPosts]) VALUES ('Application', 'Application', 0)
INSERT INTO [zakat].[dbo].[POST_CATEGORY] ([name], [description], [countOfPosts]) VALUES ('Translation', 'Translation', 0)
INSERT INTO [zakat].[dbo].[POST_CATEGORY] ([name], [description], [countOfPosts]) VALUES ('Other', 'Other', 0)