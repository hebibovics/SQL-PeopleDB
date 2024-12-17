USE PeopleDB;
GO

CREATE VIEW vw_PersonJob AS
SELECT 
    p.FirstName, 
    p.LastName, 
    j.JobTitle, 
    j.StartDate, 
    j.EndDate
FROM dbo.Person p
INNER JOIN dbo.Job j
ON p.PersonID = j.PersonID;
GO



CREATE VIEW vw_PersonAddress AS
SELECT 
    p.FirstName, 
    p.LastName, 
    a.Street, 
    a.City, 
    a.Country, 
    a.PostalCode
FROM dbo.Person p
INNER JOIN dbo.Address a
ON p.PersonID = a.PersonID;
GO

CREATE VIEW vw_AllPersonData AS
SELECT 
    p.PersonID,
    p.FirstName, 
    p.LastName, 
    p.DateOfBirth, 
    p.Gender, 
    p.Email,
    j.JobTitle, 
    j.StartDate, 
    j.EndDate, 
    a.Street, 
    a.City, 
    a.Country, 
    a.PostalCode,
    ph.PhoneNumber, 
    ph.PhoneType
FROM dbo.Person p
LEFT JOIN dbo.Job j ON p.PersonID = j.PersonID
LEFT JOIN dbo.Address a ON p.PersonID = a.PersonID
LEFT JOIN dbo.Phone ph ON p.PersonID = ph.PersonID;
GO


SELECT * FROM vw_PersonJob;
GO


SELECT * FROM vw_PersonAddress;
GO

SELECT * FROM vw_AllPersonData;
GO
