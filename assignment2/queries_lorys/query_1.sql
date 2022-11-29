SELECT d.director,
       coalesce(min(gross - budget), -1)           as minimum,
       coalesce(max(gross - budget), -1)           as maximum,
       round(coalesce(avg(gross - budget), -1), 2) as average
FROM directors d
         LEFT JOIN movies m ON d.director = m.director
WHERE (extract('year' FROM current_date) - yearofbirth) > 50
GROUP BY d.director
ORDER BY 1;