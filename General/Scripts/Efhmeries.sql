CREATE TABLE Efhmeries (
    id_efhmerias INT AUTO_INCREMENT PRIMARY KEY,
    id_vardias INT NOT NULL,
    amka_prosopikou CHAR(11) NOT NULL,
    -- Μοναδικός συνδυασμός: Ένα άτομο δεν μπορεί να δηλωθεί δύο φορές στην ίδια βάρδια
    UNIQUE (id_vardias, amka_prosopikou),
    FOREIGN KEY (id_vardias) REFERENCES Vardies(id_vardias) ON DELETE CASCADE,
    FOREIGN KEY (amka_prosopikou) REFERENCES Prosopiko(amka) ON DELETE CASCADE
) ENGINE=InnoDB;