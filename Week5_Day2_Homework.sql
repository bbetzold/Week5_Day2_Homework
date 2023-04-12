-- Week 5 - Wednesday
-- Questions
-- 1. List all customers who live in Texas (use
-- JOINs)
SELECT first_name, last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
SELECT first_name, last_name, amount
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
ORDER BY amount DESC;

-- 3. Show all customers names who have made payments (totalling) over $175 (use
-- subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

-- 4. List all customers that live in Nepal (use the city
-- table)
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id IN(
	SELECT address_id
	FROM address
	WHERE city_id IN(
		SELECT city_id
		FROM city
		WHERE country_id IN(
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
		)
	)
);


-- 5. Which staff member had the most
-- transactions?
-- Staff

SELECT first_name, last_name, payment.staff_id, COUNT(amount)
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name, payment.staff_id;

-- 6. How many movies of each rating are
-- there?
SELECT film.rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id);


-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)

-- USING SUBQUERIES
SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY payment.customer_id
	HAVING COUNT(customer_id) = 1
	ORDER BY payment.customer_id ASC
 );

-- 8. How many free rentals did our stores give away (each of the stores)?
SELECT COUNT(amount), store.store_id
FROM payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN store
ON inventory.store_id = store.store_id
WHERE amount = 0.00
GROUP BY store.store_id
ORDER BY store.store_id;

-- — Question 1: 5 people live in Texas. Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, Ian Still
-- — Question 2: 1406 payments
-- — Question 3: 6 customers
-- — Question 4: 1 customer
-- — Question 5: Jon Stephens with 7304 transactions
-- — Question 6: G: 178, PG: 194, PG-13: 223, R: 195, NC-17:210
-- — Question 7: 130 customers made a single payment over $6.99
-- — Question 8: 24 free rentals