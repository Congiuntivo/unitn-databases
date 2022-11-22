(SELECT DISTINCT 'most profitable' AS feature, title, year
FROM movies
WHERE  movies.gross - movies.budget = (SELECT MAX(movies.gross - movies.budget) FROM movies)
UNION ALL
SELECT DISTINCT 'least expensive' AS feature, title, year
FROM movies
WHERE  movies.budget = (SELECT MIN(movies.budget) FROM movies))
ORDER BY feature, title, year;