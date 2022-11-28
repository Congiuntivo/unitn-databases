WITH
    film_spi AS
        (
            SELECT movies.title, movies.year, COUNT(movieawards.award) AS num
            FROM movieawards INNER JOIN movies ON movieawards.title = movieS.title AND movieawards.year = movies.year
            WHERE MOVIES.director = 'Spielberg' AND movieawards.result = 'won'
            GROUP BY movies.title, movies.year
            HAVING COUNT(*) >= 3
        ),
    best_dir AS
        (
            SELECT director, year
            FROM directorawards
            WHERE result = 'won'
            UNION DISTINCT
            SELECT director, movies.year
            FROM movies INNER JOIN movieawards ON movies.title = movieawards.title AND movies.year = movieawards.year
            WHERE award LIKE '%best director' AND result = 'won'
        ),
    to_avoid AS
        (
            SELECT *
            FROM (SELECT director FROM best_dir) AS dir CROSS JOIN (SELECT year FROM film_spi WHERE num >= 3) AS anni
            EXCEPT
            (SELECT * FROM best_dir)
        )
SELECT DISTINCT director
FROM best_dir
WHERE director NOT IN (SELECT director FROM to_avoid)
ORDER BY director;
