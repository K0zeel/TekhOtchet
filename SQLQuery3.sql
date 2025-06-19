BACKUP DATABASE [kokos] TO
DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Backup\kokos.bak' --Путь
WITH NOFORMAT, NOINIT,
NAME = N'kokos-Резервное копирование', --Имя резервной копии
SKIP, NOREWIND, NOUNLOAD, STATS = 10;





--Восстановление из резервной копии
RESTORE DATABASE [kokos] FROM
DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Backup\kokos.bak' --Путь
WITH FILE = 2, NOUNLOAD, STATS = 5;