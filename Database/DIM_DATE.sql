CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    CalendarYear INT,
    CalendarMonth INT,
    MonthName NVARCHAR(20),
    Day INT,
    DayOfWeekName NVARCHAR(20)
);

WITH DateRange AS (
    SELECT CAST('2020-01-01' AS DATE) AS [Date]
    UNION ALL
    SELECT DATEADD(DAY, 1, [Date])
    FROM DateRange
    WHERE [Date] < '2025-12-31'
)
INSERT INTO DimDate
SELECT
    YEAR([Date]) * 10000 + MONTH([Date]) * 100 + DAY([Date]) AS DateKey,
    [Date] AS FullDate,
    YEAR([Date]) AS CalendarYear,
    MONTH([Date]) AS CalendarMonth,
    DATENAME(month, [Date]) AS MonthName,
    DAY([Date]) AS Day,
    DATENAME(weekday, [Date]) AS DayOfWeekName
FROM DateRange
OPTION (MAXRECURSION 0);

