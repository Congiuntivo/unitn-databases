SELECT DISTINCT award, aw.year, aw.director
FROM directorawards AS aw
         INNER JOIN movies AS m ON aw.director = m.director
WHERE gross > 1000000
  AND result = 'won'
  AND (EXTRACT(YEAR FROM CURRENT_DATE) - m.year) <= 5
UNION
SELECT DISTINCT award, aw.year, d.director
FROM directors AS d
         INNER JOIN movies AS m ON d.director = m.director
         INNER JOIN movieawards AS aw ON m.title = aw.title AND m.year = aw.year
WHERE gross > 1000000
  AND result = 'won'
  AND award LIKE '%best director%'
  AND (EXTRACT(YEAR FROM CURRENT_DATE) - m.year) <= 5
ORDER BY award, year, director;