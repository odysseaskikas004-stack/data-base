CREATE TABLE Vardies (
    id_vardias INT AUTO_INCREMENT PRIMARY KEY,
    id_tmhmatos INT NOT NULL,
    hmeromhnia DATE NOT NULL,
    typos_vardias ENUM('Πρωινή', 'Απογευματινή', 'Νυχτερινή') NOT NULL,
    -- Περιορισμός: Μόνο μία βάρδια συγκεκριμένου τύπου ανά τμήμα/ημέρα
    UNIQUE (id_tmhmatos, hmeromhnia, typos_vardias),
    FOREIGN KEY (id_tmhmatos) REFERENCES Tmhmata(id_tmhmatos) ON DELETE CASCADE
) ENGINE=InnoDB;