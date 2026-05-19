-- Q13: Ιεραρχία εποπτείας ιατρού 
WITH RECURSIVE SupervisionHierarchy AS (
    SELECT amka, AMK_epopti, 1 AS level
    FROM Iatroi
    WHERE amka = '12345678901' -- ΑΜΚΑ εκκίνησης
    UNION ALL
    SELECT i.amka, i.AMK_epopti, sh.level + 1
    FROM Iatroi i
    INNER JOIN SupervisionHierarchy sh ON i.amka = sh.AMK_epopti
)
SELECT * FROM SupervisionHierarchy;