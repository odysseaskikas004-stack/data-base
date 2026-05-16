
USE nosokomeio_db;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Agwges;
DROP TABLE IF EXISTS Allergies_As8enwn;
DROP TABLE IF EXISTS As8eneis;
DROP TABLE IF EXISTS Atoma;
DROP TABLE IF EXISTS Axiologisi_latrawn;
DROP TABLE IF EXISTS Axiologisi_Nosileias;
DROP TABLE IF EXISTS Boithoi_Praxeon;
DROP TABLE IF EXISTS Dioikitiko_Prosopiko_Table;
DROP TABLE IF EXISTS Drastikes_Ousies;
DROP TABLE IF EXISTS Efhmeries;
DROP TABLE IF EXISTS Eikones;
DROP TABLE IF EXISTS Epeigonta;
DROP TABLE IF EXISTS Farmaka;
DROP TABLE IF EXISTS `ICD-10`;
DROP TABLE IF EXISTS Iatrikes_Praxeis;
DROP TABLE IF EXISTS Iatroi_Nosileias;
DROP TABLE IF EXISTS Iatroi_Table;
DROP TABLE IF EXISTS Iatroi_kai_Tmhmata;
DROP TABLE IF EXISTS KEN;
DROP TABLE IF EXISTS Klines_Table;
DROP TABLE IF EXISTS Kostologisi;
DROP TABLE IF EXISTS Nosileftes_Table;
DROP TABLE IF EXISTS Nosileies;
DROP TABLE IF EXISTS Prosopiko_Table;
DROP TABLE IF EXISTS Synthesi_Farmakou;
DROP TABLE IF EXISTS Tmhmata;
DROP TABLE IF EXISTS Vardies;
DROP TABLE IF EXISTS Xwroi_Table;

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE Atoma (
    onoma VARCHAR(50) NOT NULL,
    eponymo VARCHAR(50) NOT NULL,
    ilikia INT CHECK (ilikia >= 0 AND ilikia <= 120),
    email VARCHAR(100) UNIQUE,
    tilefono VARCHAR(15),
    amka CHAR(11) UNIQUE,
    typos_atomou VARCHAR(20) NOT NULL,
    
    CONSTRAINT chk_typos_atomou 
        CHECK (typos_atomou IN ('Ιατρός', 'Ασθενής', 'Νοσηλευτής', 'Διοικητικός'))
) ENGINE=InnoDB;

CREATE TABLE Tmhmata (
    ID_tmhmatos INT PRIMARY KEY,
    onoma_tmhmatos VARCHAR(100) NOT NULL,
    perigrafh TEXT,
    ari8mos_klinwn INT DEFAULT 0 CHECK (ari8mos_klinwn >= 0),
    kthrio_orofos VARCHAR(100),
    
    amka_diey8ynths CHAR(11) NOT NULL, 

    CONSTRAINT fk_tmhma_diey8ynths 
        FOREIGN KEY (amka_diey8ynths) 
        REFERENCES Prosopiko(amka) 
        ON DELETE RESTRICT -- Απαγορεύει τη διαγραφή του διευθυντή αν δεν αντικατασταθεί
) ENGINE=InnoDB;

