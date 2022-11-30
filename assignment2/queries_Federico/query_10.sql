WITH films AS
         (SELECT movies.title, movies.year, COUNT(movieawards.award) AS num
          FROM movieawards
                   INNER JOIN movies ON movieawards.title = movieS.title AND movieawards.year = movies.year
          WHERE MOVIES.director = 'Spielberg'
            AND movieawards.result = 'won'
          GROUP BY movies.title, movies.year
          HAVING COUNT(*) >= 3),
     dir AS
         (SELECT director, year
          FROM directorawards
          WHERE result = 'won'
          UNION
          DISTINCT
          SELECT director, movies.year
          FROM movies
                   INNER JOIN movieawards ON movies.title = movieawards.title AND movies.year = movieawards.year
          WHERE award LIKE '%best director'
            AND result = 'won'),
     excluded AS
         (SELECT *
          FROM (SELECT director FROM dir) AS dir
                   CROSS JOIN (SELECT year FROM films) AS anni
          EXCEPT
          (SELECT * FROM dir))
SELECT DISTINCT director
FROM dir
WHERE EXISTS(SELECT * FROM films)
  AND director NOT IN (SELECT director FROM excluded)
ORDER BY director;