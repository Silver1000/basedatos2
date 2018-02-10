--Generamos la primer tablita
create table almacen (Numero_almacen integer,
Ubicacion_almacen varchar2(50),
constraint PK_Num_alm primary key (Numero_almacen)
);

--Cliente
create table cliente (Numero_cliente integer,
Numero_almacen integer,
nombre_cliente varchar2(50),
constraint PK_N_c primary key (Numero_cliente),
constraint FK1_N_a foreign key (Numero_almacen)
--Donde se encuentra la primary key de almacen
References almacen(numero_almacen)
);
--Vendedor
create table Vendedor (Numero_Vendedor integer,
Area_Ventas varchar2(50),
Nombre_Vendedor varchar2(50),
constraint PK_N_Ven primary key (Numero_Vendedor)
);
--Ventas
create table Ventas (Id_Ventas integer,
Numero_Cliente integer,
Numero_Vendedor integer,
Monto_Ventas float,
constraint PK_Id_V primary key (Id_Ventas),
constraint FK1_N_C foreign key (Numero_Cliente) references cliente(numero_cliente),
constraint FK1_N_V foreign key (Numero_Vendedor) references Vendedor(Numero_Vendedor)
);

--Procedimiento almacenado guardar, actualizar, borrar
--Guardar_almacen con este nombre se puede invocar en otros lenguajes
--Permite la recompilacion 
--Cuando hay argumentos no se ponen los parentesis, In (argumento de entrada) 
--Declaracion del procedimiento (No se visualiza en la interface)
create or replace procedure guardar_almacen(my_num_alman In integer,my_ub_alm In varchar2) 
as
--Variables locales si se requieren
--Cuerpo o logica del procedimiento
begin
insert into almacen values(my_num_alman,my_ub_alm);
end;
/
--Cliente
create or replace procedure guardar_cliente(my_num_clien In integer,my_num_alm In integer,my_nom_clien In varchar2) 
as
--Variables locales si se requieren
--Cuerpo o logica del procedimiento
begin
insert into cliente values(my_num_clien ,my_num_alm ,my_nom_clien);
end;
/
--Vendedor
create or replace procedure guardar_vendedor(my_num_ven In integer,my_nom_ven In varchar2, my_area_ven In varchar2 ) 
as
--Variables locales si se requieren
--Cuerpo o logica del procedimiento
begin
insert into vendedor values(my_num_ven,my_nom_ven, my_area_ven);
end;
/
--Usaremos un bloque pl-sql para probar el correcto funcionamiento de nuestro procedimiento
--Se invoca el procedimiento creado
begin 
guardar_almacen(321,'Ecatepec');
end;
/
--Prueba
begin 
guardar_cliente(456,321,'Silvestre');
end;
/
--Prueba
begin 
guardar_vendedor(678,'Andres','Abarrotes');
end;
/
Select * from almacen;
Select * from cliente;
--Probar el procedimiento en netbeans

--Generamos una secuencia
Create Sequence Sec_Ventas
Start with 1
increment by 1
--Permite poner varios registros
nomaxvalue;

--Aqui  ya viene el procedimiento almacenado(Cursor implicito)
create or replace procedure guardar_ventas(my_id_Ventas Out integer,my_numero_cliente In integer,my_numero_vendedor In integer,
my_monto_ventas In float)
as
begin
select Sec_Ventas.NextVal into my_id_Ventas from dual;
insert into Ventas values (my_id_Ventas,my_numero_cliente,my_numero_vendedor,my_monto_ventas);
end;
/
--Prueba del procedimiento
declare
valor integer;
begin 
guardar_ventas(Valor,456,678,8000);
end;
/
--Verificacion / relacionado a un cursor explicito 
Select * from ventas;
--Borrar
delete from ventas where id_ventas=2;
--Contar /relacionado a un cursor implicito
select count (*) from ventas

--Calificaciones
create table Calificaciones (Id_Calificaciones integer,
Materia varchar2(50),
Calificacion integer,
constraint PK_Id_C primary key (Id_Calificaciones)
);
Create Sequence Sec_Cal
Start with 1
increment by 1
--Permite poner varios registros
nomaxvalue;

--Aqui  ya viene el procedimiento almacenado(Cursor implicito)
create or replace procedure guardar_calificaciones(my_id_calificacion Out integer,my_materia In varchar2,my_calificacion In float)
as
begin
select Sec_Cal.NextVal into my_id_calificacion from dual;
insert into Calificaciones values (my_id_calificacion,my_materia,my_calificacion);
end;
/
declare
valor integer;
begin 
guardar_calificaciones(Valor,'Base de datos 2',9);
end;
/
select * from calificaciones;
delete from calificaciones where id_calificaciones=1;
--ejemplo de cursor explicito con tabla calificaciones
declare
cursor cur_calif is select * from calificaciones;
begin
--realiza una busqueda y termina hasta que se acaben los registros
for rec in cur_calif loop
dbms_output.put_line('Calificacion '||rec.calificacion||' Materia '||rec.materia);
end loop;
end;
/
set serveroutput on;