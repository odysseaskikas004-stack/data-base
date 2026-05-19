CREATE TABLE Agwges (
    amka_iatrou CHAR(11) NOT NULL,         
    amka_as8eni CHAR(11) NOT NULL,            
    kwdikos_farmakou VARCHAR(50) NOT NULL,    
    imerominia_enarxis DATE NOT NULL,         
    
    imerominia_lixis DATE,                    
    dosologia VARCHAR(255) NOT NULL,          
    syxnotita VARCHAR(255) NOT NULL,          
    ID_nosileias INT NOT NULL,                

    PRIMARY KEY (amka_iatrou, amka_as8eni, kwdikos_farmakou, imerominia_enarxis),

    CONSTRAINT fk_agwgi_iatros 
        FOREIGN KEY (amka_iatrou) REFERENCES Iatroi_Table(amka) 
        ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT fk_agwgi_as8enis 
        FOREIGN KEY (amka_as8eni) REFERENCES As8eneis(amka) 
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_agwgi_farmako 
        FOREIGN KEY (kwdikos_farmakou) REFERENCES Farmaka(kwdikos_farmakou) 
        ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT fk_agwgi_nosileia 
        FOREIGN KEY (ID_nosileias) REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE
) ENGINE=InnoDB;
