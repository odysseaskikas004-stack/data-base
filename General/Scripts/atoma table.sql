CREATE TABLE Atoma (
    onoma VARCHAR(50) NOT NULL,
    eponymo VARCHAR(50) NOT NULL,
    ilikia INT CHECK (ilikia >= 0 AND ilikia <= 120),
    email VARCHAR(100) UNIQUE,
    tilefono VARCHAR(15),
    amka CHAR(11) UNIQUE
) ENGINE=InnoDB;