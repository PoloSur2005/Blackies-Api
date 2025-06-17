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
   7, 1),
 -- Nivel 2
  ('Perverso',
   'Frase que tiene un 50% de probabilidad que el profe la diga si es que quiere decir perfecto es como un evento aleatorio donde al tirar una moneda pueda salir cara o sello',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749853570/perversoooo_xj4mj0.jpg',
   9, 2),
  ('Primera vez en diosbuntu',
   'Jefazo en su intento de demostrar de superioridad solto esta mitica frase sabiendo bien que Ubuntu es la peor distribucion de Linux',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749855342/primeravezdiosbuntu_i9zb1g.jpg',
   10, 2),
  ('Ctrl O',
   'Conjunto de teclas con las que abres un documento en Photoshop el cual esta persona repetia a diario y por eso se gano ese apodo',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749853886/ctrlo.jpg',
   9, 2),
  ('BBNO$',
   'Debido al gran parecido que tiene esta persona con el cantante Bbno$ se origino este apodo',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749853698/bbnochat_lpy9tf.png',
   3, 2),
  ('Contexto Mundial',
   'Materia la cual odiaba Jefazo por algun motivo y hablo con el coordinador acerca de los metodos de ensenanza de la maestra aunque las materias de religion nunca son relevantes ni dificiles',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749854485/contextomundial_psqaa8.jpg',
   10, 2),
  ('Discord Games',
   'Actividad que hacen los negroides cuando las clases son aburridas o el profe no sabe que esta haciendo',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749853720/negroidesglobo_fktbct.png',
   7, 2),
-- Nivel 3
  ('Live and code',
   'Proyecto fallido de Live and Play en el cual se buscaba contar con apoyo de Microsoft y poder desarrollar un videojuego',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749969678/live_code_hpjhg0.jpg',
   4, 3),
  ('Opiniones de jefazo',
   'Debido a la naturaleza NPC de el jefazo, es divertido cuestionarle a otras personas sus opiniones acerca de el',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749969774/opiniones_de_jefazo_uzr0tc.jpg',
   9, 3),
  ('Sebas que recomiendas',
   'Frase dicha por Carlos Chavez cada que consultaba acerca de recomendaciones de un producto o videojuego a Sebas',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749971470/Sebas_que_recomiendas_munl4b.jpg',
   6, 3),
  ('Brandon Tavares',
   'Streamer de TikTok, antagonista de los negroides y mano derecha de Alfred en Live and Play',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749973134/brandon_tavares_joltae.jpg',
   12, 3),
  ('Planas',
   'Castigo impuesto por Bbno$ si decias una groseria y te escuchaba',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749971208/planas_c74w1s.jpg',
   13, 3),
  ('18.83',
   'Frase dicha por el hijo de Ctrl O luego de no fijarse lo que preguntaba el examen y las respuestas',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749970388/18.83_xkv8ug.jpg',
   14, 3),
  ('Mira las stats we',
   'Mira las stats we',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749971712/mira_las_stats_we_cjepvp.jpg',
   15, 3),
  ('boiler',
   'Esta persona no suele peinarse asi que cuando llega al salon se dice que parece que le exploto un boiler',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749969948/boiler_rxuhby.jpg',
   16, 3),
  ('moi',
   'Personaje del ano 1 que solo se dedicaba a apostar en clases y a no hacer nada en el equipo de Jefazo',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749969213/moi_wvo1md.jpg',
   17, 3),
  ('MQA',
   'Formato de audio muerto de la mas alta calidad y solo conocido por los audiofilos y gente que se la vive en Reddit',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749970197/mqa_mnboak.jpg',
   6, 3),
  ('Acordeon',
   'A Diego se le ocurrio la brillante idea de sacar un acordeon tamano carta de varias paginas quriendolo hacer pasar por un formulario motivo que le costo la cancelacion del examen y el recurso de la materia',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749970966/acordeon_grcxfn.jpg',
   18, 3),
-- Nivel 4
  ('CPOL',
   'Esto es lo que pasa cuando no te aguantas las ganas de orinar y lo haces en la via publica',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749970811/CPOL_ykpqaf.jpg',
   11, 4),
  ('Joaquin',
   'Amigo de Carlos y personaje recurrente en el lore de los negroides',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749969707/Joaquin_sxnfto.jpg',
   19, 4),
  ('Biomedica',
   'Durante el tiempo que ingenieria en software compartio salon con esta carrera no dejaban de llover quejas acerca de la suciedad y la basura dejada',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749970900/biomedica_vfz3or.jpg',
   2, 4),
  ('naik',
   'naik',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749973202/%C3%B1aik_qfiprd.jpg',
   6, 4),
  ('Ay peter',
   'Frase recuperada del arreglo de jergas de Jefazo por Max ya que era el dialogo por defecto cada que algo pasaba',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749969427/ay_peter_ulkuqi.jpg',
   11, 4),
  ('Perro o perra',
   'Pregunta hecha frecuentemente a manera de apuesta por Solis cada que veia un video de canes en Instagram',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749970756/perro_o_perra_cm6zfp.jpg',
   16, 4),
  ('No pues es la realidad',
   'Frase dicha por Alvaro luego de que le informaran de que reprobo el semestre',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749969537/no_pues_es_la_realidad_ve2hvq.jpg',
   20, 4),
  ('gatita ayuda',
   'Juego de rol desarrollado entre una inteligencia artificial que se fue de las manos',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749970514/gatita_ayuda_i9m6dj.jpg',
   11, 4),
  ('Palafox',
   'Personaje que nunca asistia a clases y luego ascendio a Jefe Academico solo para dejar la universidad luego de 2 meses',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749969453/palafox_mdw20t.jpg',
   2, 4),
  ('Francachella',
   'Dinamica de Francachella en la Salle protagonizada por Max',
   'https://res.cloudinary.com/ddfg5b0z1/image/upload/v1749973198/francachella_refktw.jpg',
   11, 4)
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