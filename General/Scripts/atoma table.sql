CREATE TABLE Atoma (
    ID_atomou INT AUTO_INCREMENT PRIMARY KEY, -- Τεχνητό κλειδί για να λυθεί το πρόβλημα του NULL
    onoma VARCHAR(50) NOT NULL,
    eponymo VARCHAR(50) NOT NULL,
    ilikia INT CHECK (ilikia >= 0 AND ilikia <= 120),
    email VARCHAR(100) UNIQUE,
    tilefono VARCHAR(15),
    amk CHAR(11) UNIQUE,  -- Θα συμπληρώνεται μόνο αν είναι προσωπικό
    amka CHAR(11) UNIQUE  -- Θα συμπληρώνεται μόνο αν είναι ασθενής
) ENGINE=InnoDB;