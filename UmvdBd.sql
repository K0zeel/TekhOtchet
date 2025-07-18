USE [kokos]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCarUMVD]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Создание функции для получения данных о автомобиле из отдела УМВД с названием @DepartmentName
CREATE FUNCTION [dbo].[GetCarUMVD](@DepartmentName NVARCHAR(255))
RETURNS @Result TABLE (
    IdCar INT,
	StateNumber NVARCHAR(50),
	Brand NVARCHAR(50),
	ReleaseYear DATE,
    Model NVARCHAR(100)
)
AS
BEGIN
    INSERT INTO @Result
    SELECT 
        c.IdCar,
		c.StateNumber,
		c.Brand,
		c.ReleaseYear,
        c.Model
    FROM 
        kokos.dbo.Car c
    INNER JOIN 
        kokos.dbo.UMVDDepartment o ON c.IdUMVDDepartment = o.IdUMVDDepartment
    WHERE 
        o.DepartmentName = @DepartmentName

    RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDriverUMVD]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Создание функции для получения данных о водителе из отдела УМВД с названием @DepartmentName
CREATE FUNCTION [dbo].[GetDriverUMVD](@DepartmentName NVARCHAR(255))
RETURNS @Result TABLE (
    IdDriver INT,
    Name NVARCHAR(255),
    BirthDate DATE,
    Rank NVARCHAR(100),
    WorkExperience INT
)
AS
BEGIN
    INSERT INTO @Result
    SELECT 
        d.IdDriver,
        d.Name,
        d.BirthDate,
        d.Rank,
        d.WorkExperience
    FROM 
        kokos.dbo.Driver d
    INNER JOIN 
        kokos.dbo.UMVDDepartment o ON d.IdUMVDDepartment = o.IdUMVDDepartment
    WHERE 
        o.DepartmentName = @DepartmentName

    RETURN
