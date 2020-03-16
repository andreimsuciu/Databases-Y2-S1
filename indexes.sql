IF OBJECT_ID('Tc', 'U') IS NOT NULL
	DROP TABLE Tc
IF OBJECT_ID('Ta', 'U') IS NOT NULL
	DROP TABLE Ta
IF OBJECT_ID('Tb', 'U') IS NOT NULL
	DROP TABLE Tb
GO

CREATE TABLE Ta(
	aid INT PRIMARY KEY IDENTITY(1,1),
	a2 INT UNIQUE,
	a3 varchar(50)
)
CREATE TABLE Tb(
	bid INT PRIMARY KEY IDENTITY(1,1),
	b2 INT,
	b3 varchar(50)
)
CREATE TABLE Tc(
	cid INT PRIMARY KEY IDENTITY(1,1),
	aid INT FOREIGN KEY REFERENCES Ta(aid),
	bid INT FOREIGN KEY REFERENCES Tb(bid)
)
GO
DECLARE @i INT
SET @i =0
WHILE (@i<100)
BEGIN
INSERT INTO Tb(b2,b3)
VALUES(@i,'Bvalue')
INSERT INTO Tb(b2,b3)
VALUES(@i,'Bvalue')
INSERT INTO Tb(b2,b3)
VALUES(@i,'Bvalue')
INSERT INTO Ta(a2,a3)
VALUES(@i,'value')
SET @i=@i+1
END
GO

--clustered index seek
SELECT * FROM Tb WHERE bid = 3
--clustered index scan
SELECT * FROM Tb WHERE b2= 2
--non-clustered index scan
SELECT a2 FROM Ta
--non-clustered index seek
SELECT a2 FROM Ta WHERE a2>50
--key lookup
SELECT aid,a2,a3 FROM Ta WHERE a2=1
GO

--Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan. 
--Create a nonclustered index that can speed up the query. Recheck the query’s execution plan (operators, SELECT’s estimated subtree cost).
IF EXISTS (SELECT * FROM sys.indexes WHERE name= 'ix_b2')
DROP INDEX ix_b2 on Tb

SELECT b2 FROM Tb WHERE b2=5
CREATE NONCLUSTERED INDEX ix_b2 on Tb(b2)
SELECT b2 FROM Tb WHERE b2=5
GO

 --Create a view that joins at least 2 tables. 
 --Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables. 

 INSERT INTO Tc(aid,bid)
 VALUES(1,2)
 INSERT INTO Tc(aid,bid)
 VALUES(2,3)
 INSERT INTO Tc(aid,bid)
 VALUES(3,4)

IF EXISTS (SELECT * FROM sys.indexes WHERE name= 'ix_b2')
DROP INDEX ix_b2 on Tb
GO

---
IF EXISTS (SELECT * FROM sys.indexes WHERE name= 'ix_b22')
DROP INDEX ix_b22 on Tb
GO

CREATE OR ALTER VIEW vJoin
AS
SELECT B.b2
FROM Tb B LEFT JOIN Tc C ON B.bid=C.bid
WHERE B.b2>50
GO
SELECT * FROM vJoin

CREATE NONCLUSTERED INDEX ix_b22 on Tb(b2)
GO

CREATE OR ALTER VIEW vJoin
AS
SELECT B.b2
FROM Tb B LEFT JOIN Tc C ON B.bid=C.bid
WHERE B.b2>50
GO
SELECT * FROM vJoin