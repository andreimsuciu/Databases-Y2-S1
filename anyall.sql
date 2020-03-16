--name the employees who have a bigger salary for another festival than the maximum for gizzfest
SELECT E.name
FROM Employees E,Works_for W
WHERE E.eid=W.employee AND W.salary>ANY
	(SELECT MAX(W2.salary)
	FROM Works_for W2, Festival F
	WHERE W2.festival=F.fid AND F.name='GizzFest')
--name the name the employees who have a bigger salary for another festival than the avg for Sobre Fun
SELECT E.name
FROM Employees E,Works_for W
WHERE E.eid=W.employee AND W.salary>ANY
	(SELECT AVG(W2.salary)
	FROM Works_for W2, Festival F
	WHERE W2.festival=F.fid AND F.name='Sobre Fun')
--name employees with bigger salaries than all employees at PensioneerFest
SELECT DISTINCT E.name
FROM Employees E,Works_for W
WHERE E.eid=W.employee AND W.salary>ALL 
	(SELECT W2.salary
	FROM Works_for W2
	WHERE W2.festival IN
		(SELECT F.fid
		FROM Festival F
		WHERE F.name='PensioneerFest'))
--employees that have bigger salaries than all those who did not work for give festivals
SELECT DISTINCT E.name
FROM Employees E,Works_for W
WHERE E.eid=W.employee AND W.salary>ALL
	(SELECT W2.salary
	FROM Works_for W2
	WHERE W2.festival NOT IN
		(SELECT F.fid
		FROM Festival F
		WHERE F.name='GizzFest' OR F.name='PensioneerFest' or F.name='Sobre Fun'))