USE CableTV_OLTP;
SET NOCOUNT ON;

DECLARE @Movies int = 5000;

;WITH n AS (
  SELECT TOP (@Movies) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS i
  FROM sys.all_objects a CROSS JOIN sys.all_objects b
)
INSERT INTO dbo.Movies (Title, Genre, Price)
SELECT
  CONCAT(N'Movie ', i),
  CHOOSE(1 + ABS(CHECKSUM(NEWID())) % 8,
         N'Action', N'Comedy', N'Drama', N'Horror', N'Sci-Fi', N'Romance', N'Thriller', N'Animation'),
  CAST(50 + (ABS(CHECKSUM(NEWID())) % 250) + (ABS(CHECKSUM(NEWID())) % 100)/100.0 AS decimal(10,2))
FROM n;
