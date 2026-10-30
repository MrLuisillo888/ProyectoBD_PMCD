DROP DATABASE IF EXISTS UTUBuceo; #RECORDAR ELIMINAR ESTO CUANDO ESTE DEFINITIVO EL PROYECTO
CREATE DATABASE UTUBuceo;
USE UTUBuceo;

CREATE TABLE Computadora(
	numMaquina 	INT 			NOT NULL,
    estado 	    VARCHAR(100)	NOT NULL, 
    descripcion VARCHAR(300)	NOT NULL,
    numeroLaboratorio INT		NOT NULL, #foring key
    
    CONSTRAINT comprobarEstados CHECK (estado IN ('funcional', 'disponible', 'averiada')),
    CONSTRAINT maquinaCLP
		PRIMARY KEY(numMaquina)
);

CREATE TABLE Laboratorio(
	numeroLab 		 INT 		 NOT NULL, #CLAVE PRIMARIA  -> FOREIGN KEY PARA Computadora
    cantComputadoras INT 		 NOT NULL,
    nombre			 VARCHAR(30) NOT NULL,  #numeroLab cantComputadoras nombre
    
    CONSTRAINT laboratorioClaves
		PRIMARY KEY(numeroLab)
);

ALTER TABLE Computadora  #AÑADE LA FOREIGN KEY (CLAVE EXTERNA) DE N°Lab
	ADD CONSTRAINT maquinaCLE
		FOREIGN KEY (numeroLaboratorio) 
		REFERENCES Laboratorio(numeroLab)
        ON DELETE CASCADE;
    
CREATE TABLE Funcionario(
	CI					 	 INT NOT NULL,
    Nombre 		  	 VARCHAR(30) NOT NULL,
    Apellido	  	 VARCHAR(30) NOT NULL,
	Fecha_nacimiento DATE		 NOT NULL,
	Calle 			 varchar(50) NOT NULL,
	N°Calle 		 INT		 NOT NULL, 
	CONSTRAINT funcionarioCLP
		PRIMARY KEY(CI)
);

CREATE TABLE Telefono(
	TELEFONO		INT NOT NULL,
    CI_Asistente    INT NOT NULL, 
    
    CONSTRAINT telefonoCLP
		PRIMARY KEY(TELEFONO)
);

CREATE TABLE Asistente_Laboratorio(

	CI_Asist INT 			NOT NULL,
	Nombre varchar(50)		NOT NULL,
	Apellido varchar(50)	NOT NULL,
	Turno varchar(50)		NOT NULL,
	MAIL VARCHAR(50)		NOT NULL,
	Fecha_nacimiento DATE 	NOT NULL,
	Calle varchar(50)		NOT NULL,
	N°Calle INT				NOT NULL,
	CONSTRAINT Cedula
		primary key(CI_Asist)
);

ALTER TABLE Telefono
	ADD CONSTRAINT telefonoCLE
		FOREIGN KEY (CI_Asistente) 
		REFERENCES Asistente_Laboratorio(CI_Asist)
        ON DELETE CASCADE;
        

CREATE TABLE Profesor (
	CI_Profesor INT 		NOT NULL,
	Nombre varchar(50)		NOT NULL,
	Apellido varchar(50)	NOT NULL,
	Materia varchar(50)		NOT NULL,
	Fecha_nacimiento DATE	NOT NULL,
	Calle varchar(50)		NOT NULL,
	N°Calle INT				NOT NULL,
	CONSTRAINT Cedula
		PRIMARY KEY(CI_Profesor)
);

CREATE TABLE GrupoProfesor(
	Grupo VARCHAR(10)		NOT NULL,
    CI_Profesor INT			NOT NULL,
    CONSTRAINT grupoProfesorCLP
		PRIMARY KEY (Grupo)
);

ALTER TABLE GrupoProfesor
	ADD CONSTRAINT GrupoProfeCLE
		FOREIGN KEY (CI_Profesor) 
		REFERENCES Profesor(CI_Profesor)
        ON DELETE CASCADE;
        
