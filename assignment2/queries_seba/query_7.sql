WITH temp AS ((SELECT d.director, yearofbirth
               FROM directors d
                        JOIN directorawards d2 on d.director = d2.director
               WHERE award LIKE '%Oscar%'
                 AND result = 'won')
              UNION
              (SELECT d.director, d.yearofbirth
               FROM directors d
                        JOIN movies a on a.director = d.director
                        JOIN movieawards m on a.year = m.year and a.title = m.title
               WHERE award LIKE '%Oscar, best director%'
                 AND result = 'won'))

    ((SELECT director, 'youngest' as feature
      FROM temp
      ORDER BY yearofbirth DESC
      LIMIT 1)
     UNION
     (SELECT director, 'oldest' as feature
      FROM temp
      ORDER BY yearofbirth
      LIMIT 1));

