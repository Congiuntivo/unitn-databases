WITH directors AS (SELECT director
                   FROM movies
                   WHERE gross > 1000000
                     AND EXTRACT(YEAR FROM CURRENT_DATE) - movies.year <= 5)
SELECT DISTINCT award, directorawards.year, directorawards.director
FROM directorawards
         INNER JOIN directors ON directors.director = directorawards.director
WHERE directorawards.result = 'won'
UNION
SELECT DISTINCT award, aw.year, directors.director
FROM directors
         INNER JOIN movies AS m ON directors.director = m.director
         INNER JOIN movieawards AS aw ON m.title = aw.title AND m.year = aw.year
WHERE aw.result = 'won'
  AND aw.award LIKE '%best director%'
ORDER BY award, year, director;