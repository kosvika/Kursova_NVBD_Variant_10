DECLARE @StartDate date, @EndDate date;

;WITH all_dates AS (
  SELECT CAST(o.OrderDateTime AS date) AS d
  FROM CableTV_OLTP.dbo.MovieOrders o
  UNION ALL
  SELECT CAST(i.InvoiceDate AS date) FROM CableTV_OLTP.dbo.Invoices i WHERE i.InvoiceDate IS NOT NULL
  UNION ALL
  SELECT CAST(i.PeriodStart AS date) FROM CableTV_OLTP.dbo.Invoices i WHERE i.PeriodStart IS NOT NULL
  UNION ALL
  SELECT CAST(i.PeriodEnd AS date)   FROM CableTV_OLTP.dbo.Invoices i WHERE i.PeriodEnd IS NOT NULL
)
SELECT
  @StartDate = MIN(d),
  @EndDate   = MAX(d)
FROM all_dates;

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
