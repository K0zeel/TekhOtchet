USE kokos

CREATE LOGIN admn WITH PASSWORD=N'1234'
GO --�������� ����� ��� ����� � �������
CREATE USER firstuser FOR LOGIN admn
GO --�������� ������������ ��� ����� ��� �����
EXEC sp_addrolemember 'db_datareader', 'firstuser'
GO --������ ���� �� ������ ������ ������������
EXEC sp_addrolemember 'db_datawriter', 'firstuser'
GO --������ ���� �� ������ ������ ������������