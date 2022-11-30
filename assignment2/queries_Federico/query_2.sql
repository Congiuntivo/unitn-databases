WITH t AS (SELECT title, year
           FROM movieawards
           WHERE result = 'won'
           GROUP BY title, year
           HAVING COUNT(result) >= 3)
SELECT title, year
FROM t
WHERE year = (SELECT MAX(year) FROM t)
ORDER BY title, year;