CREATE TABLE Alumno(
	CI_Alumno INT 			NOT NULL,
	Nombre varchar(50)		NOT NULL,
	Apellido varchar(50)	NOT NULL,
	Grupo varchar(50)		NOT NULL,
	Fecha_nacimiento DATE	NOT NULL,
	Calle varchar(50)		NOT NULL,
	N°Calle INT				NOT NULL,
    ProfesorCI INT 			NOT NULL,
	CONSTRAINT Cedula
		primary key(CI_Alumno)
);

ALTER TABLE Alumno
	ADD CONSTRAINT ProfesorAlumCLE
		FOREIGN KEY (ProfesorCI)
        REFERENCES Profesor(CI_Profesor)
        ON DELETE CASCADE;

CREATE TABLE Utiliza(
    CedulaAlumno  INT NOT NULL,
    NumeroMaquina INT NOT NULL,

    CONSTRAINT utilizaCLP
        PRIMARY KEY (CedulaAlumno, NumeroMaquina),
    CONSTRAINT Utiliza_CIAlumCLE
        FOREIGN KEY (CedulaAlumno) REFERENCES Alumno(CI_Alumno) 
        ON DELETE CASCADE,
    CONSTRAINT Utiliza_NumMaquinaCLE
        FOREIGN KEY (NumeroMaquina) REFERENCES Computadora(numMaquina)
        ON DELETE CASCADE
);

CREATE TABLE Arregla(
    CedulaAsistente INT NOT NULL,
    NumeroMaquina   INT NOT NULL,

    CONSTRAINT arreglaCLP
        PRIMARY KEY (CedulaAsistente, NumeroMaquina),
    CONSTRAINT Arregla_CIAsistCLE
        FOREIGN KEY (CedulaAsistente) REFERENCES Asistente_Laboratorio(CI_Asist)
        ON DELETE CASCADE,
    CONSTRAINT Arregla_NumMaquinaCLE
        FOREIGN KEY (NumeroMaquina) REFERENCES Computadora(numMaquina)
        ON DELETE CASCADE
);

CREATE TABLE Asiste(
    CedulaAsistente   INT NOT NULL,
    NumeroLaboratorio INT NOT NULL,

    CONSTRAINT asisteCLP
        PRIMARY KEY (CedulaAsistente, NumeroLaboratorio),
    CONSTRAINT Asiste_CIAsistCLE
        FOREIGN KEY (CedulaAsistente) REFERENCES Asistente_Laboratorio(CI_Asist)
        ON DELETE CASCADE,
    CONSTRAINT Asiste_NumLabCLE
        FOREIGN KEY (NumeroLaboratorio) REFERENCES Laboratorio(numeroLab)
        ON DELETE CASCADE
);






insert into Laboratorio
(numeroLab, cantComputadoras, nombre)
values
(1,0,'Laboratorio 1'),
(2,3,'Laboratorio 2'),
(3,1,'Laboratorio 3'),
(4,1,'Laboratorio 4'),
(5,2,'Laboratorio 5');
SELECT * FROM Laboratorio;


INSERT INTO Computadora
(numMaquina, estado, descripcion, numeroLaboratorio)
VALUES
(0001, 'disponible', 'Funcional con algunos errores de software', 2),
(0002, 'averiada', 'Con problemas en hardware y software, le faltan teclas al teclado', 2),
(0003, 'disponible', 'Funcional con algunos errores de software', 2),
(0004, 'funcional', 'Funciona perfectamente.', 4),
(0005, 'averiada', 'Le borraron el System 32', 5),
(0006, 'funcional', 'La computadora funciona pero los archivos', 5),
(0007, 'disponible', 'La computadora funciona perfectamente', 3);

INSERT INTO Funcionario
(CI, Nombre, Apellido, Fecha_nacimiento, Calle, N°Calle)
VALUES
(63682020, 'Pablo', 'Mundez', '2000-10-21', 'San francisco', 1920),
(20202020, 'Lebron', 'Jamez', '2001-12-01', 'O"BLOCK', 1222),
(63682021, 'Ivo', 'Da Fuego', '2008-03-21', 'San francisco', 1920),
(20202022, 'Cogo', 'Yopicado', '2004-04-20', 'Malvin Norte', 1225),
(63682023, 'Emanuel', 'Suarez', '2000-11-21', '', 1920);

SELECT * FROM Funcionario;

INSERT INTO Telefono
(TELEFONO, CI_Asistente)
VALUES
();





