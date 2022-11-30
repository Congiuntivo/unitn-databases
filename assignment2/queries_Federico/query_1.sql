SELECT DISTINCT d.director                                      AS Director,
                COALESCE(MIN(m.gross - m.budget), -1)           AS min,
                COALESCE(MAX(m.gross - m.budget), -1)           AS max,
                COALESCE(ROUND(AVG(m.gross - m.budget), 2), -1) AS avg
FROM directors AS d
         LEFT JOIN movies AS m ON d.director = m.director
WHERE (EXTRACT(YEAR FROM CURRENT_DATE) - yearofbirth) > 50
GROUP BY d.director
ORDER BY d.director, min, max, avg;
