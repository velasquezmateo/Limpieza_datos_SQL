-- Crear copia de la tabla
create table trips_staging like trips; 
#trips es el nombre de la tabla fuente

INSERT INTO trips_staging
SELECT * FROM trips;

-- Crear columna ID
alter table trips_staging
add column id INT auto_increment primary key;

-- Deshabilitar modo seguro 
SET SQL_SAFE_UPDATES = 0;

-- Eliminar duplicados
delete t1 from trips_staging t1 
inner join trips_staging t2 on t1.booking_id=t2.booking_id
and t1.email=t2.email
and t1.checkin_date=t2.checkin_date
and t1.checkout_date=t2.checkout_date
and t1.id > t2.id;

-- Limpiar guest_name
update trips_staging
set guest_name=null
where trim(guest_name)='';

-- Quitar espacios y estandarizar en columna nombre
update trips_staging
set guest_name=trim(lower(guest_name));

-- Crear columna nombre
alter table trips_staging
add column name varchar(100);

update trips_staging
set name=substring_index(guest_name, ' ',1);

-- Crear columna last_name
alter table trips_staging
add column last_name varchar(50);

update trips_staging
set last_name=substring_index(guest_name, ' ',-1);

-- Concatenar nombres y apellidos
update trips_staging 
set guest_name=concat(
upper(left(name,1)),
lower(substring(name,2)),
' ',
upper(left(last_name,1)),
lower(substring(last_name,2)));

update trips_staging
set guest_name='Unknown'
where guest_name='Unknown Unknown';

-- Chequear valores inconsistentes en email
select email from trips_staging
where email not REGEXP '[a-zA-Z0-9\._%-]+@[a-zA-Z0-9\._%-]+\.[a-z]{2,}';


-- Limpiar listing_city
update trips_staging
set listing_city='Los Angeles'
where listing_city regexp 'los angeles|LA';

update trips_staging
set listing_city='San Francisco'
where listing_city REGEXP 'San Fran|SF';

update trips_staging
set listing_city='New York'
where listing_city REGEXP 'new york|NYC';

-- Limpiar fechas de reserva
select checkout_date from trips_staging
where checkout_date not regexp '[0-9]{4}-[0-9]{2}-[0-9]{2}';

update trips_staging
set checkin_date = str_to_date(checkin_date,'%d/%m/%Y')
where checkin_date not regexp '[0-9]{4}-[0-9]{2}-[0-9]{2}';

update trips_staging
set checkout_date = str_to_date(checkout_date,'%m-%d-%Y')
where checkout_date not regexp '[0-9]{4}-[0-9]{2}-[0-9]{2}';

-- Limpiar noches
update trips_staging
set nights= datediff(checkout_date,checkin_date);

-- Limpiar precio por noche
update trips_staging
set price_per_night = 0
where price_per_night not regexp '[0-9]+';

-- Precio total
update trips_staging
set total_price = truncate(price_per_night*nights,2);



-- Limpiar payment status
update trips_staging
set payment_status= null
where payment_status regexp 'N/A';

update trips_staging
set payment_status= concat(upper(left(lower(payment_status),1)),substring(lower(payment_status),2));

update trips_staging
set payment_status= coalesce(payment_status,'Unknown');

-- Limpiar review score
update trips_staging
set review_score=null
where review_score regexp '-1|N/A';

update trips_staging
set review_score=null
where review_score not regexp '[0-9]+';

-- Limpiar is_cancelled
update trips_staging
set is_cancelled = 'Yes'
where is_cancelled regexp 'True|y|1';

update trips_staging
set is_cancelled = 'No'
where is_cancelled regexp 'False|n|0';

select is_cancelled from trips_staging
group by is_cancelled;

Alter table trips_staging
drop column name;

Alter table trips_staging
drop column last_name;

select * from trips_staging;




