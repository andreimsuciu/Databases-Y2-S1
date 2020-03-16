CREATE OR ALTER PROCEDURE usp_AddForeignKey AS
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
SET @do= N'ALTER TABLE ' + N' Festival ' + N' ADD CONSTRAINT FK_Festival FOREIGN KEY (' + N'organization' + N') REFERENCES ' + N'Organizer' + N'(' + N'oid' + N')';

DECLARE @undo NVARCHAR(1500);
SET @undo = N'usp_RemoveForeignKeySimple';

IF @flagVersionChange = 0
INSERT INTO Versions(Num,Do,Undo)
VALUES(@versionNum,@do,@undo)

EXEC SP_EXECUTESQL @DO

END
GO

EXEC usp_AddForeignKey;