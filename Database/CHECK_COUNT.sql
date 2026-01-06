SELECT 'FactMovieOrders' AS t, COUNT(*) AS c FROM dbo.FactMovieOrders
UNION ALL
SELECT 'FactInvoices', COUNT(*) FROM dbo.FactInvoices
UNION ALL
SELECT 'DimSubscriber', COUNT(*) FROM dbo.DimSubscriber
UNION ALL
SELECT 'DimMovie', COUNT(*) FROM dbo.DimMovie
UNION ALL
SELECT 'DimDate', COUNT(*) FROM dbo.DimDate;
