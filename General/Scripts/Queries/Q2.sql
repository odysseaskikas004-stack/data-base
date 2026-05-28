-- Q2: Ιατροί συγκεκριμένης ειδικότητας και επεμβάσεις 
SELECT 
    i.amka,
    at.epwnymo,
    at.onoma,
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM Efhmeries ef 
            JOIN Vardies v ON ef.id_vardias = v.id_vardias 
            WHERE ef.AMKA = i.amka AND YEAR(v.imerominia) = YEAR(CURDATE())
        ) THEN 'ΝΑΙ' ELSE 'ΟΧΙ' 
    END AS eixe_efhmeria_fetos,
    COUNT(ip.kwdikos_praxis) AS count_kyrios_xeirourgos
FROM Iatroi i
JOIN Atoma at ON i.amka = at.AMKA
LEFT JOIN Iatrikas_Praxeis ip ON i.amka = ip.AMKA 
WHERE i.eidikotita = 'Χειρουργική' -- Παράδειγμα ειδικότητας
GROUP BY i.amka;
