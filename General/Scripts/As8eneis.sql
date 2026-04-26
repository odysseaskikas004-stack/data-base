CREATE TABLE As8eneis (
    ID_atomou INT PRIMARY KEY, -- Το ID από τον πίνακα Atoma
    patronymo VARCHAR(100),
    fylo VARCHAR(10),
    varos DECIMAL(5, 2),
    ypsos DECIMAL(5, 2),
    epaggelma VARCHAR(100),
    ypikootita VARCHAR(50),
    asfalistikos_foreas VARCHAR(100),
    
    -- Η σύνδεση με τον πίνακα Atoma
    CONSTRAINT fk_as8enis_atomo 
        FOREIGN KEY (ID_atomou) 
        REFERENCES Atoma(ID_atomou) 
        ON DELETE CASCADE
) ENGINE=InnoDB;