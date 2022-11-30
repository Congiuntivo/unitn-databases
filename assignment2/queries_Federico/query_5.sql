WITH w AS (SELECT title,
                  year,
                  SUM(CASE WHEN result = 'won' THEN 1.0 ELSE 0.0 END) AS won,
                  COUNT(year)                                         AS tot
           FROM movieawards
           GROUP BY title, year)
    (SELECT DISTINCT title, year, -1.0 AS "success-rate"
     FROM movies
     WHERE title NOT IN (SELECT title FROM movieawards))
UNION
SELECT DISTINCT title, year, ROUND(CAST(won / tot AS DECIMAL), 2)
FROM w
ORDER BY title, year, "success-rate";