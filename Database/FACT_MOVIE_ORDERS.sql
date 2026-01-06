CREATE TABLE FactMovieOrders (
    MovieOrderKey BIGINT IDENTITY PRIMARY KEY,
    SubscriberKey INT,
    MovieKey INT,
    DateKey INT,
    OrderCount INT,
    TotalAmount DECIMAL(10,2),

    FOREIGN KEY (SubscriberKey) REFERENCES DimSubscriber(SubscriberKey),
    FOREIGN KEY (MovieKey) REFERENCES DimMovie(MovieKey),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);
