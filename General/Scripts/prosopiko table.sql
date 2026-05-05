CREATE TABLE Prosopiko (
    amka CHAR(11) PRIMARY KEY, -- Το ΑΜΚ είναι το PK
    imerominia_proslipsis DATE NOT NULL,
    typos_prosopikou VARCHAR(50) NOT NULL CHECK (typos_prosopikou IN ('Ιατρός', 'Νοσηλευτής', 'Διοικητικό')),	
    -- Σύνδεση με τον πίνακα Άτομα
    FOREIGN KEY (amka) REFERENCES Atoma(amka) ON DELETE CASCADE --το ID atomou ειναι FK που δειχνει στον πινακα Atoma
) ENGINE=InnoDB;										--ON DELETE CASCADE: αν διαγραψω στοιχειο απο πινακα Atoma, θα διαγραφει αυτοματα και απο τον prosopiko