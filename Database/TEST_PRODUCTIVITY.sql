SELECT d.CalendarYear, SUM(o.TotalAmount) AS Revenue
FROM dbo.FactMovieOrders o
JOIN dbo.DimDate d ON d.DateKey = o.DateKey
GROUP BY d.CalendarYear
ORDER BY d.CalendarYear;
