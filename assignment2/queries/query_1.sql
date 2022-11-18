SELECT
    COALESCE(MIN(movies.gross - movies.budget), -1) AS min,
    COALESCE(MAX(movies.gross - movies.budget), -1) AS max,
    COALESCE(TRUNC(AVG(movies.gross - movies.budget), 2), -1.00) AS avg
FROM directors LEFT JOIN movies ON directors.director = movies.director
WHERE directors.yearofbirth > 1972
GROUP BY directors.director;

SELECT CAST(1 AS DECIMAL(100,2));