SELECT DISTINCT title
FROM movieawards
WHERE award LIKE '%Oscar%'
GROUP BY title, year
HAVING count(*) = (SELECT count(*)
                   FROM movieawards
                   WHERE award LIKE '%Oscar%'
                   GROUP BY title, year
                   ORDER BY count(*) DESC
                   LIMIT 1);
