
-- ΖΗΤΟΥΜΕΝΑ ΜΕΡΟΣ Β: ΕΡΩΤΗΜΑΤΑ SQL 
-- ============================================================================

-- Q1: Συνολικά έσοδα ανά τμήμα, έτος και ΚΕΝ 
SELECT 
    t.onoma_tmhmatos,
    YEAR(n.imerominia_eisagwgis) AS etos,
    k.kodikos_KEN,
    a.asfalistikos_foreas,
    SUM(k.basiko_kostos) AS esoda_basika,
    SUM(kos.paratasi_nosileias * 100) AS esoda_prosth_xreosis, -- Υπόθεση: 100€/μέρα για υπέρβαση Μεγ.Διαρκ.Νοσιλ.
    SUM(kos.synoliko_kostos) AS synolika_esoda
FROM Nosileies n
JOIN Tmhmata t ON n.ID_tmhmatos = t.ID_tmhmatos
JOIN Kostologisi kos ON n.ID_nosileias = kos.ID_nosileias
JOIN KEN k ON kos.kwdikos_KEN = k.kwdikos_KEN
JOIN As8eneis a ON n.AMKA_astheni = a.amka
GROUP BY t.onoma_tmhmatos, etos, k.kwdikos_KEN, a.asfalistikos_foreas;

-- Q2: Ιατροί συγκεκριμένης ειδικότητας και επεμβάσεις [cite: 81]
SELECT 
    i.amka,
    at.eponymo,
    at.onoma,
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM Efhmeries ef 
            JOIN Vardies v ON ef.ID_bardias = v.ID_bardias 
            WHERE ef.AMKA = i.amka AND YEAR(v.imerominia) = YEAR(CURDATE())
        ) THEN 'ΝΑΙ' ELSE 'ΟΧΙ' 
    END AS eixe_efhmeria_fetos,
    COUNT(ip.kwdikos_praxis) AS count_kyrios_xeirourgos
FROM Iatroi i
JOIN Atoma at ON i.amka = at.AMKA
LEFT JOIN Iatrikes_Praxeis ip ON i.amka = ip.AMKA 
WHERE i.eidikotita = 'Χειρουργική' -- Παράδειγμα ειδικότητας
GROUP BY i.amka;

-- Q3: Ασθενείς με >3 νοσηλείες στο ίδιο τμήμα [cite: 82]
SELECT 
    at.eponymo, at.onoma, t.onoma_tmhmatos, 
    COUNT(n.ID_nosileias) AS ari8mos_nosileiwn,
    SUM(k.synoliko_kostos) AS synoliko_kostos
FROM Nosileies n
JOIN Atoma at ON n.AMKA_astheni = at.AMKA
JOIN Tmhmata t ON n.ID_tmhmatos = t.ID_tmhmatos
JOIN Kostologisi k ON n.ID_nosileias = k.ID_nosileias
GROUP BY n.AMKA_astheni, n.ID_tmhmatos
HAVING COUNT(n.ID_nosileias) > 3;

-- Q4: Μέσος όρος αξιολογήσεων συγκεκριμένου ιατρού 
-- Σημείωση: βαζω EXPLAIN/EXPLAIN ANALYZE στην αναφορά 
SELECT 
    i.amka,
    AVG(ai.poiothta_iatrikhs_frontidas) AS avg_rating_iatrou,
    AVG(an.synolikh_empeiria) AS avg_genikh_entypwsh
FROM Iatroi i
LEFT JOIN Axiologisi_Iatrwn ai ON i.amka = ai.AMKA_iatrou
LEFT JOIN Axiologisi_Nosileias an ON ai.ID_nosileias = an.ID_nosileias
WHERE i.amka = '12345678901' -- Παράδειγμα AMKA
GROUP BY i.amka;

-- Q5: Νέοι ιατροί (<35 ετών) με τις περισσότερες επεμβάσεις
SELECT 
    at.eponymo, at.onoma, at.hlikia,
    COUNT(ip.kwdikos_praxis) AS synolo_epembasewn
FROM Iatroi i
JOIN Atoma at ON i.amka = at.AMKA
JOIN Iatrikes_Praxeis ip ON i.amka = ip.AMKA
WHERE at.hlikia < 35 AND ip.katigoria = 'χειρουργική'
GROUP BY i.amka
ORDER BY synolo_epembasewn DESC;

-- Q6: Ιστορικό νοσηλειών συγκεκριμένου ασθενή
-- Σημείωση: βαζω EXPLAIN/EXPLAIN ANALYZE στην αναφορά
SELECT 
    n.ID_nosileias, n.imerominia_eisagwgis, n.diagnosis_exodou,
    k.synoliko_kostos,
    (SELECT AVG(synolikh_empeiria) FROM Axiologisi_Nosileias WHERE ID_nosileias = n.ID_nosileias) AS avg_rating
FROM Nosileies n
JOIN Kostologisi k ON n.ID_nosileias = k.ID_nosileias
WHERE n.AMKA_astheni = '09876543210'; -- Παράδειγμα AMKA

-- Q7: Αλλεργίες ανά δραστική ουσία και περιεχόμενα φάρμακα
SELECT 
    do.onoma_ousias,
    COUNT(DISTINCT aa.amka) AS ari8mos_allergikwn,
    COUNT(DISTINCT sf.kodikos_farmakou) AS ari8mos_farmakwn
