CREATE TABLE Iatroi (
    amk CHAR(11) PRIMARY KEY, -- Το ΑΜΚ είναι το PK και FK ταυτόχρονα
    ari8mos_adeias VARCHAR(50) NOT NULL,
    eidikotita VARCHAR(100) NOT NULL,
    va8mida VARCHAR(50) NOT NULL 
        CHECK (va8mida IN ('Ειδικευόμενος', 'Επιμελητής Β΄', 'Επιμελητής Α΄', 'Διευθυντής')),
    amk_epopti CHAR(11), -- Nullable, γιατί οι Διευθυντές δεν έχουν επόπτη
    
    -- Σύνδεση με το γενικό Προσωπικό
    CONSTRAINT fk_iatros_prosopiko 
        FOREIGN KEY (amk) 
        REFERENCES Prosopiko(amk) 
        ON DELETE CASCADE,
        
    -- Αναδρομική σχέση για τον επόπτη ιατρό
    CONSTRAINT fk_iatros_epoptis 
        FOREIGN KEY (amk_epopti) 
        REFERENCES Iatroi(amk) 
        ON DELETE SET NULL
) ENGINE=InnoDB;