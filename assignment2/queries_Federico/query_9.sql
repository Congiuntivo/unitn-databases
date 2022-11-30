SELECT DISTINCT director
FROM movies AS m
         INNER JOIN movieawards AS aw ON m.title = aw.title AND m.year = aw.year
WHERE (m.gross - m.budget <= 0)
  AND aw.award LIKE '%best director'
  AND aw.result = 'won'
ORDER BY director;