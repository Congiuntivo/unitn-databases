WITH d AS (SELECT d3.director, yearofbirth
           FROM directorawards AS aw
                    JOIN directors d3 ON d3.director = aw.director
           WHERE award LIKE '%Oscar%'
             AND result = 'won'
           UNION
           SELECT d2.director, yearofbirth
           FROM movieawards AS aw
                    JOIN movies m ON aw.title = m.title AND aw.year = m.year
                    JOIN directors d2 ON m.director = d2.director
           WHERE award LIKE '%best director%'
             AND result = 'won'
           ORDER BY yearofbirth)
SELECT DISTINCT director, 'oldest' AS feature
FROM d
WHERE yearofbirth = (SELECT MIN(yearofbirth) FROM d)
UNION
SELECT DISTINCT director, 'youngest'
FROM d
WHERE yearofbirth = (SELECT MAX(yearofbirth) FROM d)
ORDER BY director;