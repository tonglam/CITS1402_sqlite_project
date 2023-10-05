CREATE TRIGGER calRentalCost
    AFTER UPDATE
        OF dateBack
    ON rentalContract
    FOR EACH ROW
BEGIN
    UPDATE rentalContract
    SET rentalCost = (SELECT baseCost + dailyCost * (julianday(NEW.dateBack) - julianday(NEW.dateOut) + 1)
                      FROM Phone
                               JOIN PhoneModel USING (modelNumber)
                      WHERE Phone.IMEI = NEW.IMEI)
    WHERE customerId = NEW.customerId
      AND IMEI = NEW.IMEI
      AND dateOut = NEW.dateOut
      AND OLD.rentalCost IS NULL;
END;
