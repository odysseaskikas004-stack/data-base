-- TABLES
SET FOREIGN_KEY_CHECKS = 0;

SOURCE tables/Atoma_Table.sql;
SOURCE tables/As8eneis.sql;
SOURCE tables/Drastikes_Ousies.sql;
SOURCE tables/Farmaka.sql;
SOURCE tables/ICD-10.sql;
SOURCE tables/KEN.sql;
SOURCE tables/Xwroi_Table.sql;

SOURCE tables/Prosopiko_Table.sql;
SOURCE tables/Tmhmata.sql;
SOURCE tables/Iatroi_Table.sql;
SOURCE tables/Nosileftes_Table.sql;
SOURCE tables/Dioikitiko_Prosopiko_Table.sql;

SOURCE tables/Klines_Table.sql;
SOURCE tables/Vardies.sql;
SOURCE tables/Efhmeries.sql;
SOURCE tables/Iatrikes_Praxeis.sql;
SOURCE tables/Iatroi_kai_Tmhmata.sql;

SOURCE tables/Nosileies.sql;
SOURCE tables/Iatroi_Nosileias.sql;
SOURCE tables/Agwges.sql;
SOURCE tables/Boithoi_Praxeon.sql;
SOURCE tables/Synthesi_Farmakou.sql;
SOURCE tables/Allergies_As8enwn.sql;

SOURCE tables/Axiologisi_Iatrwn.sql;
SOURCE tables/Axiologisi_Nosileias.sql;
SOURCE tables/Kostologisi.sql;
SOURCE tables/Eikones.sql;

SET FOREIGN_KEY_CHECKS = 1;

-- TRIGGERS
SOURCE triggers/Periorismoi_Epopteias.sql;
SOURCE triggers/Elegxos_Alergias.sql;
SOURCE triggers/Oria_Vardiwn.sql;
SOURCE triggers/Elegxos_gia_Axiologhsh_Iatrou.sql;
SOURCE triggers/Elegxos_gia_Axiologhsh_Noshleias.sql;


SELECT 'Η εγκατάσταση όλων των πινάκων και των triggers ολοκληρώθηκε!' AS Success_Message;