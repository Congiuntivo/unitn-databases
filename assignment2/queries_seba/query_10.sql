WITH tmp AS (SELECT DISTINCT m.year as year
             FROM movieawards a
                      JOIN movies m on m.title = a.title and m.year = a.year
             WHERE director = 'Spielberg'
               AND result = 'won'
             group by m.year, m.title
             HAVING count(*) >= 3)
SELECT director
FROM directors d
WHERE NOT EXISTS(
            (SELECT year FROM tmp)
            EXCEPT
            ((SELECT a.year FROM directorawards a WHERE a.director = d.director AND a.result = 'won')
             UNION
             (SELECT a.year
              FROM movieawards a
                       JOIN movies m ON a.title = m.title and a.year = m.year
              WHERE a.result = 'won'
                AND a.award LIKE '%best director%'
                AND m.director = d.director)))
