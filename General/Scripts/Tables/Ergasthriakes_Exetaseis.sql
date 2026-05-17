CREATE TABLE Ergasthriakes_Exetaseis (
    kwdikos_exetashs VARCHAR(50) PRIMARY KEY,            
    hmeromhnia DATETIME NOT NULL,          
    typos_exetashs VARCHAR(100),                                         
    kostos DECIMAL(10, 2) NOT NULL,        
    apotelesma TEXT,                                            
    AMKA CHAR(11),                        
    ID_nosileias INT NOT NULL,            


    CONSTRAINT fk_eksetasi_iatros 
        FOREIGN KEY (AMKA) 
        REFERENCES Iatroi(amka) 
        ON DELETE RESTRICT,

    CONSTRAINT fk_eksetasi_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE
        

) ENGINE=InnoDB;
