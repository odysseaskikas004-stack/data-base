CREATE TABLE Iatroi_nosileias (
    ID_nosileias INT NOT NULL,
    AMKA_iatrou CHAR(11) NOT NULL,
    
    PRIMARY KEY (ID_nosileias, AMKA_iatrou),
    
    CONSTRAINT fk_in_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_in_iatros 
        FOREIGN KEY (AMKA_iatrou) 
        REFERENCES Iatroi_Table(amka) 
        ON DELETE CASCADE
) ENGINE=InnoDB;