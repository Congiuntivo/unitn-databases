SELECT DISTINCT title, year
FROM movieawards
WHERE award LIKE '%Oscar%'
  AND result = 'won'
GROUP BY title, year
HAVING count(*) = (SELECT count(*)
                   FROM movieawards
                   WHERE award LIKE '%Oscar%'
                     AND result = 'won'
                   GROUP BY title, year
                   ORDER BY count(*) DESC
                   LIMIT 1);
