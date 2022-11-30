WITH movieawardtable AS
         (SELECT m2.director, yearofbirth
          FROM (movieawards m
              JOIN movies m2 on m2.title = m.title and m2.year = m.year)
                   JOIN directors d on d.director = m2.director
          WHERE award LIKE 'Oscar%best director%'
            AND result = 'won'),
     directorawardtable AS
         (SELECT d.director, yearofbirth
          from directorawards d
                   JOIN directors d2 on d2.director = d.director
          WHERE award LIKE 'Oscar%'
            AND result = 'won'),
     unified AS
         (SELECT *
          FROM movieawardtable
          UNION
          SELECT *
          from directorawardtable),
     oldest AS
         (SELECT *
          FROM unified
          WHERE yearofbirth = (SELECT min(yearofbirth)
                               FROM unified)),
     youngest AS
         (SELECT *
          FROM unified
          WHERE yearofbirth = (SELECT max(yearofbirth)
                               FROM unified))
SELECT director, 'oldest' as feature
from oldest
UNION ALL
SELECT director, 'youngest' as feature
FROM youngest;