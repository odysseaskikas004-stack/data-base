CREATE TABLE Axiologisi_Iatrwn (
    ID_nosileias INT NOT NULL,
    AMKA_iatrou CHAR(11) NOT NULL,
    vathmos_iatrikis_frontidas TINYINT NOT NULL 
        CHECK (vathmos_iatrikis_frontidas BETWEEN 1 AND 5),
    
    PRIMARY KEY (ID_nosileias, AMKA_iatrou),
    
    CONSTRAINT fk_eval_doc_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_eval_doc_iatros 
        FOREIGN KEY (AMKA_iatrou) 
        REFERENCES Iatroi_Table(amka) 
        ON DELETE CASCADE
) ENGINE=InnoDB;