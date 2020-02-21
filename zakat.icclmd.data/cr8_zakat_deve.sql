USE [zakat]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [FK_USER_STATUS]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [FK_USER_STATE]
GO
ALTER TABLE [dbo].[MEMBER_DUES] DROP CONSTRAINT [FK_DUES_USER]
GO
ALTER TABLE [dbo].[MEMBER_DUES] DROP CONSTRAINT [FK_DUES_DUES_TYPE]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_updatedOn]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_createdOn]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_hasReference]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_isApproved]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_isUsingHeadEmail]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_isAuthenticated]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_isHouseholdHead]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_isAdmin]
GO
ALTER TABLE [dbo].[USER] DROP CONSTRAINT [DF_USER_isVoterEligible]
GO
ALTER TABLE [dbo].[MEMBER_DUES] DROP CONSTRAINT [DF_MEMBER_DUES_paypalIpnIsSuccessful]
GO
ALTER TABLE [dbo].[MEMBER_DUES] DROP CONSTRAINT [DF_MEMBER_DUES_paypalPdtIsSuccessful]
GO
ALTER TABLE [dbo].[MEMBER_DUES] DROP CONSTRAINT [DF_MEMBER_DUES_isConfirmed]
GO
ALTER TABLE [dbo].[DUES_TYPE] DROP CONSTRAINT [DF_DUES_TYPE_updatedOn]
GO
ALTER TABLE [dbo].[DUES_TYPE] DROP CONSTRAINT [DF_DUES_TYPE_createdOn]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 1/21/2019 8:09:10 AM ******/
DROP TABLE [dbo].[USER]
GO
/****** Object:  Table [dbo].[STATUS]    Script Date: 1/21/2019 8:09:10 AM ******/
DROP TABLE [dbo].[STATUS]
GO
/****** Object:  Table [dbo].[STATE]    Script Date: 1/21/2019 8:09:10 AM ******/
DROP TABLE [dbo].[STATE]
GO
/****** Object:  Table [dbo].[MEMBER_DUES]    Script Date: 1/21/2019 8:09:10 AM ******/
DROP TABLE [dbo].[MEMBER_DUES]
GO
/****** Object:  Table [dbo].[DUES_TYPE]    Script Date: 1/21/2019 8:09:10 AM ******/
DROP TABLE [dbo].[DUES_TYPE]
GO
/****** Object:  Table [dbo].[DUES_TYPE]    Script Date: 1/21/2019 8:09:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DUES_TYPE](
	[duesTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](10) NULL,
	[description] [varchar](150) NULL,
	[amount] [money] NULL,
	[discountMonth] [smallint] NULL,
	[discountDay] [smallint] NULL,
	[discountPercent] [decimal](2, 2) NULL,
	[effectiveDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[isActive] [bit] NULL,
	[createdOn] [datetime] NULL,
	[createdBy] [int] NULL,
	[updatedOn] [datetime] NULL,
	[updatedBy] [int] NULL,
 CONSTRAINT [PK_DUES_TYPE] PRIMARY KEY CLUSTERED 
(
	[duesTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEMBER_DUES]    Script Date: 12/25/2018 8:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEMBER_DUES](
	[memberDuesId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[duesTypeId] [int] NULL,
	[isConfirmed] [bit] NOT NULL,
	[paymentDate] [datetime] NULL,
	[paymentMethod] [varchar](20) NULL,
	[paymentAmount] [money] NULL,
	[paymentReference] [varchar](255) NULL,
	[membershipYear] [varchar](4) NULL,
	[paypalPdtIsSuccessful] [bit] NULL,
	[paypalPdtConfirmDate] [datetime] NULL,
	[paypalPdtTransactionId] [varchar](50) NULL,
	[paypalPdtResponse] [varchar](4000) NULL,
	[paypalIpnIsSuccessful] [bit] NULL,
	[paypalIpnConfirmDate] [datetime] NULL,
	[paypalIpnTransactionId] [varchar](50) NULL,
	[paypalIpnResponse] [varchar](4000) NULL,
	[recordedBy] [int] NULL,
 CONSTRAINT [PK_DUES] PRIMARY KEY CLUSTERED 
(
	[memberDuesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STATE]    Script Date: 12/25/2018 8:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STATE](
	[stateAbbr] [varchar](2) NOT NULL,
	[stateName] [varchar](30) NULL,
 CONSTRAINT [PK_STATE] PRIMARY KEY CLUSTERED 
(
	[stateAbbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STATUS]    Script Date: 12/25/2018 8:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STATUS](
	[statusId] [int] NOT NULL,
	[name] [varchar](20) NULL,
	[description] [varchar](150) NULL,
 CONSTRAINT [PK_STATUS] PRIMARY KEY CLUSTERED 
(
	[statusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 12/25/2018 8:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[statusId] [int] NULL,
	[memberType] [varchar](10) NULL,
	[householdHeadId] [int] NULL,
	[citizenshipStatus] [varchar](20) NULL,
	[maritalStatus] [varchar](10) NULL,
	[dependencyType] [varchar](10) NULL,
	[email] [varchar](60) NULL,
	[password] [varchar](20) NULL,
	[firstName] [varchar](30) NULL,
	[middleName] [varchar](30) NULL,
	[lastName] [varchar](30) NULL,
	[phone] [varchar](10) NULL,
	[gender] [varchar](10) NULL,
	[dob] [datetime] NULL,
	[street] [varchar](100) NULL,
	[city] [varchar](50) NULL,
	[county] [varchar](25) NULL,
	[stateAbbr] [varchar](2) NULL,
	[zip] [varchar](5) NULL,
	[isVoterEligible] [bit] NULL,
	[isAdmin] [bit] NULL,
	[isHouseholdHead] [bit] NULL,
	[isAuthenticated] [bit] NULL,
	[isUsingHeadEmail] [bit] NULL,
	[isApproved] [bit] NULL,
	[hasReference] [bit] NOT NULL,
	[referenceName] [varchar](90) NULL,
	[referenceEmail] [varchar](60) NULL,
	[referencePhone] [varchar](10) NULL,
	[approvedOn] [datetime] NULL,
	[approvedBy] [int] NULL,
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
ALTER TABLE [dbo].[DUES_TYPE] ADD  CONSTRAINT [DF_DUES_TYPE_createdOn]  DEFAULT (getdate()) FOR [createdOn]
GO
ALTER TABLE [dbo].[DUES_TYPE] ADD  CONSTRAINT [DF_DUES_TYPE_updatedOn]  DEFAULT (getdate()) FOR [updatedOn]
GO
ALTER TABLE [dbo].[MEMBER_DUES] ADD  CONSTRAINT [DF_MEMBER_DUES_isConfirmed]  DEFAULT ((0)) FOR [isConfirmed]
GO
ALTER TABLE [dbo].[MEMBER_DUES] ADD  CONSTRAINT [DF_MEMBER_DUES_paypalPdtIsSuccessful]  DEFAULT ((0)) FOR [paypalPdtIsSuccessful]
GO
ALTER TABLE [dbo].[MEMBER_DUES] ADD  CONSTRAINT [DF_MEMBER_DUES_paypalIpnIsSuccessful]  DEFAULT ((0)) FOR [paypalIpnIsSuccessful]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_isVoterEligible]  DEFAULT ((0)) FOR [isVoterEligible]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_isAdmin]  DEFAULT ((0)) FOR [isAdmin]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_isHouseholdHead]  DEFAULT ((1)) FOR [isHouseholdHead]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_isAuthenticated]  DEFAULT ((0)) FOR [isAuthenticated]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_isUsingHeadEmail]  DEFAULT ((0)) FOR [isUsingHeadEmail]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_isApproved]  DEFAULT ((0)) FOR [isApproved]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_hasReference]  DEFAULT ((0)) FOR [hasReference]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_createdOn]  DEFAULT (getdate()) FOR [createdOn]
GO
ALTER TABLE [dbo].[USER] ADD  CONSTRAINT [DF_USER_updatedOn]  DEFAULT (getdate()) FOR [updatedOn]
GO
ALTER TABLE [dbo].[MEMBER_DUES]  WITH CHECK ADD  CONSTRAINT [FK_DUES_DUES_TYPE] FOREIGN KEY([duesTypeId])
REFERENCES [dbo].[DUES_TYPE] ([duesTypeId])
GO
ALTER TABLE [dbo].[MEMBER_DUES] CHECK CONSTRAINT [FK_DUES_DUES_TYPE]
GO
ALTER TABLE [dbo].[MEMBER_DUES]  WITH CHECK ADD  CONSTRAINT [FK_DUES_USER] FOREIGN KEY([userId])
REFERENCES [dbo].[USER] ([userId])
GO
ALTER TABLE [dbo].[MEMBER_DUES] CHECK CONSTRAINT [FK_DUES_USER]
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD  CONSTRAINT [FK_USER_STATE] FOREIGN KEY([stateAbbr])
REFERENCES [dbo].[STATE] ([stateAbbr])
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_STATE]
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD  CONSTRAINT [FK_USER_STATUS] FOREIGN KEY([statusId])
REFERENCES [dbo].[STATUS] ([statusId])
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_STATUS]
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
INSERT INTO LANGUAGE (name) VALUES ('PÄli');
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

INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	1	,	'Public'	,	'This role provides a user the ability to save profile data, submit zakat application(s), and monitor zakat application status'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	2	,	'Validator'	,	'This role provides a user the ability to review a zakat application for completeness'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	3	,	'Investigator'	,	'This role provides a user the ability to review the zakat case to determine that a need exists'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	4	,	'Qualifier'	,	'This role provides a user the ability to determine zakat eligibility based on Islamic jurisprudence'	);
INSERT INTO ROLE (	roleId	,	name	,	description	) VALUES (	5	,	'Administrator'	,	'This role provides a user the ability to administer various reference data related to the system'	);

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

-- INSERT INTO STATUS (	statusId	,	name	,	description	) VALUES (	1	,	'Submitted'	,	'The zakat application has been submitted and is now awaiting validation that it is complete'	);
-- INSERT INTO STATUS (	statusId	,	name	,	description	) VALUES (	2	,	'Validated'	,	'The zakat application has been valdiated for completion'	);
-- INSERT INTO STATUS (	statusId	,	name	,	description	) VALUES (	3	,	'Investigated'	,	'The zakat application has been investigated to ensure that a need exists'	);
-- INSERT INTO STATUS (	statusId	,	name	,	description	) VALUES (	4	,	'Qualified'	,	'The zakat application has been determined to be qualified by jurists'	);
-- INSERT INTO STATUS (	statusId	,	name	,	description	) VALUES (	5	,	'Approved'	,	'The zakat application has been approved with a distinct amount'	);
-- INSERT INTO STATUS (	statusId	,	name	,	description	) VALUES (	6	,	'Rejected'	,	'The zakat application has been rejected with one or more reasons'	);

INSERT INTO [dbo].[USER] (	statusId,	email,	password,	firstName,	phone,	street,	city,	county,	stateAbbr,	zip,	isVoterEligible,	isAdmin,	isHouseholdHead,	isAuthenticated,	isUsingHeadEmail,	isApproved,	createdBy,	updatedBy	) VALUES (	2	,	'office@icclmd.org'	,	'changeme'	,	'ICCL Zakat Admin'	,	3013174584	,	'7306 Contee Road'	,	'Laurel'	,	'Prince Georges'	,	'MD'	,	'20707'	,	0	,	1	,	1	,	1	,	0	,	0	,	0	,	0	);






