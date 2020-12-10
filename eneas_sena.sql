CREATE DATABASE netflix_filme;
USE netflix_filme;

-- CRIAÇÃO DA TABLE FILME
CREATE TABLE IF NOT EXISTS filme
(
	id_filme int NOT NULL AUTO_INCREMENT,
	nome_filme VARCHAR(255) NOT NULL,
	duracao TIME NOT NULL,
	ano_lancamento int NOT NULL,
	avaliacao INT NOT NULL,
	PRIMARY KEY(id_filme)
);

 
-- CRIAÇÃO DA TABELA CATEGORIA
CREATE TABLE IF NOT EXISTS categoria 
(
	id_categoria INT NOT NULL AUTO_INCREMENT,
	categoria_filme VARCHAR(50) NOT NULL,
	PRIMARY KEY(id_categoria)
);

-- CRIAÇÃO DA TABLE CATEGORIA_FILME
CREATE TABLE IF NOT EXISTS categoria_filme (
	fk_filme INT NOT NULL,
	fk_categoria INT NOT NULL,
	FOREIGN KEY(fk_filme) REFERENCES filme ( id_filme )
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(fk_categoria) REFERENCES categoria( id_categoria )
	ON DELETE CASCADE ON UPDATE CASCADE
);

-- CRIAÇÃO DA TABLE ELENCO
CREATE TABLE IF NOT EXISTS participante
(
	id_participante INT NOT NULL AUTO_INCREMENT,
	participacao VARCHAR(50) NOT NULL,
	genero_participante VARCHAR(10) NOT NULL,
	nome_participante VARCHAR(255) NOT NULL,
	ano_nascimento_participante DATE NOT NULL,
    PRIMARY KEY(id_participante)
);

