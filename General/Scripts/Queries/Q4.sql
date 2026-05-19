-- Q4: Μέσος όρος αξιολογήσεων συγκεκριμένου ιατρού 
-- Σημείωση: βαζω EXPLAIN/EXPLAIN ANALYZE στην αναφορά 
SELECT 
    i.amka,
    AVG(ai.poiothta_iatrikhs_frontidas) AS avg_rating_iatrou,
    AVG(an.synolikh_empeiria) AS avg_genikh_entypwsh
FROM Iatroi i
LEFT JOIN Axiologiseis_Iatrou ai ON i.amka = ai.AMKA_iatrou
LEFT JOIN Axiologiseis_Nosileias an ON ai.ID_nosileias = an.ID_nosileias
WHERE i.amka = '12345678901' -- Παράδειγμα AMKA
GROUP BY i.amka;
