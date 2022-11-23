WITH
    d_oscar AS
        (
            SELECT directors.director, directors.yearofbirth
            FROM directors INNER JOIN directorawards ON directors.director = directorawards.director
            WHERE directorawards.result = 'won' AND directorawards.award = 'Oscar'
            UNION DISTINCT
            SELECT directors.director, directors.yearofbirth
            FROM directors
                INNER JOIN movies ON movies.director = directors.director
                INNER JOIN movieawards ON movieawards.title = movies.title AND movies.year = movieawards.year
            WHERE movieawards.result = 'won' AND movieawards.award = 'Oscar, best director'
        )
SELECT DISTINCT d_oscar.director, 'youngest' AS feature
FROM d_oscar
WHERE d_oscar.yearofbirth = (SELECT MAX(yearofbirth) FROM d_oscar)
UNION
SELECT DISTINCT d_oscar.director, 'oldest' AS feature
FROM d_oscar
WHERE d_oscar.yearofbirth = (SELECT MIN(yearofbirth) FROM d_oscar)
ORDER BY director, feature;

