-- Q15: Κατανομή περιστατικών triage και χρόνος αναμονής
SELECT 
    epipedo_epeigontos,
    COUNT(*) AS synolo_peristatikwn,
    AVG(TIMESTAMPDIFF(MINUTE, imerominia_afixis, imerominia_exetashs)) AS avg_wait_minutes,
    (SUM(CASE WHEN paraphmpth_gia_nosileia = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS pososto_nosileias
FROM Triage
GROUP BY epipedo_epeigontos;