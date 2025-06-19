--�������� ������� UMVDDepartment � ������ � ��������� ������
CREATE TABLE [dbo].[UMVDDepartment](
	   [IdUMVDDepartment] [int] IDENTITY(1,1) NOT NULL,
       [DepartmentName] [nvarchar](60) NULL,
       [DepartmentAddress] [nvarchar](60) NULL,
	CONSTRAINT [PK_UMVDDepartment] PRIMARY KEY CLUSTERED ([IdUMVDDepartment] ASC))

	--�������� ���������� ����������� �� ������� StateNumber � ������� Car
--ALTER TABLE Car
--ADD CONSTRAINT [UQ_Car] UNIQUE ([StateNumber])
GO


--������� ��������������� ������� ���� �����������
CREATE VIEW CarNumberView
AS
SELECT IdCar, StateNumber
FROM dbo.Car



--������� ��� � ������ ���� ���������
--CREATE VIEW NameRankView
--AS
--SELECT Name, Rank
--FROM dbo.Driver