-- TRIGGER 1
use PeopleDB
CREATE TRIGGER trg_PreventPersonDelete
ON dbo.Person
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM deleted d
        JOIN dbo.Job j ON d.PersonID = j.PersonID
        WHERE j.EndDate IS NULL
    )
    BEGIN
        RAISERROR ('You cannot delete the person with active job!', 16, 1);
        ROLLBACK;
        RETURN;
    END
    DELETE FROM dbo.Person WHERE PersonID IN (SELECT PersonID FROM deleted);
END;
GO

-- TRIGGER 2
CREATE TABLE dbo.PersonAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    PersonID INT,
    FirstName NVARCHAR(30),
    LastName NVARCHAR(30),
    DeletedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER trg_PersonDeleteAudit
ON dbo.Person
AFTER DELETE
AS
BEGIN
    INSERT INTO dbo.PersonAudit (PersonID, FirstName, LastName)
    SELECT PersonID, FirstName, LastName FROM deleted;
END;
GO

-- TRIGGER 3
CREATE TRIGGER trg_UpdateJobEndDate
ON dbo.Job
AFTER UPDATE
AS
BEGIN
    IF UPDATE(EndDate)
    BEGIN
        UPDATE j
        SET j.EndDate = GETDATE()
        FROM dbo.Job j
        JOIN inserted i ON j.JobID = i.JobID
        WHERE i.EndDate IS NOT NULL;
    END
END;
GO

INSERT INTO dbo.Job (PersonID, JobTitle, Salary, StartDate, EndDate)
VALUES (1, 'CTO', 120000.00, '2025-01-01', NULL);


SELECT * FROM dbo.Job WHERE PersonID = 1;

DELETE FROM dbo.Person WHERE PersonID = 1;




