CREATE OR ALTER PROCEDURE dbo.sp_Top10MoviesByRevenue
    @CalendarYear int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (10)
           fmo.MovieKey,
           SUM(fmo.TotalAmount) AS Revenue
    FROM dbo.FactMovieOrders fmo
    INNER JOIN dbo.DimDate d
        ON d.DateKey = fmo.DateKey
    WHERE d.CalendarYear = @CalendarYear
    GROUP BY fmo.MovieKey
    ORDER BY Revenue DESC;
END;
GO
