--Find TOP 3 cusotmers who have bought beer or wine(alcohol)
SELECT DISTINCT TOP 3 C.cid
FROM Customers C, Items I, VendorPayment P
WHERE C.cid=P.customer AND I.iid=P.item AND (I.name='beer' OR I.name='wine')

--Find all artist who have a salary>3000 or genre is Populare
SELECT DISTINCT A.aid
FROM Artist A
WHERE A.genre='Populare'
UNION
SELECT DISTINCT P.artist
FROM Plays_at P
WHERE P.salary>3000

