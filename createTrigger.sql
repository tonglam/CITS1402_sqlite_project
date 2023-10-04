CREATE TRIGGER calRentalCost
    AFTER UPDATE
    ON rentalContract
    FOR EACH ROW
BEGIN
    UPDATE rentalContract
    SET rentalCost = (SELECT baseCost + dailyCost * (julianday(NEW.dateBack) - julianday(NEW.dateOut))
                      FROM Phone
                               JOIN PhoneModel USING (modelNumber)
                      WHERE Phone.IMEI = NEW.IMEI)
    WHERE customerId = NEW.customerId
      AND IMEI = NEW.IMEI
      AND OLD.rentalCost IS NULL;
END;
