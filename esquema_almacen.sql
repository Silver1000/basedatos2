--Generamos la primer tablita
create table almacen (Numero_almacen integer,
Ubicacion_almacen varchar2(50),
constraint PK_Num_alm primary key (Numero_almacen)
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
--Usaremos un bloque pl-sql para probar el correcto funcionamiento de nuestro procedimiento
--Se invoca el procedimiento creado
begin 
guardar_almacen(321,'Ecatepec');
end;
/
Select * from almacen;