CREATE TABLE Klines (
    ID_klinis INT AUTO_INCREMENT PRIMARY KEY, 
    typos VARCHAR(50) NOT NULL 
        CHECK (typos IN ('ΜΕΘ', 'μονόκλινο', 'πολύκλινο')),
    katastasi VARCHAR(50) NOT NULL 
        CHECK (katastasi IN ('διαθέσιμη', 'κατειλημμένη', 'υπό συντήρηση')),
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_klinis_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE CASCADE
) ENGINE=InnoDB;