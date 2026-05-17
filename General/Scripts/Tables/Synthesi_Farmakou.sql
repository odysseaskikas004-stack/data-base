CREATE TABLE Synthesi_Farmakou (
    kodikos_farmakou VARCHAR(50) NOT NULL,
    ID_ousias INT NOT NULL,
    
    -- Το σύνθετο πρωτεύον κλειδί διασφαλίζει ότι δεν θα εισαχθεί 
    -- η ίδια ουσία δύο φορές στο ίδιο φάρμακο
    PRIMARY KEY (kodikos_farmakou, ID_ousias),
    
    CONSTRAINT fk_sf_farmako 
        FOREIGN KEY (kodikos_farmakou) 
        REFERENCES Farmaka(kwdikos_farmakou) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_sf_ousia 
        FOREIGN KEY (ID_ousias) 
        REFERENCES Drastikes_ousies(ID_ousias) 
        ON DELETE CASCADE
) ENGINE=InnoDB;
