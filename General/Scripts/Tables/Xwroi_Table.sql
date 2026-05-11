CREATE TABLE Xwroi_Ai8ouses (
    ID_xwrou INT AUTO_INCREMENT PRIMARY KEY,
    typos VARCHAR(50) NOT NULL 
        CHECK (typos IN ('Χειρουργείο', 'Αίθουσα επέμβασης')),
    orofos_kthrio VARCHAR(100) NOT NULL,
    perigrafh TEXT,
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_xwrou_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE CASCADE
) ENGINE=InnoDB;