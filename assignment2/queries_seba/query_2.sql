SELECT DISTINCT title
FROM movieawards
WHERE year = (SELECT year
              FROM movieawards
              GROUP BY title, year
              HAVING count(*) >= 3
              ORDER BY year DESC
              LIMIT 1)
GROUP BY title, year
HAVING count(*) >= 3

