DELIMITER //
CREATE TRIGGER trg_check_monthly_shifts_limit
BEFORE INSERT ON Efhmeries
FOR EACH ROW
BEGIN
    DECLARE v_typos VARCHAR(50);
    DECLARE v_date DATE;
    DECLARE shift_count INT;

    -- Εύρεση του τύπου προσωπικού [cite: 206]
    SELECT typos_prosopikou INTO v_typos 
    FROM Prosopiko 
    WHERE amka = NEW.amka_prosopikou;

    -- Εύρεση του μήνα/έτους της βάρδιας [cite: 210]
    SELECT hmeromhnia INTO v_date 
    FROM Vardies 
    WHERE id_vardias = NEW.id_vardias;

    -- Καταμέτρηση των υπαρχουσών βαρδιών του εργαζομένου για τον ίδιο μήνα
    SELECT COUNT(*) INTO shift_count
    FROM Efhmeries e
    JOIN Vardies v ON e.id_vardias = v.id_vardias
    WHERE e.amka_prosopikou = NEW.amka_prosopikou
      AND MONTH(v.hmeromhnia) = MONTH(v_date)
      AND YEAR(v.hmeromhnia) = YEAR(v_date);

    -- Έλεγχος των ορίων ανάλογα με τον τύπο
    IF v_typos = 'Ιατρός' AND shift_count >= 15 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Υπέρβαση: Μέγιστο 15 βάρδιες/μήνα για Ιατρούς.';
    ELSEIF v_typos = 'Νοσηλευτής' AND shift_count >= 20 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Υπέρβαση: Μέγιστο 20 βάρδιες/μήνα για Νοσηλευτές.';
    ELSEIF v_typos = 'Διοικητικό' AND shift_count >= 25 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Υπέρβαση: Μέγιστο 25 βάρδιες/μήνα για Διοικητικό.';
    END IF;
END; //
DELIMITER ;