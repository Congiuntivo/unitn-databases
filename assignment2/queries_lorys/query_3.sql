WITH least_expensive AS
         (SELECT title, year
          FROM movies
          WHERE budget = (SELECT min(budget) FROM movies)),
     most_profitable AS
         (SELECT title, year
          FROM movies
          WHERE (gross - budget) = (SELECT max(gross - budget) FROM movies))
SELECT 'least expensive' as feature, *
FROM least_expensive
UNION ALL
SELECT 'most profitable' as feature, *
FROM most_profitable
ORDER BY 1;
