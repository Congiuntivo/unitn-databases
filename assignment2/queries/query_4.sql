(SELECT DISTINCT award, directorawards.year, directorawards.director
FROM directorawards INNER JOIN movies ON directorawards.director = movies.director
WHERE gross > 1000000 AND EXTRACT(YEAR FROM CURRENT_DATE) - movies.year <= 5 AND directorawards.result = 'won'
UNION DISTINCT
SELECT DISTINCT award, movieawards.year, directors.director
FROM directors INNER JOIN movies ON directors.director = movies.director
INNER JOIN movieawards ON movies.title = movieawards.title and movies.year = movieawards.year
WHERE gross > 1000000 AND EXTRACT(YEAR FROM CURRENT_DATE) - movies.year <= 5
    AND movieawards.award LIKE '%best director' AND movieawards.result = 'won')
ORDER BY director, award, year, director;
