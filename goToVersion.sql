Create Or Alter Procedure usp_goToVersion @reqVersion INT AS
BEGIN
DECLARE @versionNum INT;
DECLARE @task nvarchar(1500);

UPDATE CurrentVersion
SET flagVersionChange = 1;

SELECT @versionNum = Num From CurrentVersion;
While @reqVersion != @versionNum
BEGIN
	IF @reqVersion < @versionNum
	BEGIN
		SELECT @task = Undo FROM Versions WHERE Num = @versionNum;
		SET @versionNum -=1;
		PRINT @task;
		EXEC SP_EXECUTESQL @task;
	END
	ELSE
	BEGIN
		SELECT @task = Do FROM Versions WHERE Num = @versionNum;
		SET @versionNum +=1;
		PRINT @task;
		EXEC SP_EXECUTESQL @task;
	END
END

UPDATE CurrentVersion
SET Num=@reqVersion;
UPDATE CurrentVersion
SET flagVersionChange =0;

END
GO


Exec usp_goToVersion @reqVersion = 4;