--Biggest salary for employees
SELECT MAX(salary)
FROM
	(SELECT W.salary
	FROM Works_for W, Employees E
	WHERE E.eid=W.employee)s

--Employees with salary over 300 and the festival they work at
SELECT E.name, F.name
FROM Employees E INNER JOIN
	(SELECT *
	FROM Works_for W
	WHERE salary>300)s
	ON E.eid=s.employee INNER JOIN Festival F on F.fid=S.festival