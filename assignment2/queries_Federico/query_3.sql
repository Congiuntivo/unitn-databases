SELECT DISTINCT 'least expensive' AS feature, title, year
FROM movies
WHERE budget = (SELECT MIN(budget) FROM movies)
UNION
SELECT DISTINCT 'most profitable' AS feature, title, year
FROM movies
WHERE (gross - budget) = (SELECT MAX(gross - budget) FROM movies)
ORDER BY feature, title, year;
