USE PeopleDB;
GO

SELECT * FROM dbo.Person;
GO

SELECT * FROM dbo.Job;
GO

SELECT * FROM dbo.Address;
GO

SELECT * FROM dbo.Phone;
GO


SELECT p.FirstName, p.LastName, j.JobTitle, j.StartDate, j.EndDate
FROM dbo.Person p
INNER JOIN dbo.Job j
ON p.PersonID = j.PersonID;


SELECT p.FirstName, p.LastName, j.JobTitle, j.StartDate, j.EndDate, a.Street, a.City, a.Country
FROM dbo.Person p
INNER JOIN dbo.Job j ON p.PersonID = j.PersonID
INNER JOIN dbo.Address a ON p.PersonID = a.PersonID;
