/* EASY  QUESTIONS
 /* USE music_database
/*SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));*/
/*QUE1: 1 who is the most senior employee based on job title?*/
   /*SELECT * FROM EMPLOYEE 
   ORDER BY levels DESC LIMIT 1*/
 /*QUE2: which country has most invoices*/
   /*SELECT billing_country,count(*) as 'count' FROM invoice
   GROUP BY billing_country 
   ORDER BY count DESC*/
/*QUE3:what are the top 3 values of total invoice*/
   /*SELECT total FROM invoice
   ORDER BY total DESC LIMIT 3*/
/*QUE 4 which country has the best customers? we would like to throw a promotional music festival in the city
we made the most money. Write a query that returns one city that has the highest sum of invoices total
Return both the city namer and sum of all invoices total*/
  /*SELECT SUM(total),billing_city FROM invoice
  group by billing_city
  order by Sum(total) DESC*/
/*QUE 5 who is the best customer customer who has spent the most will be declared the best customer
write a query that returns the person who has spent the money most*/
 /*SELECT t1.customer_id,t1.first_name,t1.last_name ,SUM(t2.total) as 'total' FROM customer t1
 JOIN invoice  t2
 ON t1.customer_id=t2.customer_id
 GROUP  BY t1.customer_id
 ORDER BY total desc
LIMIT 1*/
/*MODERATE QUESTIONS*/
/*QUE 1 WRITE the query to return the email, first name,last email,& Genre of all rock music listners
  RETURN your list ordered alphabetically by email starting with  A*/
   /*SELECT DISTINCT email,first_name,last_name
   FROM customer
   JOIN invoice ON customer.customer_id=invoice.customer_id
   JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
   WHERE track_id IN
   (SELECT track_id from track t1
   JOIN genre t2
   ON t1.genre_id=t2.genre_id
   WHERE t2.name='rock')
   ORDER BY email*/
/*QUE2:let's invite the artists who have written the most rock music in our dataset.write a query that 
  Artist name and total track count of the top 10 rock bands*/
   /*SELECT artist.artist_id,artist.name,COUNT(artist.artist_id) AS 'number_of_songs' FROM track
   JOIN album2
   ON track.album_id=album2.album_id
   JOIN artist
   ON artist.artist_id=album2.artist_id
   JOIN genre
   ON genre.genre_id=track.genre_id
   WHERE genre.name LIKE 'rock'
   GROUP BY artist.artist_id
   order by number_of_songs DESC
   LIMIT 10*/
/*QUE 3 Return all the track names that have a song length longer than the average song length
  Return the NAME and milliseconds for each track ORDER  BY song length with longest songs listed first*/
    /*SELECT name,milliseconds from track where milliseconds>
   (SELECT AVG(milliseconds) FROM track)
    order by milliseconds DESC*/
/* QUESTIONS SET 3-ADVANCE*/
/*QUE1: find how much amount spent by each customer on artists? write a query to return cutomer name,artist name and total spent*/
/*WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album2 ON album2.album_id = track.album_id
	JOIN artist ON artist.artist_id = album2.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album2 alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;*/
/*QUE2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */
/*WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1**/


/*QUE3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
 For countries where the top amount spent is shared, provide all customers who spent this amount. */

/*WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1*/





