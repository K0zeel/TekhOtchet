USE kokos
GO


--�������� ������� ��� ��������� ������ � �������� �� ������ ���� � ��������� @DepartmentName
--CREATE FUNCTION [dbo].[GetDriverUMVD](@DepartmentName NVARCHAR(255))
--RETURNS @Result TABLE (
--    IdDriver INT,
--    Name NVARCHAR(255),
--    BirthDate DATE,
--    Rank NVARCHAR(100),
--    WorkExperience INT
--)
--AS
--BEGIN
--    INSERT INTO @Result
--    SELECT 
--        d.IdDriver,
--        d.Name,
--        d.BirthDate,
--        d.Rank,
--        d.WorkExperience
--    FROM 
--        kokos.dbo.Driver d
--    INNER JOIN 
--        kokos.dbo.UMVDDepartment o ON d.IdUMVDDepartment = o.IdUMVDDepartment
--    WHERE 
--        o.DepartmentName = @DepartmentName

--    RETURN
--END





CREATE PROCEDURE AddDriver
    @Name NVARCHAR(255), --��� ��������
    @BirthDate DATE, --���� ��������
    @Rank NVARCHAR(100), --������
    @WorkExperience INT, --���� ������
    @IdUMVDDepartment INT --��� ���������
AS
BEGIN
    SET NOCOUNT ON;
	-- ������� ������ �������� � ��������� ������
    INSERT INTO kokos.dbo.Driver (Name, BirthDate, Rank, WorkExperience, IdUMVDDepartment)
    VALUES (@Name, @BirthDate, @Rank, @WorkExperience, @IdUMVDDepartment);
END