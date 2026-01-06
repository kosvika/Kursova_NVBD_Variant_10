DECLARE @StartDate date, @EndDate date;

SELECT
  @StartDate = MIN(CAST(o.OrderDateTime AS date)),
  @EndDate   = MAX(CAST(o.OrderDateTime AS date))
FROM CableTV_OLTP.dbo.MovieOrders o;

;WITH n AS (
  SELECT 0 AS i
  UNION ALL
  SELECT i + 1 FROM n WHERE i < DATEDIFF(day, @StartDate, @EndDate)
)
INSERT INTO dbo.DimDate (DateKey, FullDate, CalendarYear, CalendarMonth, MonthName, Day, DayOfWeekName)
SELECT
  CONVERT(int, CONVERT(char(8), DATEADD(day, i, @StartDate), 112)) AS DateKey,
  DATEADD(day, i, @StartDate) AS FullDate,
  YEAR(DATEADD(day, i, @StartDate)) AS CalendarYear,
  MONTH(DATEADD(day, i, @StartDate)) AS CalendarMonth,
  DATENAME(month, DATEADD(day, i, @StartDate)) AS MonthName,
  DAY(DATEADD(day, i, @StartDate)) AS [Day],
  DATENAME(weekday, DATEADD(day, i, @StartDate)) AS DayOfWeekName
FROM n
WHERE NOT EXISTS (
  SELECT 1
  FROM dbo.DimDate d
  WHERE d.DateKey = CONVERT(int, CONVERT(char(8), DATEADD(day, i, @StartDate), 112))
)
OPTION (MAXRECURSION 0);
