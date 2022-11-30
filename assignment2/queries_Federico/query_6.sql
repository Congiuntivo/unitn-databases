WITH f AS (SELECT title, year, COUNT(award) AS oscars
           FROM movieawards
           WHERE award LIKE '%Oscar%'
             AND result = 'won'
           GROUP BY title, year
           ORDER BY oscars DESC)
SELECT title, year
FROM f
WHERE oscars = (SELECT MAX(oscars) FROM f);