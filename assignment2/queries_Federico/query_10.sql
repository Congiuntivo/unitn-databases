WITH wyears AS (SELECT DISTINCT m.year AS year
                FROM movieawards a
                         JOIN movies m ON m.title = a.title AND m.year = a.year
                WHERE director = 'Spielberg'
                  AND result = 'won'
                GROUP BY m.year, m.title
                HAVING COUNT(m.year) >= 3)
SELECT DISTINCT director
FROM directors d
WHERE EXISTS((SELECT * FROM wyears))
  AND NOT EXISTS(
            (SELECT year FROM wyears)
            EXCEPT
            SELECT aw.year
            FROM directorawards aw
            WHERE aw.director = d.director
              AND aw.result = 'won'
            UNION
            SELECT mw.year
            FROM movieawards mw
                     JOIN movies m ON mw.title = m.title AND mw.year = m.year
            WHERE mw.result = 'won'
              AND mw.award LIKE '%best director%'
              AND m.director = d.director)
ORDER BY director;