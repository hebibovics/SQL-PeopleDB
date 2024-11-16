IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Address' AND schema_id = 1)
DROP TABLE dbo.Address;
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Job' AND schema_id = SCHEMA_ID('dbo'))
DROP TABLE dbo.Job;
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Phone' AND schema_id = SCHEMA_ID('dbo'))
DROP TABLE dbo.Phone;
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Person' AND schema_id = 1)
DROP TABLE dbo.Person;
GO


CREATE TABLE dbo.Person
(
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(30) NOT NULL,
    LastName NVARCHAR(30) NOT NULL,
    DateOfBirth DATE NOT NULL
        CONSTRAINT CHK_DateOfBirth_NotFuture CHECK (DateOfBirth < GETDATE()),
    Gender CHAR(1) NOT NULL
        CONSTRAINT CHK_Gender_ValidValues CHECK (Gender IN ('M', 'F')),
    Email NVARCHAR(100) UNIQUE
);
GO


CREATE TABLE dbo.Job
(
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    PersonID INT NOT NULL
        FOREIGN KEY REFERENCES dbo.Person(PersonID),
    JobTitle NVARCHAR(30) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL
        CONSTRAINT CHK_Salary_Positive CHECK (Salary > 0),
    StartDate DATE NOT NULL,
    EndDate DATE NULL
        CONSTRAINT CHK_EndDate_NotFuture CHECK (EndDate IS NULL OR EndDate <= GETDATE())
);
GO


CREATE TABLE dbo.Address
(
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    PersonID INT NOT NULL
        FOREIGN KEY REFERENCES dbo.Person(PersonID),
    Street NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
	PostalCode NVARCHAR(6) NOT NULL
        CONSTRAINT CHK_PostalCode_Numeric CHECK (PostalCode LIKE '[0-9]%')
);
GO


CREATE SEQUENCE dbo.PhoneIDSequence
    START WITH 100
    INCREMENT BY 1;
GO


CREATE TABLE dbo.Phone
(
    PhoneID INT PRIMARY KEY DEFAULT NEXT VALUE FOR dbo.PhoneIDSequence,
    PersonID INT NOT NULL
        FOREIGN KEY REFERENCES dbo.Person(PersonID),
    PhoneNumber NVARCHAR(15) NOT NULL,
    PhoneType NVARCHAR(10) NOT NULL
        CONSTRAINT CHK_PhoneType_ValidValues CHECK (PhoneType IN ('Mobile', 'Home', 'Work'))
);
GO
