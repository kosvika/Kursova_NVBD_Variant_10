-- інвойси без підписника/дати
SELECT COUNT(*) AS BrokenInvoices
FROM dbo.FactInvoices f
LEFT JOIN dbo.DimSubscriber s ON s.SubscriberKey = f.SubscriberKey
LEFT JOIN dbo.DimDate d ON d.DateKey = f.DateKey
WHERE s.SubscriberKey IS NULL OR d.DateKey IS NULL;

-- замовлення без підписника/дати/фільму
SELECT COUNT(*) AS BrokenOrders
FROM dbo.FactMovieOrders o
LEFT JOIN dbo.DimSubscriber s ON s.SubscriberKey = o.SubscriberKey
LEFT JOIN dbo.DimDate d ON d.DateKey = o.DateKey
LEFT JOIN dbo.DimMovie m ON m.MovieKey = o.MovieKey
WHERE s.SubscriberKey IS NULL OR d.DateKey IS NULL OR m.MovieKey IS NULL;
