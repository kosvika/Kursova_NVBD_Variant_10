CREATE TABLE FactInvoices (
    InvoiceKey BIGINT IDENTITY PRIMARY KEY,
    SubscriberKey INT,
    DateKey INT,
    TotalAmount DECIMAL(10,2),
    PaidAmount DECIMAL(10,2),
    DebtAmount DECIMAL(10,2),

    FOREIGN KEY (SubscriberKey) REFERENCES DimSubscriber(SubscriberKey),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);
