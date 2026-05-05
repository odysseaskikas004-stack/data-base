CREATE TABLE Iatroi (
    amka CHAR(11) PRIMARY KEY, -- Το ΑΜΚ είναι το PK και FK ταυτόχρονα
    ari8mos_adeias VARCHAR(50) NOT NULL,
    eidikotita VARCHAR(100) NOT NULL,
    va8mida VARCHAR(50) NOT NULL 
        CHECK (va8mida IN ('Ειδικευόμενος', 'Επιμελητής Β΄', 'Επιμελητής Α΄', 'Διευθυντής')),
    amka_epopti CHAR(11), -- Nullable, γιατί οι Διευθυντές δεν έχουν επόπτη
    
    -- Σύνδεση με το γενικό Προσωπικό
    CONSTRAINT fk_iatros_prosopiko 
        FOREIGN KEY (amka) 
        REFERENCES Prosopiko(amka) 
        ON DELETE CASCADE,
        
    -- Αναδρομική σχέση για τον επόπτη ιατρό
    CONSTRAINT fk_iatros_epoptis 
        FOREIGN KEY (amka_epopti) 
        REFERENCES Iatroi(amka) 
        ON DELETE SET NULL
) ENGINE=InnoDB;