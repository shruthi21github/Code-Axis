CREATE USER IF NOT EXISTS 'codeaxisAppServiceAcc'@'%'
IDENTIFIED BY 'codeaxisFuison#';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON code_axis_db_dev.*
TO 'codeaxisAppServiceAcc'@'%';

FLUSH PRIVILEGES;

SELECT 
   *
FROM mysql.user;

