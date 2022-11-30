WITH np AS (SELECT DISTINCT director FROM movies WHERE gross - budget <= 0 ORDER BY director)
SELECT DISTINCT director
FROM movieawards AS aw
         JOIN movies m ON m.title = aw.title AND m.year = aw.year
WHERE award LIKE '%best director%'
  AND result = 'won'
  AND director IN (SELECT director FROM np)
ORDER BY director;
