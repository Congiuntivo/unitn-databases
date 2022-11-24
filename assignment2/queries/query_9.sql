SELECT DISTINCT director
FROM movies INNER JOIN movieawards ON movies.title = movieawards.title AND movies.year = movieawards.year
WHERE movies.gross - movies.budget <= 0 AND movieawards.award LIKE '%best director' AND movieawards.result = 'won'
ORDER BY director;