-- Q11: Ιατροί με >=5 λιγότερες επεμβάσεις από τον πρώτο
SELECT i.amka, COUNT(ip.kwdikos_praxis) AS count_epembaseis
FROM Iatroi i
LEFT JOIN Iatrikas_Praxeis ip ON i.amka = ip.AMKA
GROUP BY i.amka
HAVING count_epembaseis <= (
    SELECT COUNT(kwdikos_praxis) FROM Iatrikas_Praxeis GROUP BY AMKA ORDER BY 1 DESC LIMIT 1
) - 5;
