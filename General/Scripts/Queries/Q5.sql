-- Q5: Νέοι ιατροί (<35 ετών) με τις περισσότερες επεμβάσεις
SELECT 
    at.epwnymo, at.onoma, at.hlikia,
    COUNT(ip.kwdikos_praxis) AS synolo_epembasewn
FROM Iatroi i
JOIN Atoma at ON i.amka = at.AMKA
JOIN Iatrikas_Praxeis ip ON i.amka = ip.AMKA
WHERE at.hlikia < 35 AND ip.katigoria = 'χειρουργική'
GROUP BY i.amka
ORDER BY synolo_epembasewn DESC;
