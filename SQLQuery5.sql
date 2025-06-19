




CREATE TRIGGER TR_WorkLogging
ON Work
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
	--������� �������� ������ � ������� WorkLog
    INSERT INTO kokos.dbo.WorkLog (IdWork, IdCar, IdMechanic, Date, Description, DeletedAt)
    SELECT 
        d.IdWork,
        d.IdCar,
        d.IdMechanic,
        d.Date,
        d.Description,
        GETDATE() -- ����� ��������
    FROM deleted d;
END

--CREATE TABLE WorkLog (
--    LogId INT IDENTITY(1,1) PRIMARY KEY,
--    IdWork INT,
--    IdCar INT,
--    IdMechanic INT,
--    Date DATE,
--    Description NVARCHAR(255),
--    DeletedAt DATETIME -- ����� ��������
--);

--CREATE TABLE DriverCarLog (
--    LogId INT IDENTITY(1,1) PRIMARY KEY,
--    IdDriver INT,
--    IdCar INT,
--    DeletedAt DATETIME
--);

CREATE TRIGGER TR_DriverCarLogging
ON DriverCar
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
	--������� �������� ������ � ������� DriverCarLog
    INSERT INTO kokos.dbo.DriverCarLog (IdDriver, IdCar, DeletedAt)
    SELECT 
        d.IdDriver,
        d.IdCar,
        GETDATE() -- ����� ��������
    FROM deleted d;
END