-- CRIAÇÃO DA TABLE personagem
CREATE TABLE IF NOT EXISTS personagem
(
	id_personagem INT NOT NULL AUTO_INCREMENT,
	fk_participante INT NOT NULL,
	fk_filme INT NOT NULL,
	papel_personagem VARCHAR(255) NOT NULL,
	ano_atuacao INT NOT NULL,
    PRIMARY KEY(id_personagem),
    FOREIGN KEY(fk_participante) REFERENCES participante(id_participante)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(fk_filme) REFERENCES filme(id_filme)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- CRIAÇÃO DA TABLE DIRETOR_FILME
CREATE TABLE IF NOT EXISTS diretor_filme
(
	fk_diretor INT NOT NULL,
	fk_filme INT NOT NULL,
    FOREIGN KEY(fk_diretor) REFERENCES participante (id_participante)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(fk_filme) REFERENCES filme(id_filme)
    ON DELETE CASCADE ON UPDATE CASCADE
);

 	
-- procedure
-- cração da procedure de inserssão de filmes
DELIMITER $$
CREATE PROCEDURE PROC_IN_FILME
(
    IN nome_filme VARCHAR(255), 
	IN duracao TIME,
    IN ano_lancamento INT, 
	IN avaliacao INT
)
BEGIN
	INSERT INTO filme VALUES(DEFAULT, nome_filme, duracao, ano_lancamento, avaliacao);
END$$
DELIMITER ;


-- PROC UPDATE FILMES
DELIMITER $$
CREATE PROCEDURE PROC_UP_FILME
(
	IN id_update INT, 
	IN nome_filme VARCHAR(255),
    IN duracao TIME,  
	IN ano_lancamento INT,
    IN avaliacao INT
)
BEGIN
	UPDATE filmes
	SET nome_filme=nome_filme, duracao=duracao, ano_lancamento=ano_lancamento, avaliacao= avaliacao
	WHERE id_filme = id_update;
END$$
DELIMITER ;

-- crianção da procedure de inserssão de PARTICIPANTES 
DELIMITER //
CREATE PROCEDURE `PROC_IN_PARTICIPANTE`(
	IN participacao VARCHAR(50), 
	IN genero_participante VARCHAR(10),
	IN nome_participante VARCHAR(255), 
	IN ano_nascimento_participante DATE
)
BEGIN
	INSERT INTO participante VALUES 
	(DEFAULT, participacao, genero_participante, nome_participante, ano_nascimento_participante);
END//
DELIMITER ;

-- PROC UPDATE PARTICIPANTES
DELIMITER $$
CREATE PROCEDURE `PROC_UP_PARTICIPANTE`(
	IN id_update INT, 
	IN participacao VARCHAR(50) ,
	IN genero_participante VARCHAR(10),  
	IN nome_participante VARCHAR(255),
	IN ano_nascimento_participante DATE 
)
BEGIN
	UPDATE participante
	SET participacao=participacao, genero_participante=genero_participante, nome_participante=nome_participante, ano_nascimento_participante=ano_nascimento_participante
	WHERE  id_participante = id_update;
END$$
DELIMITER ;

-- inserindo diretor um filme
DELIMITER $$
CREATE PROCEDURE `PROC_IN_DIRETOR`(
	IN fk_diretor INT,
	IN fk_filme INT 
)
BEGIN
	SET @iddiretor = fk_diretor;
	SET @idfilme = fk_filme;
	INSERT INTO diretor_filme VALUES (@iddiretor, @idfilme);
END$$
DELIMITER ;

-- inserssão da categoria 
DELIMITER //
CREATE PROCEDURE `PROC_IN_CATEGORIA`( categoria_filme VARCHAR(255) )
BEGIN
	INSERT INTO categoria VALUES (DEFAULT, categoria_filme);
END//
DELIMITER ;

-- PROC UPDATE CATEGORIA
DELIMITER //
CREATE PROCEDURE `PROC_UP_CATEGORIA`( idupdate INT, categoria_filme VARCHAR(255) )
BEGIN
	UPDATE categoria 
	SET categoria_filme=categoria_filme
	WHERE id_categoria = idupdate;
END//
DELIMITER ;



-- inserssão da categoria a qual o filme pertence
DELIMITER //
CREATE PROCEDURE `PROC_IN_CATEGORIA_FILME`( fk_filme INT, fk_categoria INT  )
BEGIN
	INSERT INTO categoria_filme VALUES (fk_filme, fk_categoria);    
END//
DELIMITER ;

-- inserssão dos papeis de cada elenco
DELIMITER //
CREATE PROCEDURE `PROC_IN_PERSONAGEM`( 
	IN fk_participante INT, 
    IN fk_filme INT, 
    IN papel_personagem VARCHAR(255), 
	IN ano_atuacao INT
)
BEGIN
	INSERT INTO personagem VALUES 
	(DEFAULT, fk_participante, fk_filme, papel_personagem, ano_atuacao);    
END//
DELIMITER ;

-- proc update papeis filme
DELIMITER //
CREATE PROCEDURE `PROC_UP_PERSONAGEM`( 
	IN idupdate INT,
	IN fk_participante INT, 
    IN fk_filme INT, 
    IN papel_personagem VARCHAR(255), 
	IN ano_atuacao INT
)
BEGIN
	UPDATE personagem
	SET fk_participante=fk_participante, fk_filme=fk_filme, papel_personagem=papel_personagem, ano_atuacao=ano_atuacao
	WHERE id_personagem = idupdate;
END//
DELIMITER ;

-- -----------------------------------------------------------
-- INSERSSÃO DE GÊNRENOS 

-- -----------------------------------------------------------
CALL PROC_IN_CATEGORIA('Drama'); -- 1
CALL PROC_IN_CATEGORIA('Comédia');-- 2
CALL PROC_IN_CATEGORIA('Faroeste');-- 3
CALL PROC_IN_CATEGORIA('Guerra');-- 4
CALL PROC_IN_CATEGORIA('Ação');-- 5
CALL PROC_IN_CATEGORIA('Suspense');-- 6
CALL PROC_IN_CATEGORIA('Policial');-- 7
CALL PROC_IN_CATEGORIA('Thriller');-- 8
CALL PROC_IN_CATEGORIA('Crime');-- 9
CALL PROC_IN_CATEGORIA('Documentário');-- 10
CALL PROC_IN_CATEGORIA('Família');-- 11
CALL PROC_IN_CATEGORIA('Aventura');-- 12
CALL PROC_IN_CATEGORIA('Música');-- 13
CALL PROC_IN_CATEGORIA('Fantasia');-- 14
CALL PROC_IN_CATEGORIA('Romance');-- 15 
CALL PROC_IN_CATEGORIA('Terror');-- 16
CALL PROC_IN_CATEGORIA('História');-- 17
CALL PROC_IN_CATEGORIA('Action');-- 18
CALL PROC_IN_CATEGORIA('Adventure');-- 19
CALL PROC_IN_CATEGORIA('Sci-Fi');-- 20
CALL PROC_IN_CATEGORIA('Fantasy');-- 21
CALL PROC_IN_CATEGORIA('Mistério');-- 22

-- -----------------------------------------------------------
-- INSERSSÃO DE FILMES
-- -----------------------------------------------------------
CALL PROC_IN_FILME('À PROVA DE MORTE', '01:50:00', 2010, 68); -- 1
CALL PROC_IN_FILME('SIN CITY - A CIDADE DO PECADO', '02:03:00', 2005, 74); -- 2
CALL PROC_IN_FILME('KILL BILL - VOLUME 2', '02:15:00', 2004, 79); -- 3
CALL PROC_IN_FILME('KILL BILL - VOLUME 1', '01:52:00', 2004, 80); -- 4
CALL PROC_IN_FILME('Jackie Brown', '02:34:00', 1997, 73); -- 5
CALL PROC_IN_FILME('Cães de Aluguel', '01:39:00', 1992, 82); -- 6
CALL PROC_IN_FILME('Lo sguardo della musica', '01:30:00', 2020, 53); -- 7
CALL PROC_IN_FILME('Method to the Madness of Jerry Lewis', '01:55:00', 2011, 58); -- 8
CALL PROC_IN_FILME("The Muppets' Wizard of Oz", '01:41:00', 2005, 50); -- 9
CALL PROC_IN_FILME('Little Nicky, Um Diabo Diferente', '01:30:00', 2000, 57); -- 10
CALL PROC_IN_FILME('Se Beber, Não Case!', '01:40:00', 2009, 73); -- 11
CALL PROC_IN_FILME('Se Beber, Não Case! Parte II', '01:42:00', 2011, 64); -- 12
CALL PROC_IN_FILME('Se Beber, Não Case! Parte III', '01:40:00', 2013, 62); -- 13
CALL PROC_IN_FILME('Hard Kill', '01:38:00', 2020, 51); -- 14
CALL PROC_IN_FILME('Convenção das Bruxas', '01:46:00', 2020, 69); -- 15
CALL PROC_IN_FILME('Fatman', '01:40:00', 2020, 60); -- 16
CALL PROC_IN_FILME('O Irlandês', '03:29:00', 2019, 77); -- 17
CALL PROC_IN_FILME('Coringa', '02:02:00', 2019, 82); -- 18
CALL PROC_IN_FILME('Dupla Explosiva', '01:58:00', 2017, 68); -- 19
CALL PROC_IN_FILME('xXx: Reativado', '01:58:00', 2017, 57); -- 20
CALL PROC_IN_FILME('FBI', '00:43:00', 2018, 77); -- 21
CALL PROC_IN_FILME('Game of Thrones', '01:00:00', 2011, 83); -- 22
CALL PROC_IN_FILME('Uma Invenção de Natal', '01:59:00', 2020, 70); -- 23
CALL PROC_IN_FILME('Crônicas de Natal: Parte Dois', '01:52:00', 2020, 72); -- 24
CALL PROC_IN_FILME('Diários de um Vampiro', '00:43:00', 2009, 83); -- 25
CALL PROC_IN_FILME('Vikings', '00:44:00', 2013, 79); -- 26
CALL PROC_IN_FILME('Enola Holmes', '02:03:00', 2020, 75); -- 27
CALL PROC_IN_FILME('O Senhor dos Anéis: A Sociedade do Anel', '02:59:00', 2001, 83); -- 28
CALL PROC_IN_FILME('The Boys', '01:00:00', 2019, 85); -- 29
CALL PROC_IN_FILME('The Walking Dead', '00:42:00', 2010, 79); -- 30
CALL PROC_IN_FILME('Fear the Walking Dead', '00:43:00', 2015, 75); -- 31


-- -----------------------------------------------------------
-- INSERT DE CATEGORIA DOS FILMES 

-- -----------------------------------------------------------
CALL PROC_IN_CATEGORIA_FILME(1, 1);
CALL PROC_IN_CATEGORIA_FILME(1, 2);
CALL PROC_IN_CATEGORIA_FILME(1,6);
CALL PROC_IN_CATEGORIA_FILME(2,5);
CALL PROC_IN_CATEGORIA_FILME(2,6);
CALL PROC_IN_CATEGORIA_FILME(2,7);
CALL PROC_IN_CATEGORIA_FILME(3,5);
CALL PROC_IN_CATEGORIA_FILME(3,6);
CALL PROC_IN_CATEGORIA_FILME(4,5);
CALL PROC_IN_CATEGORIA_FILME(4,6);
CALL PROC_IN_CATEGORIA_FILME(5,9);
CALL PROC_IN_CATEGORIA_FILME(5,8);
CALL PROC_IN_CATEGORIA_FILME(5,1);
CALL PROC_IN_CATEGORIA_FILME(6,9);
CALL PROC_IN_CATEGORIA_FILME(6,8);
CALL PROC_IN_CATEGORIA_FILME(7,10);
CALL PROC_IN_CATEGORIA_FILME(8,10);
CALL PROC_IN_CATEGORIA_FILME(9,11);
CALL PROC_IN_CATEGORIA_FILME(9,12);
CALL PROC_IN_CATEGORIA_FILME(9,2);
CALL PROC_IN_CATEGORIA_FILME(9,13);
CALL PROC_IN_CATEGORIA_FILME(9,14);
CALL PROC_IN_CATEGORIA_FILME(10,2);
CALL PROC_IN_CATEGORIA_FILME(10,14);
CALL PROC_IN_CATEGORIA_FILME(10,15);
CALL PROC_IN_CATEGORIA_FILME(10,16);
CALL PROC_IN_CATEGORIA_FILME(11,2);
CALL PROC_IN_CATEGORIA_FILME(12,2);
CALL PROC_IN_CATEGORIA_FILME(13,2);
CALL PROC_IN_CATEGORIA_FILME(14,5);
CALL PROC_IN_CATEGORIA_FILME(14,8);
CALL PROC_IN_CATEGORIA_FILME(15,11);
CALL PROC_IN_CATEGORIA_FILME(15,14);
CALL PROC_IN_CATEGORIA_FILME(15,12);
CALL PROC_IN_CATEGORIA_FILME(15,2);
CALL PROC_IN_CATEGORIA_FILME(16,5);
CALL PROC_IN_CATEGORIA_FILME(16,2);
CALL PROC_IN_CATEGORIA_FILME(16,14);
CALL PROC_IN_CATEGORIA_FILME(17,9);
CALL PROC_IN_CATEGORIA_FILME(17,1);
CALL PROC_IN_CATEGORIA_FILME(17,17);
CALL PROC_IN_CATEGORIA_FILME(18,9);
CALL PROC_IN_CATEGORIA_FILME(18,8);
CALL PROC_IN_CATEGORIA_FILME(18,1);
CALL PROC_IN_CATEGORIA_FILME(19,8);
CALL PROC_IN_CATEGORIA_FILME(19,2);
CALL PROC_IN_CATEGORIA_FILME(19,9);
CALL PROC_IN_CATEGORIA_FILME(19,5);
CALL PROC_IN_CATEGORIA_FILME(20,5);
CALL PROC_IN_CATEGORIA_FILME(20,12);
CALL PROC_IN_CATEGORIA_FILME(20,9);
CALL PROC_IN_CATEGORIA_FILME(21,9);
CALL PROC_IN_CATEGORIA_FILME(21,1);
CALL PROC_IN_CATEGORIA_FILME(21,18);
CALL PROC_IN_CATEGORIA_FILME(21,19);
CALL PROC_IN_CATEGORIA_FILME(22,20);
CALL PROC_IN_CATEGORIA_FILME(22,21);
CALL PROC_IN_CATEGORIA_FILME(22,1);
CALL PROC_IN_CATEGORIA_FILME(22,18);
CALL PROC_IN_CATEGORIA_FILME(22,19);
CALL PROC_IN_CATEGORIA_FILME(22,22);
CALL PROC_IN_CATEGORIA_FILME(23,11);
CALL PROC_IN_CATEGORIA_FILME(23,14);
CALL PROC_IN_CATEGORIA_FILME(23,13);
CALL PROC_IN_CATEGORIA_FILME(24,11);
CALL PROC_IN_CATEGORIA_FILME(24,14);
CALL PROC_IN_CATEGORIA_FILME(24,19);
CALL PROC_IN_CATEGORIA_FILME(25,1);
CALL PROC_IN_CATEGORIA_FILME(25,14);
CALL PROC_IN_CATEGORIA_FILME(25,16);
CALL PROC_IN_CATEGORIA_FILME(25,15);
CALL PROC_IN_CATEGORIA_FILME(26,18);
CALL PROC_IN_CATEGORIA_FILME(26,19);
CALL PROC_IN_CATEGORIA_FILME(26,1);
CALL PROC_IN_CATEGORIA_FILME(27,9);
CALL PROC_IN_CATEGORIA_FILME(27,1);
CALL PROC_IN_CATEGORIA_FILME(27,22);
CALL PROC_IN_CATEGORIA_FILME(28,12);
CALL PROC_IN_CATEGORIA_FILME(28,14);
CALL PROC_IN_CATEGORIA_FILME(28,5);
CALL PROC_IN_CATEGORIA_FILME(29,20);
CALL PROC_IN_CATEGORIA_FILME(29,21);
CALL PROC_IN_CATEGORIA_FILME(29,18);
CALL PROC_IN_CATEGORIA_FILME(29,19);
CALL PROC_IN_CATEGORIA_FILME(30,18);
CALL PROC_IN_CATEGORIA_FILME(30,19);
CALL PROC_IN_CATEGORIA_FILME(30,1);
CALL PROC_IN_CATEGORIA_FILME(30,20);
CALL PROC_IN_CATEGORIA_FILME(30,21);
CALL PROC_IN_CATEGORIA_FILME(31,18);
CALL PROC_IN_CATEGORIA_FILME(31,19);
CALL PROC_IN_CATEGORIA_FILME(31,1);

-- -----------------------------------------------------------
-- inserts dos elenco
--  INSERT DOS ELENCOS(A) / DIRETORES(A)
-- -----------------------------------------------------------
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Quentin Tarantino','1963-04-27');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','KURT RUSSELL','1951-03-17');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','ROSARIO DAWSON','1979-05-09');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','ZOË BELL','1978-11-17');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Walter Bruce Willis','1955-03-19');		
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','MICKEY ROURKE','1952-07-16');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','JESSICA ALBA','1981-03-28');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','UMA THURMAN','1970-04-29');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','DAVID CARRADINE','2009-06-03');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','MICHAEL MADSEN','1957-07-25');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Vivica A. Fox','1964-07-30');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','LUCY LIU','1968-12-02');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Samuel L. Jackson','1948-12-21');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Robert De Niro','1943-08-17');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Bridget Fonda','1964-01-27');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Chris Penn','1965-10-10');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Michael Madsen','1957-09-25');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Tim Roth','1961-05-14');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Giuseppe Tornatore','1956-05-27');		
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Ennio Morricone','1928-11-10');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Bernardo Bertolucci','1940-03-16');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Gregg Barson','1944-08-04');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Alec Baldwin','1958-04-03');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Carol Burnett','1933-04-26');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Kirk R. Thatcher','1955-06-30');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Queen Latifah','1970-03-18');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Ashanti','1980-10-13');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Steven Brill','1962-05-27'); 
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Patricia Arquette','1968-04-08'); 
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Adam Sandle	','1958-04-08'); 	
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Todd Phillips','1970-12-20');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Bradley Cooper','1975-01-05');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Ed Helms','1974-01-24');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Heather Graham','1970-01-29');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Ken Jeong','1969-07-13');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','John Goodman','1968-04-15');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Matt Eskandari','1970-12-20');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Natalie Eva Marie','1984-09-19');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Lala Kent','1990-04-06');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Robert Zemeckis','1970-12-20');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Anne Hathaway','1982-11-12');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Octavia Spencer','1972-05-25');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Stanley Tucci','1960-11-11');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Ian Nelms','1970-12-20');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Marianne Jean-Baptiste','1967-04-26');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Shaun Benson','1976-01-16');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Paulino Nunes','1968-04-27');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Martin Scorsese','1942-11-17');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Aleksa Palladino','1980-09-21');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Dascha Polanco','1982-01-01');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Joaquin Phoenix','1974-10-28');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Zazie Beetz','1991-06-01');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Patrick Hughes','1957-10-27');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Ryan Reynolds','1976-10-23');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Gary Oldman','1958-03-21');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Rich Wilkes','1977-06-13');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Tony Jaa','1976-02-05');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Vin Diesel','1967-07-18');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Dick Wolf','1946-12-20');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Missy Peregrym','1982-06-16');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Alana de la Garza','1976-06-18');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Jeremy Sisto','1974-10-06');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','David Benioff','1970-09-25');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Lena Headey','1973-10-03');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Sophie Turner','1996-02-21');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Peter Dinklage','1969-06-11');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','David E. Talbert','1966-02-10');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Chris Columbus','1958-09-10');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Kevin Williamson','1965-03-14');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Ian Somerhalder','1978-12-08');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Candice King','1987-05-13');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Zach Roerig','1985-02-22');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Michael Hirst','1952-09-21');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Katheryn Winnick','1977-12-17');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Harry Bradbeer','1983-05-05');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Peter Jackson','1961-10-31');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Eric Kripke','1974-04-24');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Frank Darabont','1959-01-28');
CALL PROC_IN_PARTICIPANTE('Ator','Masculino','Norman Reedus','1969-01-06');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Melissa McBride','1965-05-23');
CALL PROC_IN_PARTICIPANTE('Atriz','Feminino','Lauren Cohan','1982-01-07');
CALL PROC_IN_PARTICIPANTE('Diretor','Masculino','Dave Erickson','1969-11-28');



