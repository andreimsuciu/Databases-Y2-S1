--Festivals which are held in 2019 or have an emplyoyee with salary more than 100
SELECT F.fid
FROM Festival F
WHERE YEAR(F.startDate)=2019 AND YEAR(F.endDate)=2019
INTERSECT 
SELECT W.festival
FROM Works_for W
WHERE salary>100
ORDER BY F.fid DESC

--Vendors who sell at Festivals with ids 1 and 10
SELECT V.name
FROM Vendor V INNER JOIN Sells_at S on V.vid=S.vendor
WHERE S.festival=1 AND V.name IN
	(SELECT V2.name
	FROM Vendor V2 INNER JOIN Sells_at S2 on V2.vid=S2.vendor
	WHERE S2.festival=10)
ORDER BY V.name