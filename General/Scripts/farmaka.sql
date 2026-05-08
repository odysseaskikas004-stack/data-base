CREATE TABLE Farmaka (
    kwdikos_farmakoy VARCHAR(50) PRIMARY KEY, -- Ο κωδικός από το αρχείο του EMA
    onoma_farmakoy VARCHAR(255) NOT NULL
) ENGINE=InnoDB;