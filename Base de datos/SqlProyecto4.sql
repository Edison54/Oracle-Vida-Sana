

--Proyecto progra--
-----Edison CV-----

---Tabla estado----

CREATE TABLE Estado
(
   Cod_Estado   INTEGER NOT NULL PRIMARY KEY,
   Estados       VARCHAR2 (50) NOT NULL
);
-------------Inserccion datos--------------------

INSERT INTO Estado
     VALUES (1,
             'Activo');            
INSERT INTO Estado
     VALUES (2,
             'Inactivo');
INSERT INTO Estado
     VALUES (3,
             'Disponible');
INSERT INTO Estado
     VALUES (4,
             'No Disponible'); 
INSERT INTO Estado
     VALUES (5,
             'Internado'); 
INSERT INTO Estado
     VALUES (6,
             'En alta');                                                        
                                                                    

---Tabla usuario----

CREATE TABLE Usuario
(
   Cod_Usuario    INTEGER NOT NULL PRIMARY KEY,
   Nombre         VARCHAR2 (50) NOT NULL,
   Nomenclatura   VARCHAR2 (20) NOT NULL,
   Pass           VARCHAR2 (20) NOT NULL,
   CodEstado      INTEGER NOT NULL,
   FOREIGN KEY (CodEstado) REFERENCES Estado (Cod_Estado)
);

---------------------------------

INSERT INTO Usuario
     VALUES (10,
             'Edison Chavarria Vasquez',
             'EChavarria',
             '86304122',1);



---Tabla camas----

CREATE TABLE Camas
(
   Cod_Cama    INTEGER NOT NULL PRIMARY KEY,
   Tipo        VARCHAR2 (50) NOT NULL,
   CodEstado   INTEGER NOT NULL,
   CodPaciente   INTEGER NULL,
   Ubicacion   VARCHAR2 (50) NOT NULL,
   FOREIGN KEY (CodPaciente) REFERENCES Paciente (Cod_Paciente),
   FOREIGN KEY (CodEstado) REFERENCES Estado (Cod_Estado)
);

---------------
INSERT INTO Camas
     VALUES (13, 'Comun',4,null,'Habitacion H1');
INSERT INTO Camas
     VALUES (12, 'Ortopedica',4,'Habitacion H1');
     
     
     
     
     


---Tabla Doctor----

CREATE TABLE Doctor
(
   Cod_Doctor   INTEGER NOT NULL PRIMARY KEY,
   Cedula       INTEGER NOT NULL,
   Nombre       VARCHAR2 (50) NOT NULL,
   Telefono     VARCHAR2 (20) NOT NULL,
   CodEstado    INTEGER NOT NULL,
   FOREIGN KEY (CodEstado) REFERENCES Estado (Cod_Estado)
);




---Tabla Paciente----

CREATE TABLE Paciente
(
   Cod_Paciente   INTEGER NOT NULL PRIMARY KEY,
   Cedula       INTEGER NOT NULL,
   Nombre1         VARCHAR2 (50) NOT NULL,
   Medicamentos   VARCHAR2 (50) NOT NULL,
   Padecimiento   VARCHAR2 (150) NOT NULL,
   Edad           INTEGER NOT NULL,
   CodDoc         INTEGER NOT NULL,
   CodEstado      INTEGER NOT NULL,
   FOREIGN KEY (CodDoc) REFERENCES Doctor (Cod_Doctor),
   FOREIGN KEY (CodEstado) REFERENCES Estado (Cod_Estado)
);


--
INSERT INTO Paciente
     VALUES (69,208260427 ,'ALVARITO','Clash royale','gemea mucho',28,4,5);
---Tabla Internamiento----

CREATE TABLE Internamiento
(
   Cod_Internamiento   INTEGER NOT NULL PRIMARY KEY,
   CodCama             INTEGER NOT NULL,
   CodDoc              INTEGER NOT NULL,
   CodPaciente         INTEGER NOT NULL,
   Fecha_hora          VARCHAR2(50) NOT NULL,
   FOREIGN KEY (CodDoc) REFERENCES Doctor (Cod_Doctor),
   FOREIGN KEY (CodPaciente) REFERENCES Paciente (Cod_Paciente),
   FOREIGN KEY (CodCama) REFERENCES Camas (Cod_Cama)
);





---------view camas principal------------ 
     
CREATE OR REPLACE VIEW Vistacamas
AS           
select c.Cod_Cama,c.Tipo,c.Ubicacion, e.Estados from Camas c inner join Estado e  on c.CodEstado = e.Cod_Estado where  C.CODESTADO = 3 ;  









-------Crud doctor----------
-------Guardar-------
create or replace Procedure GuardarDoctor (CodigoDoctor  in integer, CedulaD  in integer , NombreD  in varchar2, TelefonoD  in varchar2, CodigoEstado  in integer)
as
begin

  insert into Doctor( Cod_Doctor,Cedula,Nombre,Telefono,CodEstado)
         values (CodigoDoctor, CedulaD, NombreD, TelefonoD, CodigoEstado);

end;

-------Editar---------
create or replace Procedure EditarDoctor(TelefonoD  in varchar2, CodigoEstado  in integer,CedulaD  in integer)
as
begin
update Doctor set Telefono = TelefonoD,CodEstado = CodigoEstado  where Cedula = CedulaD;
end;
-------Eliminar---------
create or replace Procedure EliminarDoctor (CodigoDoctor  in integer )
as
begin

  DELETE FROM Doctor where Cod_Doctor = CodigoDoctor;
         

end;




--vista Doctores disponibles---
CREATE OR REPLACE VIEW VistaDoctoresDisponible
AS           
select d.Cod_Doctor,d.Nombre,d.Telefono,e.Estados  from Doctor d inner join Estado e  on d.CodEstado = e.Cod_Estado where  d.CodEstado = 3;





