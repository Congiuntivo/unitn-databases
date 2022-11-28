SELECT DISTINCT 'most profitable' as feature, title, year
FROM movies
WHERE gross - budget = (SELECT MAX(gross - budget) FROM movies)
UNION

SELECT DISTINCT 'least expensive' as feature, title, year
FROM movies
WHERE budget = (SELECT MIN(budget) FROM movies);