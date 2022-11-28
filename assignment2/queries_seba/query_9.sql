SELECT DISTINCT director
FROM movies m
         JOIN movieawards a on a.year = m.year and a.title = m.title
WHERE award LIKE '%best director%'
  AND m.gross <= m.budget
  AND result = 'won';