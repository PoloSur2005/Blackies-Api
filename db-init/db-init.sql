DROP DATABASE IF EXISTS blackies;
CREATE DATABASE blackies;
USE blackies;

CREATE TABLE IF NOT EXISTS Level (
    LevelID INT NOT NULL AUTO_INCREMENT,
    Number INT NOT NULL UNIQUE,
    Image VARCHAR(150) NOT NULL,
    PRIMARY KEY(LevelID)
);

CREATE TABLE IF NOT EXISTS Autor (
    AutorID INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(150) NOT NULL,
    PRIMARY KEY(AutorID)
);

CREATE TABLE IF NOT EXISTS Momo (
    MomoID INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE,
    Description VARCHAR(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    Image VARCHAR(200) NOT NULL,
    AutorID INT NOT NULL,
    LevelID INT NOT NULL,
    PRIMARY KEY(MomoID),
    CONSTRAINT fk_AutorID FOREIGN KEY (AutorID) REFERENCES Autor(AutorID),
    CONSTRAINT fk_LevelID FOREIGN KEY (LevelID) REFERENCES Level(LevelID)
) CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO Level(Number, Image) 
VALUES
(1,'/assets/levels/1'),
(2,'/assets/levels/2'),
(3,'/assets/levels/3'),
(4,'/assets/levels/4'),
(5,'/assets/levels/5'),
(6,'/assets/levels/6')
ON DUPLICATE KEY UPDATE Image = VALUES(Image);

INSERT INTO Autor(Name, Description)
VALUES
('Mike', 'Mike'),
('Salon', 'Salon'),
('Peter', 'Peter'),
('Alfred', 'Alfred'),
('Marco', 'Marco'),
('Carlos', 'Carlos'),
('Joel', 'Joel'),
('Emiliano', 'Emiliano'),
('Claudio', 'Claudio'),
('Jefazo', 'Jefazo'),
('Max', 'Max'),
('Brandon Tavares', 'Brandon Tavares'),
('Bbno$', 'Bbno$'),
('Cesar', 'Cesar'),
('Sebas', 'Sebas'),
('Solis', 'Solis'),
('Moi', 'Moi'),
('Diego Medina', 'Diego Medina'),
('Joaquin', 'Joaquin'),
('Alvaro', 'Alvaro')
ON DUPLICATE KEY UPDATE Description = VALUES(Description);


INSERT INTO Momo(Name, Description, Image, AutorID, LevelID)
VALUES
-- Nivel 1
  ('Codigo MICKEYBANANA',
   'Codigo MICKEYBANANA en la tienda de Fortnite',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749854614/codigomickeybanana_newgye.jpg',
   1, 1),
  ('Internet malo',
   '',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749850298/internetmalo_kmlwb0.jpg',
   2, 1),
  ('Deudores',
   'Poster hecho por alumnos de MierdaMedica que fue encontrado y vandalizado por los negroides y devuelto a donde fue encontrado',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749853243/deudores_igeyeb.jpg',
   3, 1),
  ('Live and play',
   'Grupo estudiantil de la Salle conformado por puro normi que según les gustan los videojuegos pero nadie esta dispuesto a jugar',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749854595/liveandplay_lndhdq.jpg',
   4, 1),
  ('Que paso padre',
   'Frase dicha por Carlos Chavez seguidamente durante primer semestre para saludar',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749851442/FATHER_mcaxdi.webp',
   6, 1),
  ('Gato Queso',
   'Emoji utilizado frecuentemente por Joel durante prepa cuando algo le daba risa',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749850544/gatoqueso_a9gzuw.jpg',
   7, 1)
ON DUPLICATE KEY UPDATE
  Description = VALUES(Description),
  Image       = VALUES(Image),
  AutorID     = VALUES(AutorID),
  LevelID     = VALUES(LevelID);

DROP VIEW IF EXISTS vw_Momo;
CREATE VIEW vw_Momo AS 
    SELECT 
        M.MomoID,
        M.Name,
        M.Description,
        M.Image,
        A.Name AS Autor,
        A.Description AS Autor_Description,
        L.Number AS Level,
        L.Image AS Level_Image
    FROM Momo AS M
    INNER JOIN Autor AS A ON M.AutorID = A.AutorID
    INNER JOIN Level AS L ON M.LevelID = L.LevelID;

DROP PROCEDURE IF EXISTS sp_FilterByLevel;
DELIMITER //
CREATE PROCEDURE sp_FilterByLevel(IN LevelToSearch INT)
BEGIN
    SELECT 
        M.Name,
        M.Description,
        M.Image 
    FROM Momo AS M
    INNER JOIN Level AS L ON M.LevelID = L.LevelID
    WHERE L.Number = LevelToSearch;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_FilterByAutor;
DELIMITER //
CREATE PROCEDURE sp_FilterByAutor(IN AutorToSearch VARCHAR(50))
BEGIN
    SELECT 
        M.Name,
        M.Description,
        M.Image 
    FROM Momo AS M
    INNER JOIN Autor AS A ON M.AutorID = A.AutorID
    WHERE A.Name = AutorToSearch;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_GetMomo;
DELIMITER //
CREATE PROCEDURE sp_GetMomo(IN IDToSearch INT)
BEGIN
    SELECT * FROM vw_Momo WHERE vw_Momo.MomoID = IDToSearch;
END //
DELIMITER ;