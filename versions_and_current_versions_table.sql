CREATE TABLE Versions(
	Num INT NOT NULL,
	Do NVARCHAR(1500),
	Undo NVARCHAR(1500),
	PRIMARY KEY(Num)
);

CREATE TABLE CurrentVersion(
	Num INT NOT NULL,
	flagVersionChange BIT,
	PRIMARY KEY(Num)
);

INSERT INTO CurrentVersion(Num, flagVersionChange)
Values(0,0);