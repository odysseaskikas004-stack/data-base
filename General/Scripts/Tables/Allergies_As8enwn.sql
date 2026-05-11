CREATE TABLE Allergies_As8enwn (
    amka CHAR(11) NOT NULL,        
    id_ousias INT NOT NULL,          
    
    PRIMARY KEY (amka, id_ousias),
    
    CONSTRAINT fk_allergia_as8enis 
        FOREIGN KEY (amka) 
        REFERENCES As8eneis(amka) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_allergia_ousia 
        FOREIGN KEY (id_ousias) 
        REFERENCES Drastikes_Ousies(id_ousias) 
        ON DELETE CASCADE
) ENGINE=InnoDB;