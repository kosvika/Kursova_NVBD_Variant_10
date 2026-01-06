SELECT TOP 20 *
FROM dbo.FactInvoices
WHERE ABS((ISNULL(PaidAmount,0) + ISNULL(DebtAmount,0)) - ISNULL(TotalAmount,0)) > 0.01;
