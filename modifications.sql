CREATE TABLE VendorPayment
(	
	pid TINYINT PRIMARY KEY IDENTITY(1,1),
	method CHAR(4) CHECK(method='card' or method='cash'),
	vendor TINYINT NOT NULL FOREIGN KEY REFERENCES Vendor(vid),
	customer TINYINT NOT NULL FOREIGN KEY REFERENCES Customers(cid),
	item TINYINT NOT NULL FOREIGN KEY REFERENCES Items(iid)
)