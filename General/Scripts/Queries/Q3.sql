-- Q3: Ασθενείς με >3 νοσηλείες στο ίδιο τμήμα 
SELECT 
    at.epwnymo, at.onoma, t.onoma_tmhmatos, 
    COUNT(n.ID_nosileias) AS ari8mos_nosileiwn,
    SUM(k.synoliko_kostos) AS synoliko_kostos
FROM Nosileies n
JOIN Atoma at ON n.AMKA_astheni = at.AMKA
JOIN Tmhmata t ON n.ID_tmhmatos = t.ID_tmhmatos
JOIN Kostologisi k ON n.ID_nosileias = k.ID_nosileias
GROUP BY n.AMKA_astheni, n.ID_tmhmatos
HAVING COUNT(n.ID_nosileias) > 3;
