SELECT DISTINCT director
FROM movies m
         JOIN movieawards m2 on m.title = m2.title and m.year = m2.year
WHERE gross - budget <= 0
  AND award LIKE '%best director'
  AND result = 'won';