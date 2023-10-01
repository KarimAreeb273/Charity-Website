DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_DRAFTED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_SUBMITTED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_VALIDATED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_INVESTIGATED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_QUALIFIED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_DISPERSED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_REJECTED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_BY_USER_AGE;
GO 

CREATE VIEW dbo.VW_APPLICATIONS_DRAFTED_BY_YEAR AS
SELECT YEAR(draftedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isDrafted = 1
GO

CREATE VIEW dbo.VW_APPLICATIONS_SUBMITTED_BY_YEAR AS
SELECT YEAR(submittedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isSubmitted = 1
GO

CREATE VIEW dbo.VW_APPLICATIONS_VALIDATED_BY_YEAR AS
SELECT YEAR(validatedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isValidated = 1
GO

CREATE VIEW dbo.VW_APPLICATIONS_INVESTIGATED_BY_YEAR AS
SELECT YEAR(investigatedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isInvestigated = 1
GO

CREATE VIEW dbo.VW_APPLICATIONS_QUALIFIED_BY_YEAR AS
SELECT YEAR(qualified2On) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isQualified2 = 1
GO

CREATE VIEW dbo.VW_APPLICATIONS_DISPERSED_BY_YEAR AS
SELECT YEAR(dispersedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isDispersed = 1
GO

CREATE VIEW dbo.VW_APPLICATIONS_REJECTED_BY_YEAR AS
SELECT YEAR(rejectedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isRejected = 1
GO

CREATE VIEW dbo.VW_APPLICATIONS_BY_USER_AGE AS
SELECT a.applicationId, a.userId, a.isSubmitted, a.isDispersed, a.isRejected, DATEDIFF(hour,u.dob,GETDATE())/8766 AS Age
FROM [APPLICATION] a, [USER] u
WHERE a.userId = u.userId
GO

--create view that provides average processing days by year and month
CREATE VIEW dbo.VW_APPLICATIONS_AVG_PROCESSING_DAYS AS
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

--create view that provides total dispersements by year and month
CREATE VIEW dbo.VW_APPLICATIONS_TOTAL_DISPERSED AS
SELECT 
    a.applicationId,
    YEAR(a.dispersedOn) AS year,
    MONTH(a.dispersedOn) AS month, 
    a.dispersedAmount
FROM [APPLICATION] a
WHERE a.dispersedAmount IS NOT NULL
GO