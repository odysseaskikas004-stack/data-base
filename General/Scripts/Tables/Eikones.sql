CREATE TABLE Eikones (
    ID_eikonas INT AUTO_INCREMENT PRIMARY KEY,
    path_eikonas VARCHAR(500) NOT NULL,
    perigrafh TEXT,
    
    AMKA CHAR(11) NULL,   
    ID_tmhmatos INT NULL,      
    ID_praxes VARCHAR(50) NULL,

    CONSTRAINT fk_eikones_iatros 
        FOREIGN KEY (AMKA) REFERENCES Iatroi(amka) 
        ON DELETE SET NULL,
        
    CONSTRAINT fk_eikones_tmhma 
        FOREIGN KEY (ID_tmhmatos) REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE SET NULL,
        
    CONSTRAINT fk_eikones_praxis 
        FOREIGN KEY (ID_praxes) REFERENCES Iatrikas_Praxeis(kwdikos_praxis) 
        ON DELETE SET NULL
) ENGINE=InnoDB;