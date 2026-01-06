DECLARE @OrdersTotal int = 1000000;
DECLARE @Batch int = 100000;
DECLARE @Inserted int = 0;

DECLARE @MinSub int = (SELECT MIN(SubscriberID) FROM dbo.Subscribers);
DECLARE @MaxSub int = (SELECT MAX(SubscriberID) FROM dbo.Subscribers);

DECLARE @MinMovie int = (SELECT MIN(MovieID) FROM dbo.Movies);
DECLARE @MaxMovie int = (SELECT MAX(MovieID) FROM dbo.Movies);

WHILE @Inserted < @OrdersTotal
BEGIN
  ;WITH n AS (
    SELECT TOP (@Batch) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS i
    FROM sys.all_objects a CROSS JOIN sys.all_objects b
  )
  INSERT INTO dbo.MovieOrders (SubscriberID, MovieID, OrderDateTime, PriceAtOrder)
  SELECT
    @MinSub + (ABS(CHECKSUM(NEWID())) % (@MaxSub - @MinSub + 1)),
    @MinMovie + (ABS(CHECKSUM(NEWID())) % (@MaxMovie - @MinMovie + 1)),
    DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % (60*24*365*5), DATEADD(YEAR,-5,GETDATE())),
    CAST(50 + (ABS(CHECKSUM(NEWID())) % 250) + (ABS(CHECKSUM(NEWID())) % 100)/100.0 AS decimal(10,2));

  SET @Inserted += @@ROWCOUNT;
  PRINT CONCAT('Inserted orders: ', @Inserted);
END
