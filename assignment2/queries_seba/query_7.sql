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

    ((SELECT d.director, 'youngest' as feature
      FROM directors d
               JOIN temp t ON d.director = t.director
      WHERE d.yearofbirth = (SELECT max(yearofbirth) FROM temp))
     UNION
     (SELECT d.director, 'oldest' as feature
      FROM directors d
               JOIN temp t ON d.director = t.director
      WHERE d.yearofbirth = (SELECT min(yearofbirth) FROM temp)));

