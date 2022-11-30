WITH oscars AS
         (SELECT d.director, d.yearofbirth
          FROM directors AS d
                   INNER JOIN directorawards AS aw ON d.director = aw.director
          WHERE aw.result = 'won'
            AND aw.award LIKE '%Oscar%'
          UNION
          DISTINCT
          SELECT directors.director, directors.yearofbirth
          FROM directors
                   INNER JOIN movies ON movies.director = directors.director
                   INNER JOIN movieawards AS mw ON mw.title = movies.title AND movies.year = mw.year
          WHERE mw.result = 'won'
            AND mw.award LIKE '%Oscar%best director%')
SELECT DISTINCT oscars.director, 'oldest' AS feature
FROM oscars
WHERE oscars.yearofbirth = (SELECT MIN(yearofbirth) FROM oscars)
UNION
SELECT DISTINCT oscars.director, 'youngest' AS feature
FROM oscars
WHERE oscars.yearofbirth = (SELECT MAX(yearofbirth) FROM oscars)
ORDER BY director, feature;