CREATE TABLE DimMovie (
    MovieKey INT IDENTITY PRIMARY KEY,
    MovieID INT,
    Title NVARCHAR(200),
    Genre NVARCHAR(100),
    Price DECIMAL(10,2)
);
