-- Tables
SET FOREIGN_KEY_CHECKS = 0;

SOURCE Tables/Atoma_Table.sql;
SOURCE Tables/As8eneis.sql;
SOURCE Tables/Drastikes_Ousies.sql;
SOURCE Tables/Farmaka.sql;
SOURCE Tables/ICD_10.sql;
SOURCE Tables/KEN.sql;
SOURCE Tables/Xwroi_Table.sql;

SOURCE Tables/Prosopiko_Table.sql;
SOURCE Tables/Tmhmata.sql;
SOURCE Tables/Iatroi_Table.sql;
SOURCE Tables/Nosileftes_Table.sql;
SOURCE Tables/Dioikitiko_Prosopiko_Table.sql;

SOURCE Tables/Klines_Table.sql;
SOURCE Tables/Vardies.sql;
SOURCE Tables/Efhmeries.sql;
SOURCE Tables/Iatrikes_Praxeis.sql;
SOURCE Tables/Ergasthriakes_Exetaseis.sql;
SOURCE Tables/Iatroi_kai_Tmhmata.sql;

SOURCE Tables/Nosileies.sql;
SOURCE Tables/Iatroi_Nosileias.sql;
SOURCE Tables/Agwges.sql;
SOURCE Tables/Boithoi_Praxeon.sql;
SOURCE Tables/Synthesi_Farmakou.sql;
SOURCE Tables/Allergies_As8enwn.sql;

SOURCE Tables/Axiologisi_Iatrwn.sql;
SOURCE Tables/Axiologisi_Nosileias.sql;
SOURCE Tables/Kostologisi.sql;
SOURCE Tables/Eikones.sql;

SET FOREIGN_KEY_CHECKS = 1;

-- Triggers
SOURCE Triggers/Periorismoi_Epopteias.sql;
SOURCE Triggers/Elegxos_Alergias.sql;
SOURCE Triggers/Oria_Vardiwn.sql;
SOURCE Triggers/Elegxos_gia_Axiologhsh_Iatrou.sql;
SOURCE Triggers/Elegxos_gia_Axiologhsh_Noshleias.sql;


SELECT 'Η εγκατάσταση όλων των πινάκων και των Triggers ολοκληρώθηκε!' AS Success_Message;