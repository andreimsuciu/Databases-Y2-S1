--Customers who bought from 'Mamma's Oven'
SELECT C.cnp
FROM Customers C
WHERE EXISTS
	( SELECT*
	FROM VendorPayment P, Vendor V
	WHERE P.vendor=V.vid AND V.name='Mammas Oven' AND C.cid=P.customer)

--Vendors that sell hoodies
SELECT V.name
FROM Vendor V
WHERE EXISTS
	(SELECT*
	FROM VendorPayment P, Items I
	WHERE P.vendor=V.vid AND P.item=I.iid AND I.name='hoodie')