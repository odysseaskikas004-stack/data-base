CREATE TABLE Epeigonta (
    id_epeigontos INT AUTO_INCREMENT PRIMARY KEY,
    amka_nosileythi CHAR(11) NOT NULL,
    symptomata TEXT,
    epipedo_epeigontos VARCHAR(50),
    xronos_afixis DATETIME NOT NULL, 
    seira_proteraiotitas INT,
    amka CHAR(11) DEFAULT NULL,       -- NULLABLE (N) επειδή μπορεί να είναι αναίσθητος/άγνωστος ο ασθενής
    apotelesma_dialogis VARCHAR(255),
    
    FOREIGN KEY (amka) REFERENCES As8eneis(amka) ON DELETE SET NULL ON UPDATE CASCADE,
    
    FOREIGN KEY (amka_nosileythi) REFERENCES Nosileytes(amka) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;