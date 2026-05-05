CREATE TABLE KEN (
    kodikos_KEN VARCHAR(20) PRIMARY KEY, -- Ο κωδικός ΚΕΝ
    basiko_kostos DECIMAL(10, 2) NOT NULL,
    mesi_diarkeia_nosileias INT NOT NULL -- Σε ημέρες
) ENGINE=InnoDB;