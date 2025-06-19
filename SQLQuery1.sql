--Создание таблицы UMVDDepartment с полями и первичным ключом
CREATE TABLE [dbo].[UMVDDepartment](
	   [IdUMVDDepartment] [int] IDENTITY(1,1) NOT NULL,
       [DepartmentName] [nvarchar](60) NULL,
       [DepartmentAddress] [nvarchar](60) NULL,
	CONSTRAINT [PK_UMVDDepartment] PRIMARY KEY CLUSTERED ([IdUMVDDepartment] ASC))

	--Создание уникальных ограничений на столбец StateNumber в таблице Car
--ALTER TABLE Car
--ADD CONSTRAINT [UQ_Car] UNIQUE ([StateNumber])
GO


--Выборка государственных номеров всех автомобилей
CREATE VIEW CarNumberView
AS
SELECT IdCar, StateNumber
FROM dbo.Car



--Выборка имён и званий всех водителей
--CREATE VIEW NameRankView
--AS
--SELECT Name, Rank
--FROM dbo.Driver