CREATE TABLE Farmaka (
    kwdikos_farmakou VARCHAR(50) PRIMARY KEY, -- Ο κωδικός από το αρχείο του EMA
    onoma_farmakou VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Drastikes_Ousies (
    ID_ousias INT AUTO_INCREMENT PRIMARY KEY, 
    onoma_ousias VARCHAR(255) NOT NULL UNIQUE 
) ENGINE=InnoDB;

CREATE TABLE ICD_10 (
    kodikos_ICD10 VARCHAR(10) PRIMARY KEY,
    perigrafi VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE KEN (
    kodikos_KEN VARCHAR(20) PRIMARY KEY, 
    basiko_kostos DECIMAL(10, 2) NOT NULL,
    mesi_diarkeia_nosileias INT NOT NULL 
) ENGINE=InnoDB;

CREATE TABLE Prosopiko (
    amka CHAR(11) PRIMARY KEY,
    imerominia_proslipsis DATE NOT NULL,
    typos_prosopikou VARCHAR(50) NOT NULL CHECK (typos_prosopikou IN ('Ιατρός', 'Νοσηλευτής', 'Διοικητικό')),	
    FOREIGN KEY (amka) REFERENCES Atoma(amka) ON DELETE CASCADE --το ID atomou ειναι FK που δειχνει στον πινακα Atoma
) ENGINE=InnoDB;		


CREATE TABLE As8eneis (
    amka CHAR(11) PRIMARY KEY,
    patronymo VARCHAR(100),
    fylo VARCHAR(10),
    varos DECIMAL(5, 2),
    ypsos DECIMAL(5, 2),
    epaggelma VARCHAR(100),
    ypikootita VARCHAR(50),
    asfalistikos_foreas VARCHAR(100),
    
    -- Η σύνδεση με τον πίνακα Atoma
    CONSTRAINT fk_as8enis_atomo 
        FOREIGN KEY (amka) 
        REFERENCES Atoma(amka) 
        ON DELETE CASCADE
    ) ENGINE=InnoDB;
    
    CREATE TABLE Xwroi_Ai8ouses (
    ID_xwrou INT AUTO_INCREMENT PRIMARY KEY,
    typos VARCHAR(50) NOT NULL 
        CHECK (typos IN ('Χειρουργείο', 'Αίθουσα επέμβασης')),
    orofos_kthrio VARCHAR(100) NOT NULL,
    perigrafh TEXT,
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_xwrou_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Vardies (
    id_vardias INT AUTO_INCREMENT PRIMARY KEY,
    id_tmhmatos INT NOT NULL,
    hmeromhnia DATE NOT NULL,
    typos_vardias ENUM('Πρωινή', 'Απογευματινή', 'Νυχτερινή') NOT NULL,
    UNIQUE (id_tmhmatos, hmeromhnia, typos_vardias),
    FOREIGN KEY (id_tmhmatos) REFERENCES Tmhmata(id_tmhmatos) ON DELETE CASCADE
) ENGINE=InnoDB;

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

CREATE TABLE Iatroi (
    amka CHAR(11) PRIMARY KEY, -- Το ΑΜΚA είναι το PK και FK ταυτόχρονα
    ari8mos_adeias VARCHAR(50) NOT NULL,
    eidikotita VARCHAR(100) NOT NULL,
    va8mida VARCHAR(50) NOT NULL 
        CHECK (va8mida IN ('Ειδικευόμενος', 'Επιμελητής Β΄', 'Επιμελητής Α΄', 'Διευθυντής')),
    amka_epopti CHAR(11), 
    
    CONSTRAINT fk_iatros_prosopiko 
        FOREIGN KEY (amka) 
        REFERENCES Prosopiko(amka) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_iatros_epoptis 
        FOREIGN KEY (amka_epopti) 
        REFERENCES Iatroi(amka) 
        ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE Nosileytes (
    amka CHAR(11) PRIMARY KEY,
    va8mida VARCHAR(50) NOT NULL 
        CHECK (va8mida IN ('Βοηθός Νοσηλευτή', 'Νοσηλευτής', 'Προϊστάμενος')),
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_nosileytis_prosopiko 
        FOREIGN KEY (amka) 
        REFERENCES Prosopiko(amka) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_nosileytis_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Dioikitiko_Prosopiko (
    amka CHAR(11) PRIMARY KEY,
    ka8ikonta_rolos VARCHAR(100) NOT NULL,
    grafeio VARCHAR(50) NOT NULL,
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_dioikitiko_prosopiko 
        FOREIGN KEY (amka) 
        REFERENCES Prosopiko(amka) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_dioikitiko_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Klines (
    ID_klinis INT AUTO_INCREMENT PRIMARY KEY, 
    typos VARCHAR(50) NOT NULL 
        CHECK (typos IN ('ΜΕΘ', 'μονόκλινο', 'πολύκλινο')),
    katastasi VARCHAR(50) NOT NULL 
        CHECK (katastasi IN ('διαθέσιμη', 'κατειλημμένη', 'υπό συντήρηση')),
    ID_tmhmatos INT NOT NULL,
    
    CONSTRAINT fk_klinis_tmhma 
        FOREIGN KEY (ID_tmhmatos) 
        REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Allergies_As8enwn (
    amka CHAR(11) NOT NULL,        
    id_ousias INT NOT NULL,          
    
    PRIMARY KEY (amka, id_ousias),
    
    CONSTRAINT fk_allergia_as8enis 
        FOREIGN KEY (amka) 
        REFERENCES As8eneis(amka) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_allergia_ousia 
        FOREIGN KEY (id_ousias) 
        REFERENCES Drastikes_Ousies(id_ousias) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Iatroi_kai_Tmhmata (
    amka CHAR(11) NOT NULL,         
    ID_tmhmatos INT NOT NULL,       
    
    PRIMARY KEY (amka, ID_tmhmatos),

    CONSTRAINT fk_iatroi_tmhmata_iatros 
        FOREIGN KEY (amka) REFERENCES Iatroi(amka) 
        ON DELETE CASCADE ON UPDATE CASCADE,
   
    CONSTRAINT fk_iatroi_tmhmata_tmhma 
        FOREIGN KEY (ID_tmhmatos) REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Efhmeries (
    id_efhmerias INT AUTO_INCREMENT PRIMARY KEY,
    id_vardias INT NOT NULL,
    amka_prosopikou CHAR(11) NOT NULL,
    UNIQUE (id_vardias, amka_prosopikou),
    FOREIGN KEY (id_vardias) REFERENCES Vardies(id_vardias) ON DELETE CASCADE,
    FOREIGN KEY (amka_prosopikou) REFERENCES Prosopiko(amka) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Nosileies (
    ID_nosileias INT AUTO_INCREMENT PRIMARY KEY, 
    AMKA_astheni CHAR(11) NOT NULL,              
    ID_klinis INT,                             
    ID_tmhmatos INT NOT NULL,                    
    imerominia_eisagwgis DATETIME NOT NULL,    
    imerominia_exodou DATETIME,                 
    diagnosis_eisagwgis VARCHAR(10),            
    diagnosis_exodou VARCHAR(10),              
    AMKA_iatrou CHAR(11),                    

    CONSTRAINT fk_nosileia_as8enis 
        FOREIGN KEY (AMKA_astheni) REFERENCES As8eneis(amka) 
        ON DELETE CASCADE,

    CONSTRAINT fk_nosileia_klini 
        FOREIGN KEY (ID_klinis) REFERENCES Klines(ID_klinis) 
        ON DELETE SET NULL,

    CONSTRAINT fk_nosileia_tmhma 
        FOREIGN KEY (ID_tmhmatos) REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE RESTRICT,

    CONSTRAINT fk_nosileia_icd_in 
        FOREIGN KEY (diagnosis_eisagwgis) REFERENCES ICD_10(kwdikos_ICD10) 
        ON DELETE SET NULL,

    CONSTRAINT fk_nosileia_icd_out 
        FOREIGN KEY (diagnosis_exodou) REFERENCES ICD_10(kwdikos_ICD10) 
        ON DELETE SET NULL,

    CONSTRAINT fk_nosileia_iatros 
        FOREIGN KEY (AMKA_iatrou) REFERENCES Iatroi(amka) 
        ON DELETE SET NULL
) ENGINE=InnoDB;

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

CREATE TABLE Iatrikes_Praxeis (
    kwdikos_praxis VARCHAR(50) PRIMARY KEY, 
    onoma VARCHAR(255) NOT NULL,            
    imerominia DATETIME NOT NULL,          
    katigoria VARCHAR(100),                
    diarkeia INT,                          
    kostos DECIMAL(10, 2) NOT NULL,        
    apotelesma TEXT,                      
    
    ID_xwrou INT,                          
    AMKA CHAR(11),                        
    ID_nosileias INT NOT NULL,            

    CONSTRAINT fk_praxi_xwros 
        FOREIGN KEY (ID_xwrou) 
        REFERENCES Xwroi_Ai8ouses(ID_xwrou) 
        ON DELETE SET NULL,

    CONSTRAINT fk_praxi_iatros 
        FOREIGN KEY (AMKA) 
        REFERENCES Iatroi(amka) 
        ON DELETE RESTRICT,

    CONSTRAINT fk_nosileia_praxi 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Boithoi_Praxeon (
    kwdikos_praxis VARCHAR(50) NOT NULL, 
    amka CHAR(11) NOT NULL,             
    
    PRIMARY KEY (kwdikos_praxis, amka),
    
    CONSTRAINT fk_boithoi_praxis 
        FOREIGN KEY (kwdikos_praxis) 
        REFERENCES Iatrikes_Praxeis(kwdikos_praxis) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_boithoi_prosopiko 
        FOREIGN KEY (amka) 
        REFERENCES Prosopiko(amka) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Iatroi_nosileias (
    ID_nosileias INT NOT NULL,
    AMKA_iatrou CHAR(11) NOT NULL,
    
    PRIMARY KEY (ID_nosileias, AMKA_iatrou),
    
    CONSTRAINT fk_in_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_in_iatros 
        FOREIGN KEY (AMKA_iatrou) 
        REFERENCES Iatroi(amka) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Agwges (
    amka_iatrou CHAR(11) NOT NULL,         
    amka_as8eni CHAR(11) NOT NULL,            
    kwdikos_farmakou VARCHAR(50) NOT NULL,    
    imerominia_enarxis DATE NOT NULL,         
    
    imerominia_lixis DATE,                    
    dosologia VARCHAR(255) NOT NULL,          
    syxnotita VARCHAR(255) NOT NULL,          
    ID_nosileias INT NOT NULL,                

    PRIMARY KEY (amka_iatrou, amka_as8eni, kwdikos_farmakou, imerominia_enarxis),

    CONSTRAINT fk_agwgi_iatros 
        FOREIGN KEY (amka_iatrou) REFERENCES Iatroi(amka) 
        ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT fk_agwgi_as8enis 
        FOREIGN KEY (amka_as8eni) REFERENCES As8eneis(amka) 
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_agwgi_farmako 
        FOREIGN KEY (kwdikos_farmakoy) REFERENCES Farmaka(kwdikos_farmakoy) 
        ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT fk_agwgi_nosileia 
        FOREIGN KEY (ID_nosileias) REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Kostologisi (
    ID_nosileias INT PRIMARY KEY,          
    kwdikos_KEN VARCHAR(20),               
    MSN INT,                                -- Μέση Διάρκεια Νοσηλείας (από το ΚΕΝ)
    paratasi_nosileias INT DEFAULT 0,       
    synoliko_kostos DECIMAL(15, 2),       

    CONSTRAINT fk_kostologisi_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE,

    CONSTRAINT fk_kostologisi_ken 
        FOREIGN KEY (kwdikos_KEN) 
        REFERENCES KEN(kwdikos_KEN) 
        ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE Eikones (
    ID_eikonas INT AUTO_INCREMENT PRIMARY KEY,
    path_eikonas VARCHAR(500) NOT NULL,
    perigrafh TEXT,
    
    AMKA CHAR(11) NULL,   
    ID_tmhmatos INT NULL,      
    ID_praxes VARCHAR(50) NULL,

    CONSTRAINT fk_eikones_iatros 
        FOREIGN KEY (AMKA) REFERENCES Iatroi(amka) 
        ON DELETE SET NULL,
        
    CONSTRAINT fk_eikones_tmhma 
        FOREIGN KEY (ID_tmhmatos) REFERENCES Tmhmata(ID_tmhmatos) 
        ON DELETE SET NULL,
        
    CONSTRAINT fk_eikones_praxis 
        FOREIGN KEY (ID_praxes) REFERENCES Iatrikas_Praxeis(kwdikos_praxis) 
        ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE Axiologisi_Nosileias (
    ID_nosileias INT PRIMARY KEY,
    poiotita_nosileytikis TINYINT NOT NULL 
        CHECK (poiotita_nosileytikis BETWEEN 1 AND 5),
    kathariotita TINYINT NOT NULL 
        CHECK (kathariotita BETWEEN 1 AND 5),
    fagito TINYINT NOT NULL 
        CHECK (fagito BETWEEN 1 AND 5),
    synoliki_empeiria TINYINT NOT NULL 
        CHECK (synoliki_empeiria BETWEEN 1 AND 5),
    imerominia_axiologisis DATE NOT NULL,
    
    CONSTRAINT fk_eval_nos_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Axiologisi_Iatrwn (
    ID_nosileias INT NOT NULL,
    AMKA_iatrou CHAR(11) NOT NULL,
    vathmos_iatrikis_frontidas TINYINT NOT NULL 
        CHECK (vathmos_iatrikis_frontidas BETWEEN 1 AND 5),
    
    PRIMARY KEY (ID_nosileias, AMKA_iatrou),
    
    CONSTRAINT fk_eval_doc_nosileia 
        FOREIGN KEY (ID_nosileias) 
        REFERENCES Nosileies(ID_nosileias) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_eval_doc_iatros 
        FOREIGN KEY (AMKA_iatrou) 
        REFERENCES Iatroi(amka) 
        ON DELETE CASCADE
) ENGINE=InnoDB;


