SELECT
    COALESCE(MIN(movies.gross - movies.budget), -1) AS minimum,
    COALESCE(MAX(movies.gross - movies.budget), -1) AS maximum,
    COALESCE(TRUNC(AVG(movies.gross - movies.budget), 2), -1) AS average
FROM directors LEFT JOIN movies ON directors.director = movies.director
WHERE EXTRACT(YEAR FROM CURRENT_DATE) -  directors.yearofbirth > 50
GROUP BY directors.director
ORDER BY min, max, avg;