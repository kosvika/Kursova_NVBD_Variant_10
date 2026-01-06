CREATE TABLE Subscribers (
    SubscriberID INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(200),
    SubscriberType NVARCHAR(50),
    City NVARCHAR(100),
    Status NVARCHAR(50),
    RegistrationDate DATE
);

CREATE TABLE ChannelGroups (
    ChannelGroupID INT IDENTITY PRIMARY KEY,
    GroupName NVARCHAR(100),
    Description NVARCHAR(200)
);

CREATE TABLE Movies (
    MovieID INT IDENTITY PRIMARY KEY,
    Title NVARCHAR(200),
    Genre NVARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE MovieOrders (
    OrderID BIGINT IDENTITY PRIMARY KEY,
    SubscriberID INT,
    MovieID INT,
    OrderDateTime DATETIME,
    PriceAtOrder DECIMAL(10,2),
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

CREATE TABLE Invoices (
    InvoiceID BIGINT IDENTITY PRIMARY KEY,
    SubscriberID INT,
    PeriodStart DATE,
    PeriodEnd DATE,
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(50),
    InvoiceDate DATE,
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID)
);

CREATE TABLE Payments (
    PaymentID BIGINT IDENTITY PRIMARY KEY,
    SubscriberID INT,
    InvoiceID BIGINT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    Method NVARCHAR(50),
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID)
);
