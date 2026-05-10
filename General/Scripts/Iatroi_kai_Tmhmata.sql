CREATE TABLE Iatroi_kai_Tmhmata (
    amka CHAR(11) NOT NULL,         
    ID_tmhmatos INT NOT NULL,       
    
    PRIMARY KEY (amka, ID_tmhmatos),

    CONSTRAINT fk_iatroi_tmhmata_iatros 
        FOREIGN KEY (amka) REFERENCES Iatroi(amka) 
        ON DELETE CASCADE ON UPDATE CASCADE,
   
    CONSTRAINT fk_iatroi_tmhmata_tmhma 
        FOREIGN KEY (ID_tmhmatos) REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;