-- -----------------------------------------------------------
-- INSERT DE DIRETORES DOS FILMES
-- -----------------------------------------------------------
CALL PROC_IN_DIRETOR(1,1);
CALL PROC_IN_DIRETOR(1,2);
CALL PROC_IN_DIRETOR(1,3);
CALL PROC_IN_DIRETOR(1,4);
CALL PROC_IN_DIRETOR(1,5);
CALL PROC_IN_DIRETOR(1,6);
CALL PROC_IN_DIRETOR(19,7);
CALL PROC_IN_DIRETOR(22,8);
CALL PROC_IN_DIRETOR(25,9);
CALL PROC_IN_DIRETOR(28,10);
CALL PROC_IN_DIRETOR(31,11);
CALL PROC_IN_DIRETOR(31,12);
CALL PROC_IN_DIRETOR(31,13);
CALL PROC_IN_DIRETOR(31,18);
CALL PROC_IN_DIRETOR(37,14);
CALL PROC_IN_DIRETOR(40,15);
CALL PROC_IN_DIRETOR(44,16);
CALL PROC_IN_DIRETOR(48,17);
CALL PROC_IN_DIRETOR(53,19);
CALL PROC_IN_DIRETOR(56,20);
CALL PROC_IN_DIRETOR(59,21);
CALL PROC_IN_DIRETOR(63,22);
CALL PROC_IN_DIRETOR(67,23);
CALL PROC_IN_DIRETOR(68,24);
CALL PROC_IN_DIRETOR(69,25);
CALL PROC_IN_DIRETOR(73,26);
CALL PROC_IN_DIRETOR(75,27);
CALL PROC_IN_DIRETOR(76,28);
CALL PROC_IN_DIRETOR(77,29);
CALL PROC_IN_DIRETOR(78,30);
CALL PROC_IN_DIRETOR(82,31);


