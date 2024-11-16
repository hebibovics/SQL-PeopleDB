USE PeopleDB;
GO

INSERT INTO dbo.Person (FirstName, LastName, DateOfBirth, Gender, Email)
VALUES 
('John', 'Johnson', '1985-06-15', 'M', 'john@example.com'),
('Jane', 'Jennifer', '1990-08-25', 'F', 'jane.j@example.com');
GO

INSERT INTO dbo.Job (PersonID, JobTitle, Salary, StartDate, EndDate)
VALUES
(1, 'Software Developer', 75000.00, '2010-01-01', '2020-01-01'),
(1, 'Team Lead', 95000.00, '2020-01-02', NULL),
(2, 'HR Specialist', 65000.00, '2015-05-01', NULL);
GO

INSERT INTO dbo.Address (PersonID, Street, City, Country, PostalCode)
VALUES
(1, '123 Main Street', 'Rome', 'Italy', '10001'),
(2, '456 New Street', 'Paris', 'France', '94105');
GO

INSERT INTO dbo.Phone (PersonID, PhoneNumber, PhoneType)
VALUES
(1, '+123456789', 'Mobile'),
(2, '+987654321', 'Work'),
(2, '+112233445', 'Home');
GO
