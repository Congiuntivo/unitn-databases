(SELECT DISTINCT d.director,
                 MIN(m.gross - m.budget),
                 MAX(m.gross - m.budget),
                 TRUNC(AVG(m.gross - m.budget), 2) as AVG
 FROM directors d
          JOIN movies m on d.director = m.director
 WHERE EXTRACT(YEAR FROM CURRENT_DATE) - yearofbirth > 50
 GROUP BY d.director)
UNION
(SELECT DISTINCT director, -1, -1, -1
 FROM directors
 WHERE EXTRACT(YEAR FROM CURRENT_DATE) - yearofbirth > 50
   AND director NOT IN (SELECT director FROM movies));
