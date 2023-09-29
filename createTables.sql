CREATE TABLE Phone
(
    IMEI        TEXT,
    modelNumber TEXT,
    modelName   TEXT,
    PRIMARY KEY (IMEI),
    FOREIGN KEY (modelNumber, modelName) REFERENCES PhoneModel (modelNumber, modelName),
    CHECK (LENGTH(IMEI) == 15 and IMEI REGEXP '^[0-9]*$')
);

CREATE TABLE PhoneModel
(
    modelNumber TEXT,
    modelName   TEXT,
    storage     INTEGER,
    colour      TEXT,
    baseCost    REAL,
    dailyCost   REAL,
    PRIMARY KEY (modelNumber)
);

CREATE TABLE rentalContract
(
    customerId INTEGER,
    IMEI       TEXT,
    dateOut    TEXT,
    dateBack   TEXT,
    rentalCost REAL,
    PRIMARY KEY (customerId, IMEI),
    FOREIGN KEY (IMEI) REFERENCES Phone (IMEI) ON DELETE SET NULL,
    FOREIGN KEY (customerId) REFERENCES Customer (customerId)
);

CREATE TABLE Customer
(
    customerId    INTEGER,
    customerName  TEXT,
    customerEmail TEXT,
    PRIMARY KEY (customerId)
);