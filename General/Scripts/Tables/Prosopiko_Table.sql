CREATE TABLE Prosopiko (
    amka CHAR(11) PRIMARY KEY,
    imerominia_proslipsis DATE NOT NULL,
    typos_prosopikou VARCHAR(50) NOT NULL CHECK (typos_prosopikou IN ('Ιατρός', 'Νοσηλευτής', 'Διοικητικό')),	
    FOREIGN KEY (amka) REFERENCES Atoma(amka) ON DELETE CASCADE 
) ENGINE=InnoDB;
