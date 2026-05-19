-- Q14: Κατηγορίες ICD-10 με ίδιο αριθμό εισαγωγών σε συνεχή έτη
SELECT diagnosis_eisagwgis, COUNT(*) AS count_cases, YEAR(imerominia_eisagwgis) AS etos
FROM Nosileies
GROUP BY diagnosis_eisagwgis, etos
HAVING count_cases >= 5; -- χρειαζεται περαιτέρω join για σύγκριση ετών