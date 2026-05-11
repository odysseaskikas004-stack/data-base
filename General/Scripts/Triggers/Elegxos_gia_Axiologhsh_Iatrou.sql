DELIMITER //

CREATE TRIGGER trg_check_nosileia_finished_eval_docs
BEFORE INSERT ON Axiologisi_Iatrwn
FOR EACH ROW
BEGIN
    DECLARE v_exit_date DATE;

    SELECT imerominia_exodou INTO v_exit_date 
    FROM Nosileies 
    WHERE ID_nosileias = NEW.ID_nosileias;

    IF v_exit_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Σφάλμα: Η αξιολόγηση ιατρού επιτρέπεται μόνο μετά την ολοκλήρωση της νοσηλείας.';
    END IF;
END; //

DELIMITER ;