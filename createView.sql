CREATE VIEW CustomerSummary AS
SELECT a.customerId,
       c.modelName,
       sum(julianday(a.dateBack) - julianday(a.dateOut)) as daysRented,
       CASE
           WHEN strftime('%m-%d', a.dateBack) < '07-01' THEN strftime('%Y', a.dateBack, '-1 year') || '/' ||
                                                             substr(strftime('%Y', a.dateBack), 3)
           ELSE strftime('%Y', a.dateBack) || '/' || substr(strftime('%Y', a.dateBack, '+1 year'), 3)
           END                                           as taxYear,
       sum(a.rentalCost)                                 as rentalCost
FROM rentalContract a
         JOIN Phone b USING (IMEI)
         JOIN PhoneModel c USING (modelNumber)
WHERE a.dateBack IS NOT NULL;
