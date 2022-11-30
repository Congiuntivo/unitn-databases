WITH
    directors_i_want AS (
        SELECT director
        FROM movies
        WHERE gross > 1000000 AND EXTRACT(YEAR FROM CURRENT_DATE) - movies.year <= 5
    )


(
SELECT DISTINCT award, directorawards.year, directorawards.director
FROM directorawards INNER JOIN directors_i_want ON directors_i_want.director = directorawards.director
WHERE directorawards.result = 'won'
UNION DISTINCT
SELECT DISTINCT award, movieawards.year, directors_i_want.director
FROM directors_i_want INNER JOIN movies ON directors_i_want.director = movies.director
INNER JOIN movieawards ON movies.title = movieawards.title and movies.year = movieawards.year
WHERE gross > 1000000 AND movieawards.award LIKE '%best director%' AND movieawards.result = 'won'
)
ORDER BY award, year, director;
