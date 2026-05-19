-- Q7: Αλλεργίες ανά δραστική ουσία και περιεχόμενα φάρμακα
SELECT 
    do.onoma_ousias,
    COUNT(DISTINCT aa.amka) AS ari8mos_allergikwn,
    COUNT(DISTINCT sf.kwdikos_farmakou) AS ari8mos_farmakwn
FROM Drastikes_Ousies do
LEFT JOIN Allergies_As8enwn aa ON do.ID_ousias = aa.id_ousias
LEFT JOIN Synthesi_Farmakou sf ON do.ID_ousias = sf.ID_ousias
GROUP BY do.ID_ousias
ORDER BY ari8mos_allergikwn DESC;