-- -----------------------------------------------------------
-- INSERT DE PAPEIS DE ELENCO NOS FILMES
-- -----------------------------------------------------------
CALL PROC_IN_PERSONAGEM(2,1,'Stuntman Mike',2010);
CALL PROC_IN_PERSONAGEM(3,1,'Abernathy',2010);
CALL PROC_IN_PERSONAGEM(4,1,'Zoe',2010);
CALL PROC_IN_PERSONAGEM(5,2,'John Hartigan',2005);
CALL PROC_IN_PERSONAGEM(6,2,'Marv',2005);
CALL PROC_IN_PERSONAGEM(7,2,'Nancy',2005);
CALL PROC_IN_PERSONAGEM(8,3,'A Noiva',2004);
CALL PROC_IN_PERSONAGEM(9,3,'Bill',2004);
CALL PROC_IN_PERSONAGEM(10,3,'Budd/Sidewinder',2004);
CALL PROC_IN_PERSONAGEM(8,4,'A Noiva',2004);
CALL PROC_IN_PERSONAGEM(11,4,'Vernita Green',2004);
CALL PROC_IN_PERSONAGEM(12,4,'Herself',2004);
CALL PROC_IN_PERSONAGEM(13,5,'Ordell Robbie',1997);
CALL PROC_IN_PERSONAGEM(14,5,'Louis Gara',1997);
CALL PROC_IN_PERSONAGEM(15,5,'Melanie Ralston',1997);
CALL PROC_IN_PERSONAGEM(16,6,'"Nice Guy" Eddie Cabot',1992);
CALL PROC_IN_PERSONAGEM(17,6,'Mr. Blonde / Vic Vega',1992);
CALL PROC_IN_PERSONAGEM(18,6,'Mr. Orange / Freddy Newandyke',1992);
CALL PROC_IN_PERSONAGEM(20,7,'Himself',2020);
CALL PROC_IN_PERSONAGEM(21,7,'Himself',2020);
CALL PROC_IN_PERSONAGEM(1,7,'Himself',2020);
CALL PROC_IN_PERSONAGEM(23,8,'Himself',2011);
CALL PROC_IN_PERSONAGEM(24,8,'Herself',2011);
CALL PROC_IN_PERSONAGEM(1,8,'Himself',2011);
CALL PROC_IN_PERSONAGEM(26,9,'Aunt Em',2005);
CALL PROC_IN_PERSONAGEM(27,9,'Dorothy Gale',2005);
CALL PROC_IN_PERSONAGEM(1,9,"Himself - Kermit's Director",2005);
CALL PROC_IN_PERSONAGEM(29,10,'Valerie Veran',2000);
CALL PROC_IN_PERSONAGEM(30,10,'Nicky',2000);
CALL PROC_IN_PERSONAGEM(1,10,'Deacon',2000);
CALL PROC_IN_PERSONAGEM(32,11,'Phil Wenneck',2009);
CALL PROC_IN_PERSONAGEM(33,11,'Stu Price',2009);
CALL PROC_IN_PERSONAGEM(34,11,'Jade',2009);
CALL PROC_IN_PERSONAGEM(33,12,'Stu Price',2011);
CALL PROC_IN_PERSONAGEM(34,12,'Jade',2011);
CALL PROC_IN_PERSONAGEM(35,12,'Mr. Chow',2011);
CALL PROC_IN_PERSONAGEM(33,13,'Stu Price',2013);
CALL PROC_IN_PERSONAGEM(34,13,'Jade',2013);
CALL PROC_IN_PERSONAGEM(36,13,'Marshall',2013);
CALL PROC_IN_PERSONAGEM(5,14,'Chalmers',2020);
CALL PROC_IN_PERSONAGEM(38,14,'Sasha',2020);
CALL PROC_IN_PERSONAGEM(39,14,'Eva Chalmers',2020);
CALL PROC_IN_PERSONAGEM(41,15,'Grand High Witch',2020);
CALL PROC_IN_PERSONAGEM(42,15,'Grandma',2020);
CALL PROC_IN_PERSONAGEM(43,15,'Mr Stringer',2020);
CALL PROC_IN_PERSONAGEM(45,16,'Ruth',2020);
CALL PROC_IN_PERSONAGEM(46,16,'Lex',2020);
CALL PROC_IN_PERSONAGEM(47,16,'Weyland Meeks',2020);
CALL PROC_IN_PERSONAGEM(14,17,'Frank Sheeran',2019);
CALL PROC_IN_PERSONAGEM(49,17,'Mary Sheeran',2019);
CALL PROC_IN_PERSONAGEM(50,17,'Nurse',2019);
CALL PROC_IN_PERSONAGEM(14,18,'Frank Sheeran',2019);
CALL PROC_IN_PERSONAGEM(51,18,'Arthur Fleck / Joker',2019);
CALL PROC_IN_PERSONAGEM(52,18,'Sophie Dumond',2019);
CALL PROC_IN_PERSONAGEM(13,19,'Darius Kincaid',2017);
CALL PROC_IN_PERSONAGEM(54,19,'Michael Bryce',2017);
CALL PROC_IN_PERSONAGEM(55,19,'Vladislav Dukhovich',2017);
CALL PROC_IN_PERSONAGEM(13,20,'Agent Augustus Gibbons',2017);
CALL PROC_IN_PERSONAGEM(57,20,'Talon',2017);
CALL PROC_IN_PERSONAGEM(58,20,'Xander Cage',2017);
CALL PROC_IN_PERSONAGEM(60,21,'Maggie Bell',2018);
CALL PROC_IN_PERSONAGEM(61,21, 'Isobel Castille',2018);
CALL PROC_IN_PERSONAGEM(62,21,'Jubal Valentine',2018);
CALL PROC_IN_PERSONAGEM(64,22,'Cersei Lannister',2011);
CALL PROC_IN_PERSONAGEM(65,22,'Sansa Stark',2011);
CALL PROC_IN_PERSONAGEM(66,22,'Tyrion Lannister',2011);
CALL PROC_IN_PERSONAGEM(64,23,'Jessica',2020);
CALL PROC_IN_PERSONAGEM(65,23,'Grandmother Journey',2020);
CALL PROC_IN_PERSONAGEM(66,23,'Jeronicus Jangle',2020);
CALL PROC_IN_PERSONAGEM(64,24,'Belsnickel',2020);
CALL PROC_IN_PERSONAGEM(65,24,'Mrs. Claus',2020);
CALL PROC_IN_PERSONAGEM(66,24,'Santa Claus',2020);
CALL PROC_IN_PERSONAGEM(70,25,'Damon Salvatore',2009);
CALL PROC_IN_PERSONAGEM(71,25,'Caroline Forbes',2009);
CALL PROC_IN_PERSONAGEM(72,25,'Matt Donovan',2009);
CALL PROC_IN_PERSONAGEM(74,26,'Lagertha Lothbrok',2013);
CALL PROC_IN_PERSONAGEM(72,26,'Torvi',2013);
CALL PROC_IN_PERSONAGEM(71,26,'Hvitserk Lothbrok',2013);
CALL PROC_IN_PERSONAGEM(74,27,'Enola Holmes',2020);
CALL PROC_IN_PERSONAGEM(71,27,'Eudoria Holmes',2020);
CALL PROC_IN_PERSONAGEM(72,27,'Sherlock Holmes',2020);
CALL PROC_IN_PERSONAGEM(74,28,'Arwen',2001);
CALL PROC_IN_PERSONAGEM(71,28,'Galadriel',2001);
CALL PROC_IN_PERSONAGEM(72,28,'Gandalf',2001);
CALL PROC_IN_PERSONAGEM(74,29,'Annie January / Starlight',2019);
CALL PROC_IN_PERSONAGEM(71,29,'Queen Maeve',2019);
CALL PROC_IN_PERSONAGEM(72,29,'Homelander',2019);
CALL PROC_IN_PERSONAGEM(79,30,'Daryl Dixon',2010);
CALL PROC_IN_PERSONAGEM(80,30,'Carol Peletier',2010);
CALL PROC_IN_PERSONAGEM(81,30,'Maggie, Maggie Greene',2010);
CALL PROC_IN_PERSONAGEM(79,31,'Victor Strand',2015);
CALL PROC_IN_PERSONAGEM(80,31,'Alicia Clark',2015);
CALL PROC_IN_PERSONAGEM(81,31,'Madison Clark',2015);



