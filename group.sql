--minimum salary for each number of hours played
SELECT P.hours,MIN(P.salary) as Salary
FROM Plays_at P
GROUP BY P.hours

--The minimum salary of an artist for each number of hours they share with at least 2 other artists
SELECT P.hours,MIN(P.salary) as Salary
FROM Plays_at P
WHERE P.salary>2000
GROUP BY P.hours
HAVING 1<
	(SELECT COUNT(*)
	FROM Plays_at P2
	WHERE P2.hours=P.hours)

--Highest Price for items over 18 and items with no restriction
SELECT I.adult,MAX(I.PRICE) AS Price
FROM Items I
WHERE I.price>3
GROUP BY I.adult
HAVING COUNT(*)>3

--Min salary at festivals which have at least 2 employees with a higher salary than 100

SELECT w.festival,Min(W.salary) as Salary
FROM Works_for W
WHERE w.salary>100
GROUP BY w.festival
HAVING 1<
	(SELECT COUNT(*)
	FROM Works_for W2
	WHERE W2.festival=W.festival)