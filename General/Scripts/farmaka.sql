CREATE TABLE Farmaka (
    kwdikos_farmakou VARCHAR(50) PRIMARY KEY, -- Ο κωδικός από το αρχείο του EMA
    onoma_farmakou VARCHAR(255) NOT NULL
) ENGINE=InnoDB;