-- -----------------------
-- 		CREATE VIEWS
-- -----------------------

--  -------------------------------------------------------------------------------------------
-- Liste os 10 atores ou atrizes com maior número de papéis em filmes do gênero Crime e a
-- quantidade total de papéis deles nesses filmes.
--  -------------------------------------------------------------------------------------------
CREATE VIEW vw_consulta_atores_papeis AS
	SELECT participante.nome_participante AS 'nome atores', 
		participante.genero_participante, 
		count(personagem.papel_personagem) AS "Total Papeis", 
		categoria.categoria_filme
	FROM categoria_filme
	JOIN filme ON categoria_filme.fk_filme = filme.id_filme
	JOIN categoria ON categoria_filme.fk_categoria = categoria.id_categoria
	JOIN personagem ON categoria_filme.fk_filme = personagem.fk_filme
	JOIN participante ON personagem.fk_participante = participante.id_participante
	where categoria.categoria_filme = "Crime"
	GROUP BY personagem.fk_participante
	ORDER BY count(*) DESC
	LIMIT 10;
-- chamada para a view vw_consulta_atores_papeis
-- SELECT * FROM vw_consulta_atores_papeis;

--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
-- Para cada gênero, liste o nome do gênero e a quantidade de filmes desse gênero. Ordene pela
-- quantidade de maneira crescente.
--  ----- CREATE VIEW -------------------------------------------------------------------------
CREATE VIEW vw_genero_filmes_count AS
	SELECT categoria.categoria_filme, count(categoria.categoria_filme) AS 'Total Genero'
	FROM categoria_filme
	JOIN categoria ON categoria_filme.fk_categoria = categoria.id_categoria
	JOIN filme ON categoria_filme.fk_filme = filme.id_filme
	GROUP BY categoria.categoria_filme
	ORDER BY count(filme.id_filme);
