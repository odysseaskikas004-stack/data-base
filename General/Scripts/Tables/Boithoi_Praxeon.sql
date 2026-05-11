CREATE TABLE Boithoi_Praxeon (
    kwdikos_praxis VARCHAR(50) NOT NULL, 
    amka CHAR(11) NOT NULL,             
    
    PRIMARY KEY (kwdikos_praxis, amka),
    
    CONSTRAINT fk_boithoi_praxis 
        FOREIGN KEY (kwdikos_praxis) 
        REFERENCES Iatrikes_Praxeis(kwdikos_praxis) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_boithoi_prosopiko 
        FOREIGN KEY (amka) 
        REFERENCES Prosopiko(amka) 
        ON DELETE CASCADE
) ENGINE=InnoDB;