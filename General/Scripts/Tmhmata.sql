CREATE TABLE Tmhmata (
    ID_tmhmatos INT PRIMARY KEY,
    onoma_tmhmatos VARCHAR(100) NOT NULL,
    perigrafh TEXT,
    ari8mos_klinwn INT DEFAULT 0 CHECK (ari8mos_klinwn >= 0),
    kthrio_orofos VARCHAR(100),
    
    amk_diey8ynths CHAR(11) NOT NULL, 
    
    -- Σύνδεση με τον πίνακα prosopiko
    CONSTRAINT fk_tmhma_diey8ynths 
        FOREIGN KEY (amk_diey8ynths) 
        REFERENCES Prosopiko(amk) 
        ON DELETE RESTRICT -- Απαγορεύει τη διαγραφή του διευθυντή αν δεν αντικατασταθεί
) ENGINE=InnoDB;