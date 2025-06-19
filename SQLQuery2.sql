USE kokos

CREATE LOGIN admn WITH PASSWORD=N'1234'
GO --Создание имени для входа с паролем
CREATE USER firstuser FOR LOGIN admn
GO --Создание пользователя для имени для входа
EXEC sp_addrolemember 'db_datareader', 'firstuser'
GO --Выдача прав на чтение данных пользователю
EXEC sp_addrolemember 'db_datawriter', 'firstuser'
GO --Выдача прав на запись данных пользователю