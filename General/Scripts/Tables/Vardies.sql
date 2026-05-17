CREATE TABLE Vardies (
    id_vardias INT AUTO_INCREMENT PRIMARY KEY,
    id_tmhmatos INT NOT NULL,
    hmeromhnia DATE NOT NULL,
    typos_vardias VARCHAR(20) NOT NULL 
        CHECK (typos_vardias IN ('Πρωινή', 'Απογευματινή', 'Νυχτερινή')),
        
    CONSTRAINT uq_vardia_tmhma UNIQUE (id_tmhmatos, hmeromhnia, typos_vardias),
    CONSTRAINT fk_vardia_tmhma FOREIGN KEY (id_tmhmatos) REFERENCES Tmhmata(id_tmhmatos) ON DELETE CASCADE
) ENGINE=InnoDB;
