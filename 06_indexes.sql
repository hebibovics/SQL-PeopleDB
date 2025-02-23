USE PeopleDB

-- search by name
CREATE INDEX IX_Person_Name ON dbo.Person(FirstName, LastName);

-- search jobs by person
CREATE INDEX IX_Job_PersonID ON dbo.Job(PersonID);

-- address - person
CREATE INDEX IX_Address_PersonID ON dbo.Address(PersonID);

-- phone - person
CREATE INDEX IX_Phone_PersonID ON dbo.Phone(PersonID);

SELECT 
    t.name AS TableName, 
    i.name AS IndexName, 
    i.type_desc AS IndexType
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
WHERE t.name IN ('Person', 'Job', 'Address', 'Phone');
