CREATE OR ALTER PROCEDURE usp_modifyColumnType @Table NVARCHAR(100), @Column NVARCHAR(100), @reqType NVARCHAR(100) AS
BEGIN

DECLARE @originalType NVARCHAR(100);
DECLARE @versionNum INT;
DECLARE @flagVersionChange BIT;

SELECT @flagVersionChange= flagVersionChange FROM CurrentVersion;
SELECT @versionNum = COUNT(*) FROM Versions;
SET @versionNum+=1;

IF @flagVersionChange=0
UPDATE CurrentVersion
SET Num=@versionNum;

SELECT @originalType=DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME= @Table AND COLUMN_NAME=@Column
IF @originalType = 'varchar' OR @originalType = 'char' OR @originalType = 'nvarchar' OR @originalType = 'binary'
	set @originalType = @originalType + '(20)';

DECLARE @do NVARCHAR(1500);
SET @do= N'ALTER TABLE ' + @Table + N' ALTER COLUMN ' + @Column + N' '+@reqType;

DECLARE @undo NVARCHAR(1500);
SET @undo = N'usp_modifyColumnType @Table = ''' + @Table + 
			N''',@Column=''' + @Column + N''' ,@reqType = ''' + @originalType + N'''';

IF @flagVersionChange = 0
INSERT INTO Versions(Num,Do,Undo)
VALUES(@versionNum,@do,@undo)

EXEC SP_EXECUTESQL @DO

END
GO

EXEC usp_modifyColumnType @Table = 'Artist', @Column = 'genre', @reqType = 'nvarchar(100)';