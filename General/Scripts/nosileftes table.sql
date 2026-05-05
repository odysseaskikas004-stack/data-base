CREATE TABLE Nosileytes (
    amka CHAR(11) PRIMARY KEY,
    va8mida VARCHAR(50) NOT NULL 
        CHECK (va8mida IN ('Βοηθός Νοσηλευτή', 'Νοσηλευτής', 'Προϊστάμενος')),
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_nosileytis_prosopiko 
        FOREIGN KEY (amka) 
        REFERENCES Prosopiko(amka) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_nosileytis_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE RESTRICT
) ENGINE=InnoDB;