-- chamada para a view vw_genero_filmes_count
-- SELECT * FROM vw_genero_filmes_count;
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
/*Liste o nome dos filmes em que Quentin Tarantino atuou (lembre-se que existem filmes no qual
ele atuou e é diretor, filmes em que ele é apenas diretor e filmes em que ele apenas atuou) e o nome
do papel em cada um deles.*/
--  ----- CREATE VIEW --------------------------------------------------------------------------
CREATE VIEW vw_buscar_atuacao_diretor AS
	SELECT filme.nome_filme FROM personagem
	JOIN filme ON personagem.fk_filme = filme.id_filme
	JOIN participante ON personagem.fk_participante = participante.id_participante
	WHERE participante.nome_participante = "Quentin Tarantino"
	ORDER BY filme.nome_filme ASC;
-- chamada para a view vw_buscar_atuacao_diretor
-- SELECT * FROM vw_buscar_atuacao_diretor;
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
/*Sobre a trilogia do filme Se Beber Não Case, liste o nome dos filmes da trilogia, o nome das
pessoas que trabalharam nos filmes, bem como o nome do papel que cada um desempenhou e o
tipo do papel. Ordene pelo ano de produção em ordem crescente*/
--  ----- CREATE VIEW --------------------------------------------------------------------------
CREATE VIEW view_bebo_nao_dirige AS
	SELECT filme.nome_filme, participante.nome_participante, personagem.papel_personagem, personagem.ano_atuacao
	FROM personagem
	JOIN filme ON personagem.fk_filme = filme.id_filme
	JOIN participante ON personagem.fk_participante = participante.id_participante
	WHERE filme.nome_filme LIKE "Se Beber, Não Case!%"
	ORDER BY personagem.ano_atuacao DESC;
