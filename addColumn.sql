CREATE OR ALTER PROCEDURE usp_AddColumn @Table NVARCHAR(100), @Column NVARCHAR(100), @reqType NVARCHAR(100) AS
BEGIN

DECLARE @versionNum INT;
DECLARE @flagVersionChange BIT;

SELECT @flagVersionChange= flagVersionChange FROM CurrentVersion;
SELECT @versionNum = COUNT(*) FROM Versions;
SET @versionNum+=1;

IF @flagVersionChange=0
UPDATE CurrentVersion
SET Num=@versionNum;

DECLARE @do NVARCHAR(1500);
SET @do= N'ALTER TABLE ' + @Table + N' ADD ' + @Column + N' '+ @reqType;

DECLARE @undo NVARCHAR(1500);
SET @undo = N'usp_RemoveColumn @Table = ''' + @Table + N''',@Column=''' + @Column + N'''';

IF @flagVersionChange = 0
INSERT INTO Versions(Num,Do,Undo)
VALUES(@versionNum,@do,@undo)

EXEC SP_EXECUTESQL @DO

END
GO

EXEC usp_AddColumn @Table='Festival', @Column= 'test', @reqType = 'nvarchar(20)';