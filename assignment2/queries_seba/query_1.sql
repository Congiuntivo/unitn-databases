(SELECT DISTINCT MIN(movies.gross),
                 MAX(movies.gross),
                 ROUND(AVG(movies.gross), 2) as AVG,
                 directors.director
 FROM directors,
      movies
 WHERE yearofbirth > 1972
   and movies.director = directors.director
 GROUP BY directors.director)
UNION
(SELECT DISTINCT -1, -1, -1, director
 FROM directors
 WHERE yearofbirth > 1972
   AND director NOT IN (SELECT director FROM movies));