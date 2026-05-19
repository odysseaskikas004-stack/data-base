-- Q8: Προσωπικό χωρίς εφημερία σε συγκεκριμένη ημερομηνία/τμήμα 
SELECT at.epwnymo, at.onoma, p.typos_prosopikou
FROM Prosopiko p
JOIN Atoma at ON p.amka = at.AMKA
WHERE p.amka NOT IN (
    SELECT ef.AMKA FROM Efhmeries ef
    JOIN Vardies v ON ef.ID_bardias = v.ID_bardias
    WHERE v.imerominia = '2026-05-20' AND ef.ID_tmhmatos = 1
);