CREATE TABLE Axiologisi_Nosileias (
    ID_nosileias INT PRIMARY KEY,
    poiotita_nosileytikis TINYINT NOT NULL 
        CHECK (poiotita_nosileytikis BETWEEN 1 AND 5),
    kathariotita TINYINT NOT NULL 
        CHECK (kathariotita BETWEEN 1 AND 5),
    fagito TINYINT NOT NULL 
        CHECK (fagito BETWEEN 1 AND 5),
    synoliki_empeiria TINYINT NOT NULL 
        CHECK (synoliki_empeiria BETWEEN 1 AND 5),
    imerominia_axiologisis DATE NOT NULL,
    
    CONSTRAINT fk_eval_nos_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE
) ENGINE=InnoDB;