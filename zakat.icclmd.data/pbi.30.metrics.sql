DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_DRAFTED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_SUBMITTED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_INVESTIGATED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_QUALIFIED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_DISPERSED_BY_YEAR;  
GO
DROP VIEW IF EXISTS dbo.VW_APPLICATIONS_REJECTED_BY_YEAR;  
GO

CREATE VIEW VW_APPLICATIONS_DRAFTED_BY_YEAR AS
SELECT YEAR(draftedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isDrafted = 1
GO

CREATE VIEW VW_APPLICATIONS_SUBMITTED_BY_YEAR AS
SELECT YEAR(submittedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isSubmitted = 1
GO

CREATE VIEW VW_APPLICATIONS_INVESTIGATED_BY_YEAR AS
SELECT YEAR(investigatedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isInvestigated = 1
GO

CREATE VIEW VW_APPLICATIONS_QUALIFIED_BY_YEAR AS
SELECT YEAR(qualified2On) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isQualified2 = 1
GO

CREATE VIEW VW_APPLICATIONS_DISPERSED_BY_YEAR AS
SELECT YEAR(dispersedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isDispersed = 1
GO

CREATE VIEW VW_APPLICATIONS_REJECTED_BY_YEAR AS
SELECT YEAR(rejectedOn) AS applicationYear , 1 AS applicationCount
FROM APPLICATION
WHERE isRejected = 1
GO