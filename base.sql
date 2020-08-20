--Crear Base de datos
CREATE DATABASE Practica1_Partido
ON
( NAME = Practica1_Partido,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Practica1_Partido.mdf',
SIZE=20MB,
FILEGROWTH=19MB)
LOG ON
( NAME = Practica1_Partido_log,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Practica1_Partido.ldf',
SIZE=20MB,
FILEGROWTH=19MB)
go
--Se crea el esquema
create schema practica
go
--Se crean las tablas ncesarias y la de pocision como llave foranea
create table practica.pocision(
	id_pos int primary key identity(1,1),
	nombre_pos varchar(50)
)
go

create table practica.jugador(
		identificador int primary key identity(1,1),
		primer_nombre varchar(50),
		segundo_nombre varchar(50),
		id_pos int,
		constraint FK_pocision_pos_id foreign key (id_pos) references practica.pocision(id_pos)
	)

	go

	
create table practica.equipo(
		identificador int primary key identity(1,1),
		nombre varchar(50),
		fecha datetime not null,
		descripcion varchar(50)
	)

	go

create table practica.partido(
		identificador int primary key identity(1,1),
		ubicacion varchar(50),
		equipo_visitante varchar(50),
		equipo_casa varchar(50),
		fecha_partido datetime
	)

	go

create table practica.resultado(
		identificador int primary key identity(1,1),
		goles_casa varchar(50),
		goles_visita varchar(50),
		ganador varchar(50)
	)

	go

	create table practica.logs(
		id int primary key identity(1,1),
		fecha datetime,
		texto varchar(100),
		usuario varchar(50) 
	)

	go

	--Creacion de vistas
	create view practica.idEquipo as 
	select identificador from practica.equipo
	go

	create view practica.idResultado as 
	select identificador from practica.resultado
	go

	--Creacion de pocedimientos almacenados
	CREATE PROCEDURE proc_obtener_jugador (@nombre VARCHAR)
	AS
	BEGIN
	SELECT * FROM practica.jugador WHERE primer_nombre = @nombre;
	END
	go

	CREATE PROCEDURE proc_obtener_descripcion_equipo (@descripcion VARCHAR)
	AS
	BEGIN
	SELECT * FROM practica.equipo WHERE descripcion = descripcion;
	END
	go

	CREATE PROCEDURE proc_eliminar_equipo (@nombre varchar)
	AS
	BEGIN
	DELETE FROM practica.equipo WHERE nombre = @nombre;
	END
	go

	CREATE PROCEDURE proc_eliminar_jugador (@nombre varchar)
	AS
	BEGIN
	DELETE FROM practica.jugador WHERE primer_nombre = @nombre;
	END
	go

	--Creacion de los Disparadores
	CREATE TRIGGER trigger_insertar_jugador
		ON practica.jugador FOR INSERT 
		AS
		INSERT INTO practica.logs(fecha, texto, usuario)
        VALUES(getdate(), 'Insertado exitoso', 'user');	
	go

	CREATE TRIGGER trigger_actualizar_jugador ON practica.jugador
    FOR UPDATE
    AS
		IF update(identificador)
    BEGIN
		raiserror('No puede modificarse la identificacion', 10, 1)
		rollback transaction
		INSERT INTO practica.logs(fecha, texto, usuario)
        VALUES(getdate(), 'No se pudo modificar', 'user');	
    END
	go
	
	--Creacion de la funcion
	 CREATE FUNCTION hola (@saludo AS VARCHAR (30))
  returns VARCHAR(MAX)
  AS
  BEGIN
	RETURN
		'HolaMundo'
  END;
  go

