DROP DATABASE IF EXISTS UTUBuceo;
CREATE DATABASE UTUBuceo;
USE UTUBuceo;

CREATE TABLE Computadora(
	numMaquina 	INT 			NOT NULL, #CLAVE PRIMARIA
    estado 	    VARCHAR(100)	NOT NULL, # INCLUIR RESTRICCIÓN DONDE ESTADO PUEDA SER {Funciónal, disponible, averiada}
    descripcion VARCHAR(300)	NOT NULL,
    
    CONSTRAINT comprobarEstados CHECK (estado IN ('funcional', 'disponible', 'averiada')),
    CONSTRAINT maquinaCLP
		PRIMARY KEY(numMaquina)
);

CREATE TABLE Laboratorio(
	numeroLab 		 INT 		 NOT NULL, #CLAVE PRIMARIA  -> FOREIGN KEY PARA Computadora
    cantComputadoras INT 		 NOT NULL,
    nombre			 VARCHAR(30) NOT NULL,
    
    CONSTRAINT laboratorioClaves
		PRIMARY KEY(numeroLab)
);

ALTER TABLE Computadora  
    ADD COLUMN numeroLaboratorio INT; #AÑADE UNA COLUMNA PARA QUE LA CLAVE DEPENDIENTE RESIDA EN ELLA
ALTER TABLE Computadora  #AÑADE LA FOREIGN KEY (CLAVE EXTERNA) DE N°Lab
	ADD CONSTRAINT maquinaCLE
		FOREIGN KEY (numeroLaboratorio) 
		REFERENCES Laboratorio(numeroLab);
    
CREATE TABLE Funcionario(
	CI					 	 INT NOT NULL,
    Nombre 		  	 VARCHAR(30) NOT NULL,
    Apellido	  	 VARCHAR(30) NOT NULL,
    Turno 		  	 VARCHAR(50) NOT NULL,
	MAIL 		  	 VARCHAR(50) NOT NULL,
	Fecha_nacimiento DATE		 NOT NULL,
	Calle 			 varchar(50) NOT NULL,
	N°Calle 		 INT		 NOT NULL,
	CONSTRAINT funcionarioCLP
		PRIMARY KEY(CI)
);

CREATE TABLE Telefono(
	TELEFONO		INT NOT NULL,
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
    ADD COLUMN CI_Asistente INT;
ALTER TABLE Telefono
	ADD CONSTRAINT telefonoCLE
		FOREIGN KEY (CI_Asistente) 
		REFERENCES Asistente_Laboratorio(CI_Asist);
        

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
    CONSTRAINT grupoProfesorCLP
		PRIMARY KEY (Grupo)
);

ALTER TABLE GrupoProfesor  
    ADD COLUMN CI_Profesor INT;
ALTER TABLE GrupoProfesor
	ADD CONSTRAINT GrupoProfeCLE
		FOREIGN KEY (CI_Profesor) 
		REFERENCES Profesor(CI_Profesor);
        
CREATE TABLE Alumno(
	CI_Alumno INT 			NOT NULL,
	Nombre varchar(50)		NOT NULL,
	Apellido varchar(50)	NOT NULL,
	Grupo varchar(50)		NOT NULL,
	Fecha_nacimiento DATE	NOT NULL,
	Calle varchar(50)		NOT NULL,
	N°Calle INT				NOT NULL,
	CONSTRAINT Cedula
		primary key(CI_Alumno)
);

CREATE TABLE Utiliza(
    CedulaAlumno  INT NOT NULL,
    NumeroMaquina INT NOT NULL,

    CONSTRAINT utilizaCLP
        PRIMARY KEY (CedulaAlumno, NumeroMaquina),
    CONSTRAINT Utiliza_CIAlumCLE
        FOREIGN KEY (CedulaAlumno) REFERENCES Alumno(CI_Alumno),
    CONSTRAINT Utiliza_NumMaquinaCLE
        FOREIGN KEY (NumeroMaquina) REFERENCES Computadora(numMaquina)
);

CREATE TABLE Arregla(
    CedulaAsistente INT NOT NULL,
    NumeroMaquina   INT NOT NULL,

    CONSTRAINT arreglaCLP
        PRIMARY KEY (CedulaAsistente, NumeroMaquina),
    CONSTRAINT Arregla_CIAsistCLE
        FOREIGN KEY (CedulaAsistente) REFERENCES Asistente_Laboratorio(CI_Asist),
    CONSTRAINT Arregla_NumMaquinaCLE
        FOREIGN KEY (NumeroMaquina) REFERENCES Computadora(numMaquina)
);

CREATE TABLE Asiste(
    CedulaAsistente   INT NOT NULL,
    NumeroLaboratorio INT NOT NULL,

    CONSTRAINT asisteCLP
        PRIMARY KEY (CedulaAsistente, NumeroLaboratorio),
    CONSTRAINT Asiste_CIAsistCLE
        FOREIGN KEY (CedulaAsistente) REFERENCES Asistente_Laboratorio(CI_Asist),
    CONSTRAINT Asiste_NumLabCLE
        FOREIGN KEY (NumeroLaboratorio) REFERENCES Laboratorio(numeroLab)
);









INSERT INTO Profesor
(CI_Profesor, Nombre, Apellido, Materia, fecha_nacimiento, Calle, N°Calle)
values
(44444444,'Mateo','Misa','Geografia','1966-09-20','Rivera','7314'),
(55555555,'Rosa','Curbelo','Matematica','1966_05_08','Buceo','3331'),
(66666666,'Violet','Dans','Biologia','1970_01_01','Union','1730');
select * from Profesor;

INSERT INTO GrupoProfesor
(Grupo, CI_Profesor)
VALUES
('2ME', 44444444),
('2MA', 55555555),
('3MD', 66666666);
SELECT * FROM GrupoProfesor;


INSERT INTO Asistente_Laboratorio
(CI_Asist, Nombre, Apellido, Turno, MAIL, Fecha_nacimiento, Calle, N°Calle)
VALUES
(11111111, 'Felipe',  'Lapaz',   'Matutino',   'FelipeLapaz@gmail.com',     '1966-09-20', 'Rivera', 731),
(22222222, 'Ignacio', 'Curbelo', 'Vespertino', 'IgnacioCurbelox@gmail.com', '1966-05-08', 'Buceo',  3321),
(33333333, 'Octavio', 'Dans',    'Vespertino', 'Dans1234@gmail.com',        '1971-01-01', 'Union',  1230);
select * from Asistente_Laboratorio;



