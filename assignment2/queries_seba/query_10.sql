SELECT DISTINCT director
FROM directorawards
WHERE year = ALL (SELECT a.year
                  FROM movieawards a
                           JOIN movies m on m.title = a.title and m.year = a.year
                  WHERE director = 'Spielberg'
                  GROUP BY a.year, a.title
                  HAVING count(*) >= 3);
