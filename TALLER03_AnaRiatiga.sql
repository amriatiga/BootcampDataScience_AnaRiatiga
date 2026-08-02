/* Parte 1 - SELECT y Where
    1. Mostrar nombre y apellido de todos los clientes 
    2. Peliculas con duracion mayor a 120 minutos */

# 1. Seleccionamos Nombre y apellido de todos los clientes de la tabla customer.     
SELECT first_name, last_name FROM customer;

# 2. Peliculas con duracion mayor a 120 minutos. 
SELECT title, length FROM film
WHERE length > 120;

/* Parte 2 - ORDER BY
    3. Ordenar clientes por apellido -> Por orden alfabetico de la A a la Z
    4. Top 5 peliculas mas largas --> TIP: Use la palabra LIMIT*/

# 3. Seleccionamos los datos de la tabla customer y ordenamos de manera ascendente los apellidos usando ORDER BY. 
SELECT * FROM customer 
ORDER BY last_name ASC;

# 4. 
# Seleccionamos los datos de film
# ordenamos la duracion de manera descendiente (de mas larga a mas corta)
# limitamos para devolver las primeras 5 filas.  
SELECT * FROM film 
ORDER BY length DESC 
LIMIT 5; 

/* Parte 3 - INNER JOIN
    5. Cantidad pagada y fecha del pago con nombre y apellido del cliente (JOIN entre payment - customer)
    6. Peliculas alquiladas (JOIN entre Rental - Inventory - Film)*/ 
 
 # 5.  
 # Aqui seleccionamos nombre y apellido de la tabla customer y cantidad y fecha de la tabla payment con payment como tabla principal. 
 # Unimos la tabla customer con la tabla payment usando el customer_id
 SELECT customer.first_name, customer.last_name, payment.amount, payment.payment_date FROM payment 
 JOIN customer ON payment.customer_id = customer.customer_id; 
 
 # 6.  
 #Sleccionamos el titulo de la tabla film y la fecha de la tabala rentas, la tabla principal seria rental
 # Unimos la tabla inventory con la tabla rental por medio de inventory_id, y esta seria una tabla intermedia
 # unimos la tabla film a inventory y rental por medio de film_id
 SELECT film.title, rental.rental_date FROM rental 
 JOIN inventory ON rental.inventory_id = inventory.inventory_id
 JOIN film ON inventory.film_id = film.film_id;
 
 /* Parte 4 - LEFT JOIN
     7. Nombre y apellido de clientes sin pagos (LEFT JOIN entre Payment - Customer pero usando WHERE)
     8. Listar los nombres de las peliculas y su duracion de aquellos titulos que no tienen actores*/
     
# 7. 
# Seleccionamos nombre y apellido de la tabla customer
# Unimos payment y customer con un LEFT JOIN para que muestre todas las columnas de customer y payment, asi algunas no tengan valor (en estas veriamos valor NULL)
# Indicamos mostrar solo donde el valor de customer_ID en payment sea NULL usando WHERE
SELECT customer.first_name, customer.last_name FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.customer_id IS NULL; 

# 8. 
# Seleccionamos titulo y duracion de film
# Unimos la tabla film_actor por medio de film_id
# Retornamos solo donde actor_id sea NULL
SELECT film.title, film.length FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IS NULL;

/* Parte 5 - INSERT, UPDATE, DELETE (Data Definition Language)
   RECUERDA USAR WHERE
    9.Insertar actor temporal
    10. Actualizar actor
    11. Eliminar actor*/
    
# 9.
# Insertamos columna en actor con valores ACTOR TEMPORAL como nombre y apellido
INSERT INTO actor (first_name, last_name)
VALUES ('ACTOR', 'TEMPORAL');

# 10. 
# Actualizamos la columna creada anteriormente, cambiamos los valores de ACTOR TEMPORAL por ANA RIATIGA 
UPDATE actor SET first_name = "ANA", last_name = "RIATIGA"
WHERE first_name = "ACTOR" AND last_name = "TEMPORAL";

# 11. 
# Borramos la columna creada anteriormente.  
DELETE FROM actor
WHERE first_name = "ANA" AND last_name = "RIATIGA";

/* Parte 6 - Consultas Avanzadas
    12. Top 5 clientes con mayor cantiad de dinero pagado al servicio de rentas
    13. Top 5 Películas más alquiladas (JOIN entre Rental - Inventory - Film) --> Agrupar los datos con conteo y tomar las mejores 5*/
    
# 12. 
# Con SUM sumamos los pagos realizados y con AS le damos nombre a la columna que contiene la suma
# Unimos la tabla customer por medio de customer_id y agrupamos por customer_id para agrupar los pagos de un mismo cliente y calular la suma. 
# Ordenamos el total pagado de manera descendiente y limitamos para mostras los primeros 5 resultados (5 clientes con mayores pagos)
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_pagado FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY total_pagado DESC
LIMIT 5; 

# 13. 
# con COUNT contamos el alquirel de cada pelicula y con AS le damos nombre a la columna del conteo
# Unimos inventory por medio de inventory_id y luego unimos film por medio de film_id
# Agrupamos los alquileres por pelicula con el film_id
# Ordenamos el toal_alquileres de manera descendiente para mostras de las mas alquilada a la menos alquilada. Y finalmente limitamos para mostras los primeros 5 resultados (las peliculas mas alquiladas)
SELECT film.title, COUNT(rental.rental_id) AS total_alquileres FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id
ORDER BY total_alquileres DESC
LIMIT 5;



 
 

    
