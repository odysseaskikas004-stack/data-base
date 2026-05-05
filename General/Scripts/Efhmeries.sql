CREATE TABLE Efhmeries (
    id_efhmerias INT AUTO_INCREMENT PRIMARY KEY,
    id_vardias INT NOT NULL,
    amk_proswpikou VARCHAR(11) NOT NULL,
    -- Μοναδικός συνδυασμός: Ένα άτομο δεν μπορεί να δηλωθεί δύο φορές στην ίδια βάρδια
    UNIQUE (id_vardias, amk_proswpikou),
    FOREIGN KEY (id_vardias) REFERENCES Vardies(id_vardias) ON DELETE CASCADE,
    FOREIGN KEY (amk_proswpikou) REFERENCES Proswpiko(amk) ON DELETE CASCADE
) ENGINE=InnoDB;