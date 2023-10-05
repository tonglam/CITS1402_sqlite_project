CREATE VIEW CustomerSummary AS
SELECT a.customerId,
       b.modelName,
       sum(julianday(a.dateBack) - julianday(a.dateOut) + 1) as daysRented,
       CASE
           WHEN strftime('%m-%d', a.dateBack) < '07-01' THEN strftime('%Y', a.dateBack, '-1 year') || '/' ||
                                                             substr(strftime('%Y', a.dateBack), 3)
           ELSE strftime('%Y', a.dateBack) || '/' || substr(strftime('%Y', a.dateBack, '+1 year'), 3)
           END                                               as taxYear,
       round(sum(a.rentalCost), 2)                           as rentalCost
FROM rentalContract a
         LEFT JOIN Phone b USING (IMEI)
WHERE a.dateBack IS NOT NULL
GROUP BY a.customerId, b.modelName, taxYear;
