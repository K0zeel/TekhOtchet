BACKUP DATABASE [kokos] TO
DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Backup\kokos.bak' --����
WITH NOFORMAT, NOINIT,
NAME = N'kokos-��������� �����������', --��� ��������� �����
SKIP, NOREWIND, NOUNLOAD, STATS = 10;





--�������������� �� ��������� �����
RESTORE DATABASE [kokos] FROM
DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Backup\kokos.bak' --����
WITH FILE = 2, NOUNLOAD, STATS = 5;