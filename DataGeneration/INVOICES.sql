USE CableTV_OLTP;
SET NOCOUNT ON;

DECLARE @MinSub int = (SELECT MIN(SubscriberID) FROM dbo.Subscribers);
DECLARE @MaxSub int = (SELECT MAX(SubscriberID) FROM dbo.Subscribers);

DECLARE @InvTotal int = 500000;
DECLARE @InvBatch int = 100000;
DECLARE @InvInserted int = 0;

WHILE @InvInserted < @InvTotal
BEGIN
    ;WITH n AS (
        SELECT TOP (@InvBatch) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS i
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )
    INSERT INTO dbo.Invoices
        (SubscriberID, PeriodStart, PeriodEnd, TotalAmount, Status, InvoiceDate)
    SELECT
        @MinSub + ABS(CHECKSUM(NEWID())) % (@MaxSub - @MinSub + 1),
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % (365*5), CAST(GETDATE() AS date)),
        DATEADD(DAY, 30, DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % (365*5), CAST(GETDATE() AS date))),
        CAST(100 + ABS(CHECKSUM(NEWID())) % 900 AS decimal(10,2)),
        CHOOSE(1 + ABS(CHECKSUM(NEWID())) % 3, N'Paid', N'Unpaid', N'Partial'),
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % (365*5), CAST(GETDATE() AS date))
    FROM n;

    SET @InvInserted += @@ROWCOUNT;
    PRINT CONCAT('Inserted invoices: ', @InvInserted);
END