END
GO
/****** Object:  Table [dbo].[Driver]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Driver](
	[IdDriver] [int] NOT NULL,
	[Name] [nvarchar](45) NOT NULL,
	[BirthDate] [date] NULL,
	[Rank] [nvarchar](45) NOT NULL,
	[WorkExperience] [int] NULL,
	[IdUMVDDepartment] [int] NOT NULL,
 CONSTRAINT [PK_Driver] PRIMARY KEY CLUSTERED 
(
	[IdDriver] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NameRankView]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NameRankView]
AS
SELECT Name, Rank
FROM dbo.Driver
GO
/****** Object:  Table [dbo].[Car]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Car](
	[IdCar] [int] NOT NULL,
	[IdUMVDDepartment] [int] NOT NULL,
	[StateNumber] [nvarchar](15) NOT NULL,
	[Brand] [nvarchar](50) NOT NULL,
	[ReleaseYear] [date] NULL,
	[Model] [nvarchar](40) NULL,
 CONSTRAINT [PK_Car] PRIMARY KEY CLUSTERED 
(
	[IdCar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DriverCar]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriverCar](
	[IdDriver] [int] NOT NULL,
	[IdCar] [int] NOT NULL,
 CONSTRAINT [PK_DriverCar] PRIMARY KEY CLUSTERED 
(
	[IdDriver] ASC,
	[IdCar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DriverCarLog]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriverCarLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[IdDriver] [int] NULL,
	[IdCar] [int] NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mechanic]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mechanic](
	[IdMechanic] [int] NOT NULL,
	[IdUMVDDepartment] [int] NOT NULL,
	[Name] [nvarchar](45) NOT NULL,
	[WorkExperience] [int] NULL,
 CONSTRAINT [PK_Mechanic] PRIMARY KEY CLUSTERED 
(
	[IdMechanic] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UMVDDepartment]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UMVDDepartment](
	[IdUMVDDepartment] [int] NOT NULL,
	[DepartmentName] [nvarchar](60) NULL,
	[DepartmentAddress] [nvarchar](60) NULL,
 CONSTRAINT [PK_UMVDDepartment] PRIMARY KEY CLUSTERED 
(
	[IdUMVDDepartment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Work]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Work](
	[IdWork] [int] NOT NULL,
	[IdCar] [int] NOT NULL,
	[IdMechanic] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_Work] PRIMARY KEY CLUSTERED 
(
	[IdWork] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkLog]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[IdWork] [int] NULL,
	[IdCar] [int] NULL,
	[IdMechanic] [int] NULL,
	[Date] [date] NULL,
	[Description] [nvarchar](255) NULL,
	[DeletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Car] ADD  CONSTRAINT [DF_Car_Brand]  DEFAULT (N'УАЗ') FOR [Brand]
GO
ALTER TABLE [dbo].[Car]  WITH CHECK ADD  CONSTRAINT [FK_Car_UMVDDepartment] FOREIGN KEY([IdUMVDDepartment])
REFERENCES [dbo].[UMVDDepartment] ([IdUMVDDepartment])
GO
ALTER TABLE [dbo].[Car] CHECK CONSTRAINT [FK_Car_UMVDDepartment]
GO
ALTER TABLE [dbo].[Driver]  WITH CHECK ADD  CONSTRAINT [FK_Driver_UMVDDepartment] FOREIGN KEY([IdUMVDDepartment])
REFERENCES [dbo].[UMVDDepartment] ([IdUMVDDepartment])
GO
ALTER TABLE [dbo].[Driver] CHECK CONSTRAINT [FK_Driver_UMVDDepartment]
GO
ALTER TABLE [dbo].[DriverCar]  WITH CHECK ADD  CONSTRAINT [FK_DriverCar_Car] FOREIGN KEY([IdCar])
REFERENCES [dbo].[Car] ([IdCar])
GO
ALTER TABLE [dbo].[DriverCar] CHECK CONSTRAINT [FK_DriverCar_Car]
GO
ALTER TABLE [dbo].[DriverCar]  WITH CHECK ADD  CONSTRAINT [FK_DriverCar_Driver] FOREIGN KEY([IdDriver])
REFERENCES [dbo].[Driver] ([IdDriver])
GO
ALTER TABLE [dbo].[DriverCar] CHECK CONSTRAINT [FK_DriverCar_Driver]
GO
ALTER TABLE [dbo].[Mechanic]  WITH CHECK ADD  CONSTRAINT [FK_Mechanic_UMVDDepartment] FOREIGN KEY([IdUMVDDepartment])
REFERENCES [dbo].[UMVDDepartment] ([IdUMVDDepartment])
GO
ALTER TABLE [dbo].[Mechanic] CHECK CONSTRAINT [FK_Mechanic_UMVDDepartment]
GO
ALTER TABLE [dbo].[Work]  WITH CHECK ADD  CONSTRAINT [FK_Work_Car] FOREIGN KEY([IdCar])
REFERENCES [dbo].[Car] ([IdCar])
GO
ALTER TABLE [dbo].[Work] CHECK CONSTRAINT [FK_Work_Car]
GO
ALTER TABLE [dbo].[Work]  WITH CHECK ADD  CONSTRAINT [FK_Work_Mechanic] FOREIGN KEY([IdMechanic])
REFERENCES [dbo].[Mechanic] ([IdMechanic])
GO
ALTER TABLE [dbo].[Work] CHECK CONSTRAINT [FK_Work_Mechanic]
GO
/****** Object:  StoredProcedure [dbo].[AddCar]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCar]
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
GO
/****** Object:  StoredProcedure [dbo].[AddDriver]    Script Date: 19.06.2025 19:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddDriver]
    @Name NVARCHAR(255), --ФИО водителя
    @BirthDate DATE, --Дата рождения
    @Rank NVARCHAR(100), --Звание
    @WorkExperience INT, --Опыт работы
    @IdUMVDDepartment INT --Код отделения
AS
BEGIN
    SET NOCOUNT ON;
	-- Вставка нового водителя с заданными полями
    INSERT INTO kokos.dbo.Driver (Name, BirthDate, Rank, WorkExperience, IdUMVDDepartment)
    VALUES (@Name, @BirthDate, @Rank, @WorkExperience, @IdUMVDDepartment);
END
GO
