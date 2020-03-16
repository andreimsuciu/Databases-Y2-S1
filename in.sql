--Artists who have played at Shout Stage
SELECT TOP 3 A.name
FROM Artist A
WHERE A.aid IN
	(SELECT P.artist
	FROM Plays_at P, Stages S
	WHERE P.stage=S.sid AND S.name='Shout')
ORDER BY A.name

--Customers who bought alcohol
SELECT TOP 3 C.cnp
FROM Customers C
WHERE C.cid IN
	(SELECT P.customer
	FROM VendorPayment P
	WHERE P.item IN
		(SELECT I.iid
		FROM Items I
		WHERE I.name='wine' OR I.name='beer'))
ORDER BY C.cnp