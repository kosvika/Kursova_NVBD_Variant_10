CREATE TABLE DimSubscriber (
    SubscriberKey INT IDENTITY PRIMARY KEY,
    SubscriberID INT,   -- ключ із OLTP
    FullName NVARCHAR(200),
    SubscriberType NVARCHAR(50),
    City NVARCHAR(100),
    Status NVARCHAR(50),
    ValidFrom DATE,
    ValidTo DATE,
    IsCurrent BIT
);
