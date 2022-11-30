WITH tmp AS (SELECT director
             FROM movies
             WHERE gross > 1000000
               AND EXTRACT(YEAR FROM CURRENT_DATE) - year <= 5)

SELECT DISTINCT award, year, director
FROM directorawards
WHERE result = 'won'
  AND director IN (SELECT * FROM tmp)
UNION
SELECT DISTINCT a.award, a.year, director
FROM movieawards a
         JOIN movies m on a.title = m.title and a.year = m.year
    AND a.award LIKE '%best director%'
    AND a.result = 'won'
    AND director IN (SELECT * FROM tmp)
ORDER BY award, year, director;