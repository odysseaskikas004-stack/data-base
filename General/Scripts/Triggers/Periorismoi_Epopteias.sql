DELIMITER //

-- 1. TRIGGER ΓΙΑ INSERT
CREATE TRIGGER trg_iatroi_supervision_insert
BEFORE INSERT ON Iatroi
FOR EACH ROW
BEGIN
    -- Α απαγόρευση αυτο-εποπτείας
    IF NEW.amka_epopti = NEW.amka THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Σφάλμα: Ένας ιατρός δεν μπορεί να εποπτεύει τον εαυτό του.';
    END IF;

    -- Οι ειδικευόμενοι έχουν υποχρεωτικά επόπτη
    IF NEW.va8mida = 'Ειδικευόμενος' AND NEW.amka_epopti IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Σφάλμα: Οι ειδικευόμενοι πρέπει υποχρεωτικά να έχουν επόπτη.';
    END IF;

    -- Οι Διευθυντές δεν έχουν επόπτη
    IF NEW.va8mida = 'Διευθυντής' AND NEW.amka_epopti IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Σφάλμα: Οι Διευθυντές δεν επιτρέπεται να έχουν επόπτη.';
    END IF;

    -- Έλεγχος κυκλικής αλυσίδας 
    IF NEW.amka_epopti IS NOT NULL THEN
        IF EXISTS (SELECT 1 FROM Iatroi WHERE amka = NEW.amka_epopti AND amka_epopti = NEW.amka) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Σφάλμα: Απαγορεύεται η άμεση κυκλική αλυσίδα εποπτείας.';
        END IF;
    END IF;
END; //


-- 2. TRIGGER ΓΙΑ UPDATE
CREATE TRIGGER trg_iatroi_supervision_update
BEFORE UPDATE ON Iatroi
FOR EACH ROW
BEGIN
    -- Απαγόρευση αυτο-εποπτείας
    IF NEW.amka_epopti = NEW.amka THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Σφάλμα: Ένας ιατρός δεν μπορεί να εποπτεύει τον εαυτό του.';
    END IF;

    IF NEW.va8mida = 'Ειδικευόμενος' AND NEW.amka_epopti IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Σφάλμα: Οι ειδικευόμενοι πρέπει υποχρεωτικά να έχουν επόπτη.';
    END IF;

    IF NEW.va8mida = 'Διευθυντής' AND NEW.amka_epopti IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Σφάλμα: Οι Διευθυντές δεν επιτρέπεται να έχουν επόπτη.';
    END IF;

    IF NEW.amka_epopti IS NOT NULL THEN
        IF EXISTS (SELECT 1 FROM Iatroi WHERE amka = NEW.amka_epopti AND amka_epopti = NEW.amka) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Σφάλμα: Απαγορεύεται η άμεση κυκλική αλυσίδα εποπτείας.';
        END IF;
    END IF;
END; //

DELIMITER ;