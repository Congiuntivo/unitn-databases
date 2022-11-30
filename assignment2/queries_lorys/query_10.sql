WITH years_spielberg AS
         (SELECT m.year
          FROM movieawards m
                   JOIN movies m2 on m2.title = m.title and m2.year = m.year
          WHERE director = 'Spielberg'
            AND result = 'won'
          GROUP BY m.year
          HAVING count(m.year) >= 3)
SELECT director
FROM directorawards d
         JOIN years_spielberg y ON d.year = y.year
WHERE director != 'Spielberg' AND result = 'won'
GROUP BY director
HAVING count(DISTINCT d.year) = (SELECT count(*) FROM years_spielberg)
UNION
SELECT director
FROM movieawards m
         JOIN movies m3 on m3.title = m.title and m3.year = m.year
         JOIN years_spielberg y ON m.year = y.year
WHERE director != 'Spielberg' AND award LIKE '%best director' AND result = 'won'
GROUP BY director
HAVING count(DISTINCT y.year) = (SELECT count(*) FROM years_spielberg);