-------Crud Paciernte----------
-------Guardar-------
create or replace Procedure GuardarPaciente (CodigoPaciente  in integer, CedulaP  in integer , NombreP  in varchar2, MedicamentosP  in varchar2, PadecimientoP in varchar2, EdadP  in integer, CodDoctor  in integer, CodigoEstado  in integer)
as
begin

  insert into Paciente( Cod_Paciente,Cedula,Nombre1,Medicamentos,Padecimiento,Edad,CodDoc,CodEstado)
         values (CodigoPaciente, CedulaP, NombreP, MedicamentosP, PadecimientoP,EdadP,CodDoctor,CodigoEstado);

end;

-------Editar---------
create or replace Procedure EditarPaciente(MedicamentosP  in varchar2, PadecimientoP  in varchar2,EdadP  in integer,CodDoctor in integer,CodigoEstado  in integer,CedulaP  in integer)
as
begin
update Paciente set Medicamentos = MedicamentosP,Padecimiento = PadecimientoP,Edad = EdadP, CodDoc = CodDoctor,CodEstado = CodigoEstado  where Cedula = CedulaP;
end;
-------Eliminar---------
create or replace Procedure EliminarPaciente (CodigoPaciente  in integer )
as
begin

  DELETE FROM Paciente where Cod_Paciente = CodigoPaciente;
         

end;






CREATE OR REPLACE VIEW VistaPacientes
AS           
select p.Cod_Paciente,p.Cedula,p.Nombre1,p.Medicamentos,p.Padecimiento,p.Edad,d.Cod_Doctor,d.Nombre,p.CodEstado  from Paciente p inner join Doctor d on p.CodDoc = d.Cod_Doctor;  


--vista pacientes nternados---
CREATE OR REPLACE VIEW VistaPacientesInternados
AS           
select p.Cod_Paciente,p.Nombre1,p.Padecimiento,e.Estados  from Paciente  p inner join Estado e  on p.CodEstado = e.Cod_Estado where  p.CodEstado = 5 ;


-------Crud usuario----------
-------Guardar-------
create or replace Procedure GuardarUsuario(CodigoUsuario in integer, NombreU in varchar2, NomenclaturaU  in varchar2, PassU in varchar2, CodigoEstado  in integer)
as
begin

  insert into Usuario(Cod_Usuario ,Nombre,Nomenclatura,Pass,CodEstado)
         values (CodigoUsuario, NombreU, NomenclaturaU, PassU, CodigoEstado);

end;

-------Editar---------
create or replace Procedure EditarUsuario(CodigoEstado  in integer,CodigoUsuario in integer)
as
begin
update Usuario set CodEstado = CodigoEstado  where Cod_Usuario = CodigoUsuario;
end;
-------Eliminar---------
create or replace Procedure EliminarUsuario(CodigoUsuario  in integer)
as
begin

  DELETE FROM Usuario where Cod_Usuario = CodigoUsuario;
         
end;

--vista todos los  usuarios con su estado---
CREATE OR REPLACE VIEW VistaTodosUsuarios
AS           
select u.Cod_Usuario,u.Nombre,u.Nomenclatura,u.CodEstado, e.Estados from Usuario u inner join Estado e  on u.CodEstado = e.Cod_Estado;


--vista usuarios activos---
CREATE OR REPLACE VIEW VistaUsuariosActivos
AS           
select u.Cod_Usuario,u.Nomenclatura, e.Estados from Usuario u inner join Estado e  on u.CodEstado = e.Cod_Estado where  u.CodEstado = 1 ;




-------Crud camas ----------
-------Guardar-------
create or replace Procedure GuardarCama(CodigoCama in integer, TipoC in varchar2, CodigoEstado  in integer,CodigoPaciente in integer , UbicacionC in varchar2)
as
begin

  insert into Camas( Cod_Cama,Tipo,CodEstado,CodPaciente,Ubicacion)
         values (CodigoCama, TipoC, CodigoEstado,CodigoPaciente, UbicacionC);

end;
  

-------Editar---------
create or replace Procedure EditarCama(CodigoEstado  in integer,CodigoPaciente in integer,UbicacionC varchar2,CodigoCama in integer)
as
begin
update Camas set CodEstado = CodigoEstado , CodPaciente = CodigoPaciente,Ubicacion = UbicacionC   where Cod_Cama = CodigoCama;
end;





-------Eliminar---------
create or replace Procedure EliminarCama(CodigoCama  in integer)
as
begin

  DELETE FROM Camas where Cod_Cama = CodigoCama;
         
end;








--vista de todos las camas con paciete su estado y paciente---
CREATE OR REPLACE VIEW VistaTodasCamas
AS           
select  c.Cod_Cama,c.Tipo,c.CodEstado,e.Estados,c.CodPaciente,p.Nombre1,c.Ubicacion  from Camas c inner join Paciente p on c.CodPaciente = p.Cod_Paciente inner join Estado e  on c.CodEstado = e.Cod_Estado where c.CodEstado = 4;


--vista de todos las camasSIN PACIENTE---
CREATE OR REPLACE VIEW VistaCamasSinPacientes
AS           
select  c.Cod_Cama,c.Tipo,c.CodEstado,c.Ubicacion, e.Estados from Camas c inner join Estado e  on c.CodEstado = e.Cod_Estado where c.CodPaciente is null and c.CodEstado  = 3 ;


--vista camas  disponibles---
CREATE OR REPLACE VIEW VistaCamasDisponibles
AS           
select c.Cod_Cama,c.Tipo,c.Ubicacion, e.Estados from Camas c inner join Estado e  on c.CodEstado = e.Cod_Estado where  c.CodEstado = 3 ;




