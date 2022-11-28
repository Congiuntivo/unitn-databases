WITH temp AS (SELECT title, year
              FROM movieawards
              WHERE result = 'won'
              GROUP BY title, year
              HAVING count(*) >= 3
              ORDER BY year DESC)
SELECT DISTINCT title, year
FROM temp
WHERE year = (SELECT MAX(year) FROM temp);

