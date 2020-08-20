-- Insertar en una tabla

insert into [Practica1_Partido].[practica].[jugador]([primer_nombre], [segundo_nombre], [id_pos])
values ('Jose', 'David', '2')
go

insert into [Practica1_Partido].[practica].[pocision]([nombre_pos])
values ('Delantero')
go

insert into [Practica1_Partido].[practica].[partido]([ubicacion], [equipo_visitante], [equipo_casa], [fecha_partido])
values ('San Pedro', 'Calacas', 'Herediano', GETDATE())
go

insert into [Practica1_Partido].[practica].[resultado]([goles_casa], [goles_visita], [ganador])
values ('2', '3', 'Herediano')
go

-- Eliminar
delete from [Practica1_Partido].[practica].[resultado]
where [identificador]=1
go

-- Select
select * from [Practica1_Partido].[practica].[resultado];
go
