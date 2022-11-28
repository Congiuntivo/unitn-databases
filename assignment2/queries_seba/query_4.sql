(SELECT DISTINCT award, year, director
 FROM directorawards
 WHERE director IN (SELECT director
                    FROM movies
                    WHERE gross > 1000000
                      AND year > 2017))
UNION
(SELECT DISTINCT a.award, a.year, director
 FROM movieawards a,
      movies m
 WHERE m.year = a.year
   AND m.title = a.title
   AND a.award LIKE '%best director%'
   AND director IN (SELECT director
                    FROM movies
                    WHERE gross > 1000000
                      AND year > 2017))