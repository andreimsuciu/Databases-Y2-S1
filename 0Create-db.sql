CREATE TABLE Organizer
(
	oid TINYINT PRIMARY KEY IDENTITY(1,1),
	name CHAR(35) UNIQUE,
	location CHAR(15),
	manager CHAR(30)
)

CREATE TABLE Festival
(
	fid TINYINT PRIMARY KEY IDENTITY(1,1),
	musicGenre CHAR(15),
	name CHAR(35) UNIQUE,
	startDate DATE,
	endDate DATE,
	organization TINYINT NOT NULL FOREIGN KEY REFERENCES Organizer(oid),
	CONSTRAINT endDate
		CHECK (endDate>startDate),
)

CREATE TABLE Employees
(
	eid TINYINT PRIMARY KEY IDENTITY(1,1),
	name CHAR(35),
	cnp CHAR(13) UNIQUE,
	salary INT
)

CREATE TABLE Works_for
(
	employee TINYINT NOT NULL FOREIGN KEY REFERENCES Employees(eid),
	festival TINYINT NOT NULL FOREIGN KEY REFERENCES Festival(fid),
	salary INT,
	PRIMARY KEY(employee,festival)
)

CREATE TABLE Stages
(
	sid TINYINT PRIMARY KEY IDENTITY(1,1),
	name CHAR(35),
	capacity INT,
	festival TINYINT NOT NULL FOREIGN KEY REFERENCES Festival(fid)
)

CREATE TABLE Artist
(
	aid TINYINT PRIMARY KEY IDENTITY(1,1),
	name CHAR(50) UNIQUE,
	contact CHAR(30) UNIQUE,
	genre CHAR(30)
)

CREATE TABLE Plays_at
(
	artist TINYINT NOT NULL FOREIGN KEY REFERENCES Artist(aid),
	stage TINYINT NOT NULL FOREIGN KEY REFERENCES Stages(sid),
	salary INT,
	hours TINYINT,
	PRIMARY KEY(artist,stage)
)

CREATE TABLE Vendor
(
	vid TINYINT PRIMARY KEY IDENTITY(1,1),
	type CHAR(15) CHECK (type='bar' or type='food' or type='cigaretts' or type='merch'),
	name CHAR(30)
)

CREATE TABLE Sells_at
(
	festival TINYINT NOT NULL FOREIGN KEY REFERENCES Festival(fid),
	vendor TINYINT NOT NULL FOREIGN KEY REFERENCES Vendor(vid),
	percentageTaken INT,
	PRIMARY KEY(festival,vendor)
)

CREATE TABLE Items
(
	iid TINYINT PRIMARY KEY IDENTITY(1,1),
	price INT,
	name CHAR(30) UNIQUE,
	adult CHAR(3) CHECK(adult='yes'or adult='no'),
)

CREATE TABLE Customers
(
	cid TINYINT PRIMARY KEY IDENTITY(1,1),
	dob DATE,
	cnp CHAR(13) UNIQUE
)

CREATE TABLE VendorPayment
(
	method CHAR(4) CHECK(method='card' or method='cash'),
	dateAndTime datetime,
	amount INT,
	vendor TINYINT NOT NULL UNIQUE FOREIGN KEY REFERENCES Vendor(vid),
	customer TINYINT NOT NULL UNIQUE FOREIGN KEY REFERENCES Customers(cid),
	item TINYINT NOT NULL UNIQUE FOREIGN KEY REFERENCES Items(iid),
	PRIMARY KEY(dateAndTime,vendor,customer,item)
)