-- TABLES
SET FOREIGN_KEY_CHECKS = 0;

SOURCE TABLES/Atoma_Table.sql;
SOURCE TABLES/As8eneis.sql;
SOURCE TABLES/Drastikes_Ousies.sql;
SOURCE TABLES/Farmaka.sql;
SOURCE TABLES/ICD-10.sql;
SOURCE TABLES/KEN.sql;
SOURCE TABLES/Xwroi_Table.sql;

SOURCE TABLES/Prosopiko_Table.sql;
SOURCE TABLES/Tmhmata.sql;
SOURCE TABLES/Iatroi_Table.sql;
SOURCE TABLES/Nosileftes_Table.sql;
SOURCE TABLES/Dioikitiko_Prosopiko_Table.sql;

SOURCE TABLES/Klines_Table.sql;
SOURCE TABLES/Vardies.sql;
SOURCE TABLES/Efhmeries.sql;
SOURCE TABLES/Iatrikes_Praxeis.sql;
SOURCE TABLES/Iatroi_kai_Tmhmata.sql;

SOURCE TABLES/Nosileies.sql;
SOURCE TABLES/Iatroi_Nosileias.sql;
SOURCE TABLES/Agwges.sql;
SOURCE TABLES/Boithoi_Praxeon.sql;
SOURCE TABLES/Synthesi_Farmakou.sql;
SOURCE TABLES/Allergies_As8enwn.sql;

SOURCE TABLES/Axiologisi_Iatrwn.sql;
SOURCE TABLES/Axiologisi_Nosileias.sql;
SOURCE TABLES/Kostologisi.sql;
SOURCE TABLES/Eikones.sql;

SET FOREIGN_KEY_CHECKS = 1;

-- TRIGGERS
SOURCE triggers/Periorismoi_Epopteias.sql;
SOURCE triggers/Elegxos_Alergias.sql;
SOURCE triggers/Oria_Vardiwn.sql;
SOURCE triggers/Elegxos_gia_Axiologhsh_Iatrou.sql;
SOURCE triggers/Elegxos_gia_Axiologhsh_Noshleias.sql;


SELECT 'Η εγκατάσταση όλων των πινάκων και των triggers ολοκληρώθηκε!' AS Success_Message;