CREATE TABLE Iatrikes_Praxeis (
    kwdikos_praxis VARCHAR(50) PRIMARY KEY, 
    onoma VARCHAR(255) NOT NULL,            
    imerominia DATETIME NOT NULL,          
    katigoria VARCHAR(100),                
    diarkeia INT,                          
    kostos DECIMAL(10, 2) NOT NULL,        
    apotelesma TEXT,                      
    
    ID_xwrou INT,                          
    AMKA CHAR(11),                        
    ID_nosileias INT NOT NULL,            

    CONSTRAINT fk_praxi_xwros 
        FOREIGN KEY (ID_xwrou) 
        REFERENCES Xwroi_Ai8ouses(ID_xwrou) 
        ON DELETE SET NULL,

    CONSTRAINT fk_praxi_iatros 
        FOREIGN KEY (AMKA) 
        REFERENCES Iatroi(amka) 
        ON DELETE RESTRICT,

    CONSTRAINT fk_nosileia_praxi 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE,
        
    CONSTRAINT chk_katigoria_praxis 
        CHECK (katigoria IN ('Χειρουργική', 'Διαγνωστική', 'Θεραπευτική'))
) ENGINE=InnoDB;