DELIMITER //

CREATE TRIGGER trg_check_nosileia_finished_eval_docs
BEFORE INSERT ON Axiologisi_Iatrwn
FOR EACH ROW
BEGIN
	IF @skip_triggers IS NULL THEN
    DECLARE v_exit_date DATE;
	DECLARE v_participation_count INT;

    SELECT imerominia_exodou INTO v_exit_date 
    FROM Nosileies 
    WHERE ID_nosileias = NEW.ID_nosileias;

    IF v_exit_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Σφάλμα: Η αξιολόγηση ιατρού επιτρέπεται μόνο μετά την ολοκλήρωση της νοσηλείας.';
    END IF;
    
    -- 2. Έλεγχος αν ο γιατρός συμμετείχε όντως στη νοσηλεία
    SELECT COUNT(*) INTO v_participation_count
    FROM Iatrikes_Praxeis 
    WHERE ID_nosileias = NEW.ID_nosileias AND AMKA = NEW.AMKA_iatrou;

    -- (Προαιρετικά) Έλεγχος και στις συνταγογραφήσεις αν δεν βρέθηκε στις πράξεις
    IF v_participation_count = 0 THEN
        SELECT COUNT(*) INTO v_participation_count
        FROM Agwges 
        WHERE ID_nosileias = NEW.ID_nosileias AND AMKA_iatrou = NEW.AMKA_iatrou;
    END IF;

    IF v_participation_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Σφάλμα: Μπορείτε να αξιολογήσετε μόνο γιατρούς που συμμετείχαν στη φροντίδα σας.';
    END IF;
END; //

DELIMITER ;