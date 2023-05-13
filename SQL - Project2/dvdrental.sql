--We want to reward our first 10 paying customers. 
--What are the ids of the first 10 custmers who created a payment?
SELECT customer_id FROM payment
ORDER BY payment_date ASC
LIMIT 10;

--A customer wants to quickly rent a video to watch over their short lunch break.
--What are the titles of the 5shortest (in length of runtime) movies?
SELECT title, length FROM film
ORDER BY length ASC
LIMIT 5;

--If the previous customer can watch any movie that is 50 minutes or less in run time,
--how many options does he have?
SELECT COUNT(title) FROM film 
WHERE length <= 50;

--How many payment transactions were greater than $5.00?
SELECT COUNT (amount) FROM payment
WHERE amount > 5;

--How many actors have a first name hat starts with the letter P?
SELECT COUNT (*) FROM actor
WHERE first_name LIKE 'P%';

--How many films have a rating of R and a replacement cost between $5 and $15?
SELECT COUNT(*) FROM film
WHERE rating = 'R'
AND replacement_cost BETWEEN 5 AND 15;

--How many flilms have the word Truman somewhere in the title?
SELECT COUNT(*) FROM film
WHERE title LIKE '%Truman%';

--Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2
SELECT customer_id, SUM(amount)
FROM payment 
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 110;


--What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?
SELECT first_name, last_name FROM customer
WHERE firsT_name LIKE 'E%'
AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;
