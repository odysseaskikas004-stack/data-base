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