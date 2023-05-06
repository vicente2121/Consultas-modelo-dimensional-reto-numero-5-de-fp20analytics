select * from  public.stage

select * from  public.dates

--Verificamos si tenemos duplicados
--tenemos 2998 registros
select count(*) from stage

--Creamos la consulta los paises unicos para obetener solo los datos unicos de la columna
--
select distinct(country) from stage

--Creamos la tabla dim_country  con el id que nos servira paracrear las primero la llave primaria de la dimension y que esta sea la foranea de la de hechos
create table dim_country
(
id serial,
Country varchar(14)	
)

--Insertamos los datos en la nueva tabla Dim_country

insert into dim_country  (Country)
select distinct(country) from stage

--Creamos la consulta los distirbuidores  unicos para obetener solo los datos unicos de la columna
select distinct(distribuitor) from stage

--Creamos la tabla dim_distribuitor con el id que nos servira paracrear las primero la llave primaria de la dimension y que esta sea la foranea de la de hechos
create table dim_distribuitor
(
id serial,
distribuitor varchar(14)	
)

--Insertamos los datos en la nueva tabla dim_distribuitor

insert into dim_distribuitor  (distribuitor)
select distinct(distribuitor) from stage

--Creamos la consulta las marcas  unicas para obetener solo los datos unicos de la columna
select distinct(brand) from stage

--Creamos la tabla dim_brand con el id que nos servira paracrear las primero la llave primaria de la dimension y que esta sea la foranea de la de hechos
create table dim_brand
(
id serial,
brand varchar(14)	
)

--Insertamos los datos en la nueva tabla dim_brand

insert into dim_brand  (brand)
select distinct(brand) from stage

--Creamos la consulta las operadores  unicas para obetener solo los datos unicos de la columna
select distinct(operators) from stage

--Creamos la tabla dim_operators con el id que nos servira paracrear las primero la llave primaria de la dimension y que esta sea la foranea de la de hechos
create table dim_operators
(
id serial,
operators varchar(14)	
)

--Insertamos los datos en la nueva tabla dim_operators

insert into dim_operators  (operators)
select distinct(operators) from stage


--Ahora crearemos la conuslta para crear la tabla defintiva de hechos  con varios left joins

select  a.date_original,a.unit_cost,a.amount,a.unit_price,a.sales,
b.id as id_country,
c.id as id_distribuitor,
d.id as id_brand,
e.id as id_operators
into Fact_table
from  public.stage as a 
left join dim_country as b
on a.country=b.Country
left join dim_distribuitor as c
on a.distribuitor=c.distribuitor
left join dim_brand as d
on a.brand=d.brand
left join dim_operators as e
on a.operators=e.operators


--tenemos 2998 registros  son lo que deben ser insertados 
select *  from Fact_table


-- Verificacion de tabla de fechas 
-- El maximo de fecha en años es 2022 asi que solo subiremos  en fecha calendario los dias 
select max(year),min(year) from dates

select max(date_original),min(date_original) from stage

--eliminamos los datos de año 2022

delete  from dates
where year=2022

--verificamos 
select max(year),min(year) from dates


---Tabla de hechos
select *  from Fact_table
--Tablas de dimensiones
select * from dim_country
select * from dim_distribuitor
select * from dim_brand
select * from dim_operators
select * from dates








