SELECT title, year
FROM movieawards
WHERE year = (SELECT year
              FROM movieawards
              WHERE result = 'won'
              GROUP BY title, year
              HAVING count(result) >= 3
              ORDER BY year DESC
              LIMIT 1)
  AND result = 'won'
GROUP BY title, year
HAVING count(result) >= 3
ORDER BY 1;

