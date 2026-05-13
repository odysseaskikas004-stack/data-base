DELIMITER //

CREATE TRIGGER trg_check_nosileia_finished_eval_nos
BEFORE INSERT ON Axiologisi_Nosileias
FOR EACH ROW
BEGIN
    DECLARE v_exit_date DATE;

    -- Ανάκτηση της ημερομηνίας εξόδου από τον πίνακα Nosileies
    SELECT imerominia_exodou INTO v_exit_date 
    FROM Nosileies 
    WHERE ID_nosileias = NEW.ID_nosileias;

    -- Αν η ημερομηνία εξόδου είναι NULL, η νοσηλεία δεν έχει ολοκληρωθεί
    IF v_exit_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Σφάλμα: Η αξιολόγηση νοσηλείας επιτρέπεται μόνο μετά την έκδοση εξιτηρίου.';
    END IF;
END; //

DELIMITER ;