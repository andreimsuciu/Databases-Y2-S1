--Artists and the stages they play at
SELECT A.name, S.name
FROM Artist A INNER JOIN Plays_at P ON A.aid=P.artist INNER JOIN Stages S ON S.sid=p.stage

--Employees who work at festivals and the possible vendor that he may work at at the respective festival

SELECT F.name, E.name, V.name
FROM Employees E RIGHT JOIN Works_for W on W.employee=E.eid FULL JOIN Festival F on F.fid=W.festival FULL JOIN Sells_at S ON F.fid=S.festival FULL JOIN Vendor V ON V.vid=S.vendor