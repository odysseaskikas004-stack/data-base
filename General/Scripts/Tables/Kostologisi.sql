CREATE TABLE Kostologisi (
    ID_nosileias INT PRIMARY KEY,          
    kwdikos_KEN VARCHAR(20),               
    MSN INT,                                -- Μέση Διάρκεια Νοσηλείας (από το ΚΕΝ)
    paratasi_nosileias INT DEFAULT 0,       
    synoliko_kostos DECIMAL(15, 2),       

    CONSTRAINT fk_kostologisi_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE,

    CONSTRAINT fk_kostologisi_ken 
        FOREIGN KEY (kwdikos_KEN) 
        REFERENCES KEN(kwdikos_KEN) 
        ON DELETE SET NULL
) ENGINE=InnoDB;
