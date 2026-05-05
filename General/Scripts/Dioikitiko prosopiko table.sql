CREATE TABLE Dioikitiko_Prosopiko (
    amka CHAR(11) PRIMARY KEY,
    ka8ikonta_rolos VARCHAR(100) NOT NULL,
    grafeio VARCHAR(50) NOT NULL,
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_dioikitiko_prosopiko 
        FOREIGN KEY (amka) 
        REFERENCES Prosopiko(amka) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_dioikitiko_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE RESTRICT
) ENGINE=InnoDB;