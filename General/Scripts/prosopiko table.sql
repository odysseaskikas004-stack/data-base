CREATE TABLE Prosopiko (
    amk CHAR(11) PRIMARY KEY, -- Το ΑΜΚ είναι το PK 
    ID_atomou INT NOT NULL,   -- Το FK που δείχνει στον πίνακα Άτομα
    imerominia_proslipsis DATE NOT NULL,
    typos_prosopikou ENUM('Ιατρός', 'Νοσηλευτής', 'Διοικητικό') NOT NULL,	--ENUM ειναι μια λιστα με της παρακατω επιλογες
    																		--αν βαλω καποια αλλη λεξη η βαση την απορριπτει
    -- Σύνδεση με τον πίνακα Άτομα
    FOREIGN KEY (ID_atomou) REFERENCES Atoma(ID_atomou) ON DELETE CASCADE --το ID atomou ειναι FK που δειχνει στον πινακα Atoma
) ENGINE=InnoDB;										--ON DELETE CASCADE: αν διαγραψω στοιχειο απο πινακα Atoma, θα διαγραφει αυτοματα και απο τον prosopiko