-- Q6: Ιστορικό νοσηλειών συγκεκριμένου ασθενή
-- Σημείωση: βαζω EXPLAIN/EXPLAIN ANALYZE στην αναφορά
SELECT 
    n.ID_nosileias, n.imerominia_eisagwgis, n.diagnosis_exodou,
    k.synoliko_kostos,
    (SELECT AVG(synolikh_empeiria) FROM Axiologiseis_Nosileias WHERE ID_nosileias = n.ID_nosileias) AS avg_rating
FROM Nosileies n
JOIN Kostologisi k ON n.ID_nosileias = k.ID_nosileias
WHERE n.AMKA_astheni = '09876543210'; -- Παράδειγμα AMKA
