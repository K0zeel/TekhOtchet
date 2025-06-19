USE kokos
GO


--Создание функции для получения данных о автомобиле из отдела УМВД с названием @DepartmentName
--CREATE FUNCTION GetCarUMVD(@DepartmentName NVARCHAR(255))
--RETURNS @Result TABLE (
--    IdCar INT,
--	StateNumber NVARCHAR(50),
--	Brand NVARCHAR(50),
--	ReleaseYear DATE,
--    Model NVARCHAR(100)
--)
--AS
--BEGIN
--    INSERT INTO @Result
--    SELECT 
--        c.IdCar,
--		c.StateNumber,
--		c.Brand,
--		c.ReleaseYear,
--        c.Model
--    FROM 
--        kokos.dbo.Car c
--    INNER JOIN 
--        kokos.dbo.UMVDDepartment o ON c.IdUMVDDepartment = o.IdUMVDDepartment
--    WHERE 
--        o.DepartmentName = @DepartmentName

--    RETURN
--END


CREATE PROCEDURE AddCar
    @IdUMVDDepartment INT, --Код отделения
    @StateNumber NVARCHAR(50), --Государственный номер автомобиля
    @Brand NVARCHAR(50), --Марка автомоблия
    @ReleaseYear DATE, --Год выпуска
    @Model NVARCHAR(100) --Название модели
AS
BEGIN
    SET NOCOUNT ON;
	-- Вставка нового автомобиля с заданными полями
    INSERT INTO kokos.dbo.Car(IdUMVDDepartment, StateNumber, Brand, ReleaseYear, Model)
    VALUES (@IdUMVDDepartment, @StateNumber, @Brand, @ReleaseYear, @Model);
END