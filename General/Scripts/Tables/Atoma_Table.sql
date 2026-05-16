CREATE TABLE Atoma (
    onoma VARCHAR(50) NOT NULL,
    eponymo VARCHAR(50) NOT NULL,
    ilikia INT CHECK (ilikia >= 0 AND ilikia <= 120),
    email VARCHAR(100) UNIQUE,
    tilefono VARCHAR(15),
    amka CHAR(11) PRIMARY KEY,
    typos_atomou VARCHAR(20) NOT NULL,
    
    CONSTRAINT chk_typos_atomou 
        CHECK (typos_atomou IN ('Ιατρός', 'Ασθενής', 'Νοσηλευτής', 'Διοικητικός'))
) ENGINE=InnoDB;