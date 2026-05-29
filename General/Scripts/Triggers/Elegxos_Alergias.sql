DELIMITER //
CREATE TRIGGER trg_prevent_allergic_prescription
BEFORE INSERT ON Agwges
FOR EACH ROW
BEGIN
	IF @skip_triggers IS NULL THEN
    IF EXISTS (
        -- Ψάχνουμε αν υπάρχει κοινή ουσία μεταξύ του φαρμάκου και των αλλεργιών του ασθενή
        SELECT 1 
        FROM Synthesi_Farmakou sf
        JOIN Allergies_As8enwn aa ON sf.ID_ousias = aa.id_ousias
        WHERE sf.kodikos_farmakou = NEW.kwdikos_farmakou
          AND aa.amka = NEW.amka_as8eni
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Απαγόρευση: Ο ασθενής είναι αλλεργικός σε δραστική ουσία του φαρμάκου.';
    END IF;
END; //
DELIMITER ;