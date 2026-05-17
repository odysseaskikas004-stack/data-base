CREATE TABLE Nosileies (
    ID_nosileias INT AUTO_INCREMENT PRIMARY KEY, 
    AMKA_astheni CHAR(11) NOT NULL,              
    ID_klinis INT,                             
    ID_tmhmatos INT NOT NULL,                    
    imerominia_eisagwgis DATETIME NOT NULL,    
    imerominia_exodou DATETIME,                 
    diagnosis_eisagwgis VARCHAR(10),            
    diagnosis_exodou VARCHAR(10),              
    AMKA_iatrou CHAR(11),                    

    CONSTRAINT fk_nosileia_as8enis 
        FOREIGN KEY (AMKA_astheni) REFERENCES As8eneis(amka) 
        ON DELETE CASCADE,

    CONSTRAINT fk_nosileia_klini 
        FOREIGN KEY (ID_klinis) REFERENCES Klines(ID_klinis) 
        ON DELETE SET NULL,

    CONSTRAINT fk_nosileia_tmhma 
        FOREIGN KEY (ID_tmhmatos) REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE RESTRICT,

    CONSTRAINT fk_nosileia_icd_in 
        FOREIGN KEY (diagnosis_eisagwgis) REFERENCES ICD_10(kodikos_ICD10) 
        ON DELETE SET NULL,

    CONSTRAINT fk_nosileia_icd_out 
        FOREIGN KEY (diagnosis_exodou) REFERENCES ICD_10(kodikos_ICD10) 
        ON DELETE SET NULL,

    CONSTRAINT fk_nosileia_iatros 
        FOREIGN KEY (AMKA_iatrou) REFERENCES Iatroi(amka) 
        ON DELETE SET NULL
) ENGINE=InnoDB;
