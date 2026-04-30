CREATE TABLE Dioikitiko_Prosopiko (
    amk CHAR(11) PRIMARY KEY,
    ka8ikonta_rolos VARCHAR(100) NOT NULL,
    grafeio VARCHAR(50) NOT NULL,
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_dioikitiko_prosopiko 
        FOREIGN KEY (amk) 
        REFERENCES Prosopiko(amk) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_dioikitiko_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE RESTRICT
) ENGINE=InnoDB;