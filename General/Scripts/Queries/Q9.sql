-- Q9: Ασθενείς με ίδιο αριθμό ημερών νοσηλείας (>15 ημέρες/έτος) 
SELECT DATEDIFF(imerominia_exodou, imerominia_eisagwgis) AS meres, GROUP_CONCAT(AMKA_astheni)
FROM Nosileies
WHERE YEAR(imerominia_eisagwgis) = 2025
GROUP BY meres
HAVING meres > 15 AND COUNT(*) > 1;
