-- 1
USE PeopleDB
CREATE PROCEDURE sp_AddPersonWithDetails
    @FirstName NVARCHAR(30),
    @LastName NVARCHAR(30),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email NVARCHAR(100),
    @Street NVARCHAR(100),
    @City NVARCHAR(50),
    @Country NVARCHAR(50),
    @PostalCode NVARCHAR(6),
    @PhoneNumber NVARCHAR(15),
    @PhoneType NVARCHAR(10)
AS
BEGIN
    DECLARE @PersonID INT;
    
    INSERT INTO dbo.Person (FirstName, LastName, DateOfBirth, Gender, Email)
    VALUES (@FirstName, @LastName, @DateOfBirth, @Gender, @Email);
    
    SET @PersonID = SCOPE_IDENTITY();
    
    INSERT INTO dbo.Address (PersonID, Street, City, Country, PostalCode)
    VALUES (@PersonID, @Street, @City, @Country, @PostalCode);
    
    INSERT INTO dbo.Phone (PersonID, PhoneNumber, PhoneType)
    VALUES (@PersonID, @PhoneNumber, @PhoneType);
END;
GO

-- 2
CREATE PROCEDURE sp_UpdatePersonAddress
    @PersonID INT,
    @Street NVARCHAR(100),
    @City NVARCHAR(50),
    @Country NVARCHAR(50),
    @PostalCode NVARCHAR(6)
AS
BEGIN
    UPDATE dbo.Address
    SET Street = @Street, City = @City, Country = @Country, PostalCode = @PostalCode
    WHERE PersonID = @PersonID;
END;
GO

-- 3
CREATE PROCEDURE sp_GetPersonDetails
    @PersonID INT
AS
BEGIN
    SELECT p.*, a.Street, a.City, a.Country, a.PostalCode, ph.PhoneNumber, ph.PhoneType
    FROM dbo.Person p
    LEFT JOIN dbo.Address a ON p.PersonID = a.PersonID
    LEFT JOIN dbo.Phone ph ON p.PersonID = ph.PersonID
    WHERE p.PersonID = @PersonID;
END;
GO

EXEC sp_GetPersonDetails 
    @PersonID = 1;  
