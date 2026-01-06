INSERT INTO dbo.Payments (SubscriberID, InvoiceID, PaymentDate, Amount, Method)
SELECT
    i.SubscriberID,
    i.InvoiceID,
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 30, i.InvoiceDate),
    CASE 
        WHEN i.Status = N'Paid' THEN i.TotalAmount
        WHEN i.Status = N'Partial' THEN CAST(i.TotalAmount * 0.5 AS decimal(10,2))
        ELSE 0
    END,
    CHOOSE(1 + ABS(CHECKSUM(NEWID())) % 4, N'Card', N'Cash', N'Bank', N'Online')
FROM dbo.Invoices i
WHERE ABS(CHECKSUM(NEWID())) % 10 < 7;
