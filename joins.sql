--all employees and show those who worked at festivals and their salaries
SELECT*
FROM Employees E FULL JOIN Works_for W ON e.eid=W.employee LEFT JOIN Festival F ON F.fid=W.festival

--Festival and their organizer
SELECT*
FROM Festival F INNER JOIN Organizer O ON F.organization=O.oid
