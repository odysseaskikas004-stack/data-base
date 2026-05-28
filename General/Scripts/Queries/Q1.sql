- - Q1: Συνολικά έσοδα ανά τμήμα, έτος και ΚΕΝ 
SELECT 
    t.onoma_tmhmatos,
    YEAR(n.imerominia_eisagwgis) AS etos,
    k.kwdikos_KEN,
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