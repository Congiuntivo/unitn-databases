WITH
    film_spi AS
        (
            SELECT movies.title, movies.year, COUNT(movieawards.award) AS num
            FROM movieawards INNER JOIN movies ON movieawards.title = movieS.title AND movieawards.year = movies.year
            WHERE MOVIES.director = 'Spielberg' AND movieawards.result = 'won'
            GROUP BY movies.title, movies.year
        )
SELECT DISTINCT director
FROM movies INNER JOIN movieawards ON movies.title = movieawards.title AND movies.year = movieawards.year
WHERE movieawards.award LIKE '%best director' AND movieawards.result = 'won' AND movies.year IN (SELECT film_spi.year FROM film_spi WHERE num >=3)
ORDER BY director;