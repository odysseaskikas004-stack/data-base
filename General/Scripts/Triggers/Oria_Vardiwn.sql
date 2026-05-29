DELIMITER //

CREATE TRIGGER trg_check_staff_constraints
BEFORE INSERT ON Efhmeries
FOR EACH ROW
BEGIN
    DECLARE v_typos_prosopikou VARCHAR(50);
    DECLARE v_curr_date DATE;
    DECLARE v_curr_shift VARCHAR(20);
    DECLARE shift_count INT;
    DECLARE night_streak INT;
    DECLARE conflict_exists INT DEFAULT 0;

    -- Ανάκτηση στοιχείων της νέας βάρδιας και του τύπου προσωπικού
    SELECT typos_prosopikou INTO v_typos_prosopikou 
    FROM Prosopiko WHERE amka = NEW.amka_prosopikou;
    
    SELECT hmeromhnia, typos_vardias INTO v_curr_date, v_curr_shift 
    FROM Vardies WHERE id_vardias = NEW.id_vardias;

    -- ΕΛΕΓΧΟΣ ΜΗΝΙΑΙΟΥ ΟΡΙΟΥ 
    SELECT COUNT(*) INTO shift_count
    FROM Efhmeries e
    JOIN Vardies v ON e.id_vardias = v.id_vardias
    WHERE e.amka_prosopikou = NEW.amka_prosopikou
      AND MONTH(v.hmeromhnia) = MONTH(v_curr_date)
      AND YEAR(v.hmeromhnia) = YEAR(v_curr_date);

    IF (v_typos_prosopikou = 'Ιατρός' AND shift_count >= 15) OR 
       (v_typos_prosopikou = 'Νοσηλευτής' AND shift_count >= 20) OR 
       (v_typos_prosopikou = 'Διοικητικό' AND shift_count >= 25) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Σφάλμα: Υπέρβαση μηνιαίου ορίου βαρδιών.';
    END IF;

    IF v_curr_shift = 'Πρωινή' THEN
        SELECT COUNT(*) INTO conflict_exists FROM Efhmeries e
        JOIN Vardies v ON e.id_vardias = v.id_vardias
        WHERE e.amka_prosopikou = NEW.amka_prosopikou 
          AND v.hmeromhnia = DATE_SUB(v_curr_date, INTERVAL 1 DAY) 
          AND v.typos_vardias = 'Νυχτερινή';
    
    ELSEIF v_curr_shift = 'Απογευματινή' THEN
        SELECT COUNT(*) INTO conflict_exists FROM Efhmeries e
        JOIN Vardies v ON e.id_vardias = v.id_vardias
        WHERE e.amka_prosopikou = NEW.amka_prosopikou 
          AND v.hmeromhnia = v_curr_date 
          AND v.typos_vardias = 'Πρωινή';

    ELSEIF v_curr_shift = 'Νυχτερινή' THEN
        SELECT COUNT(*) INTO conflict_exists FROM Efhmeries e
        JOIN Vardies v ON e.id_vardias = v.id_vardias
        WHERE e.amka_prosopikou = NEW.amka_prosopikou 
          AND v.hmeromhnia = v_curr_date 
          AND v.typos_vardias = 'Απογευματινή';
    END IF;

    IF conflict_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Σφάλμα: Δεν μεσολαβεί το απαιτούμενο 8ωρο ανάπαυσης (συνεχόμενες βάρδιες).';
    END IF;

    -- ΕΛΕΓΧΟΣ ΣΥΝΕΧΟΜΕΝΩΝ ΝΥΧΤΕΡΙΝΩΝ (Μax 3)
    IF v_curr_shift = 'Νυχτερινή' THEN
        
        SELECT COUNT(*) INTO night_streak
        FROM Efhmeries e
        JOIN Vardies v ON e.id_vardias = v.id_vardias
        WHERE e.amka_prosopikou = NEW.amka_prosopikou 
          AND v.typos_vardias = 'Νυχτερινή'
          AND v.hmeromhnia IN (DATE_SUB(v_curr_date, INTERVAL 1 DAY), DATE_SUB(v_curr_date, INTERVAL 2 DAY));

        IF night_streak >= 2 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Σφάλμα: Απαγορεύονται πάνω από 3 συνεχόμενες νυχτερινές βάρδιες.';
        END IF;
    END IF;

END //

DELIMITER ;