FROM Drastikes_Ousies do
LEFT JOIN Allergies_As8enwn aa ON do.ID_ousias = aa.id_ousias
LEFT JOIN Synthesi_Farmakou sf ON do.ID_ousias = sf.ID_ousias
GROUP BY do.ID_ousias
ORDER BY ari8mos_allergikwn DESC;

-- Q8: Προσωπικό χωρίς εφημερία σε συγκεκριμένη ημερομηνία/τμήμα 
SELECT at.eponymo, at.onoma, p.typos_prosopikou
FROM Prosopiko p
JOIN Atoma at ON p.amka = at.AMKA
WHERE p.amka NOT IN (
    SELECT ef.AMKA FROM Efhmeries ef
    JOIN Vardies v ON ef.ID_bardias = v.ID_bardias
    WHERE v.imerominia = '2026-05-20' AND ef.ID_tmhmatos = 1
);

-- Q9: Ασθενείς με ίδιο αριθμό ημερών νοσηλείας (>15 ημέρες/έτος) 
SELECT DATEDIFF(imerominia_exodou, imerominia_eisagwgis) AS meres, GROUP_CONCAT(AMKA_astheni)
FROM Nosileies
WHERE YEAR(imerominia_eisagwgis) = 2025
GROUP BY meres
HAVING meres > 15 AND COUNT(*) > 1;

-- Q10: Top-3 ζεύγη δραστικών ουσιών σε ταυτόχρονη συνταγογράφηση 
FROM Syntagografisi s1
JOIN Syntagografisi s2 ON s1.ID_nosileias = s2.ID_nosileias AND s1.kwdikos_farmakou < s2.kwdikos_farmakou
JOIN Synthesi_Farmakou sf1 ON s1.kwdikos_farmakou = sf1.kwdikos_farmakou
JOIN Synthesi_Farmakou sf2 ON s2.kwdikos_farmakou = sf2.kwdikos_farmakou
JOIN Drastikes_Ousies do1 ON sf1.ID_ousias = do1.ID_ousias
JOIN Drastikes_Ousies do2 ON sf2.ID_ousias = do2.ID_ousias
GROUP BY do1.ID_ousias, do2.ID_ousias
ORDER BY syxnothta DESC
LIMIT 3;

-- Q11: Ιατροί με >=5 λιγότερες επεμβάσεις από τον πρώτο
SELECT i.amka, COUNT(ip.kwdikos_praxis) AS count_epembaseis
FROM Iatroi i
LEFT JOIN Iatrikas_Praxeis ip ON i.amka = ip.AMKA
GROUP BY i.amka
HAVING count_epembaseis <= (
    SELECT COUNT(kwdikos_praxis) FROM Iatrikas_Praxeis GROUP BY AMKA ORDER BY 1 DESC LIMIT 1
) - 5;

-- Q12: Απαιτούμενο προσωπικό ανά τμήμα/βάρδια για εβδομάδα 
-- Εξαρτάται από τον πίνακα (Vardies/Efhmeries)
SELECT t.onoma_tmhmatos, v.typos_vardias, p.typos_prosopikou, COUNT(*) AS proswpiko_count
FROM Efhmeries ef
JOIN Vardies v ON ef.ID_bardias = v.ID_bardias
JOIN Tmhmata t ON ef.ID_tmhmatos = t.ID_tmhmatos
JOIN Prosopiko p ON ef.AMKA = p.amka
WHERE v.imerominia BETWEEN '2026-05-18' AND '2026-05-24'
GROUP BY t.ID_tmhmatos, v.typos_vardias, p.typos_prosopikou;

-- Q13: Ιεραρχία εποπτείας ιατρού 
WITH RECURSIVE SupervisionHierarchy AS (
    SELECT amka, amka_epopti, 1 AS level
    FROM Iatroi
    WHERE amka = '12345678901' -- ΑΜΚΑ εκκίνησης
    UNION ALL
    SELECT i.amka, i.amka_epopti, sh.level + 1
    FROM Iatroi i
    INNER JOIN SupervisionHierarchy sh ON i.amka = sh.amka_epopti
)
SELECT * FROM SupervisionHierarchy;

-- Q14: Κατηγορίες ICD-10 με ίδιο αριθμό εισαγωγών σε συνεχή έτη
SELECT diagnosis_eisagwgis, COUNT(*) AS count_cases, YEAR(imerominia_eisagwgis) AS etos
FROM Nosileies
GROUP BY diagnosis_eisagwgis, etos
HAVING count_cases >= 5; -- χρειαζεται περαιτέρω join για σύγκριση ετών

-- Q15: Κατανομή επειγόντων και χρόνος αναμονής
SELECT 
    epipedo_epeigontos,
    COUNT(*) AS synolo_peristatikwn,
    AVG(TIMESTAMPDIFF(MINUTE, imerominia_afixis, imerominia_exetashs)) AS avg_wait_minutes,
    (SUM(CASE WHEN paraphmpth_gia_nosileia = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS pososto_nosileias
FROM Epeigonta
GROUP BY epipedo_epeigontos;
-- C:\Users\odyss\OneDrive\Έγγραφα\GitHub\data-base\General\Scripts\Queries\queries.sql