-- chamada para a view view_bebo_nao_dirige
-- SELECT * FROM view_bebo_nao_dirige;
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
--  -------------------------------------------------------------------------------------------
/*Liste os nomes dos 10 atores ou atrizes que mais participaram de diferentes gêneros de filmes.
Liste também a quantidade de gêneros diferentes que cada um participou e ordene de forma
decrescente.*/
--  ----- CREATE VIEW --------------------------------------------------------------------------
CREATE VIEW view_atores_genero_filme AS
	SELECT participante.nome_participante, count(categoria.categoria_filme) AS 'total papeis atuados'
	FROM personagem
	JOIN filme ON personagem.fk_filme = filme.id_filme
	JOIN categoria_filme ON personagem.fk_filme = categoria_filme.fk_filme
    JOIN participante ON personagem.fk_participante = participante.id_participante
	JOIN categoria ON categoria_filme.fk_categoria = categoria.id_categoria
	GROUP BY personagem.fk_participante
	ORDER BY count(personagem.fk_participante) DESC LIMIT 10;
-- chamada para a view view_atores_genero_filme
-- SELECT * FROM view_atores_genero_filme;
--  -------------------------------------------------------------------------------------------

SELECT * FROM vw_consulta_atores_papeis;
SELECT * FROM vw_genero_filmes_count;
SELECT * FROM vw_buscar_atuacao_diretor;
SELECT * FROM view_bebo_nao_dirige;
SELECT * FROM view_atores_genero_filme;
 
 