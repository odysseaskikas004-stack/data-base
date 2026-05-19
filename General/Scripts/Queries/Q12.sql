-- Q12: Απαιτούμενο προσωπικό ανά τμήμα/βάρδια για εβδομάδα 
-- Εξαρτάται από τον πίνακα (Vardies/Efhmeries)
SELECT t.onoma_tmhmatos, v.typos_bardias, p.typos_prosopikou, COUNT(*) AS proswpiko_count
FROM Efhmeries ef
JOIN Vardies v ON ef.ID_bardias = v.ID_bardias
JOIN Tmhmata t ON ef.ID_tmhmatos = t.ID_tmhmatos
JOIN Prosopiko p ON ef.AMKA = p.amka
WHERE v.imerominia BETWEEN '2026-05-18' AND '2026-05-24'
GROUP BY t.ID_tmhmatos, v.typos_bardias, p.typos_prosopikou;
