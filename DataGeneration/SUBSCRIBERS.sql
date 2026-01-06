DECLARE @Subs int = 100000;

;WITH n AS (
  SELECT TOP (@Subs) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS i
  FROM sys.all_objects a CROSS JOIN sys.all_objects b
)
INSERT INTO dbo.Subscribers (FullName, SubscriberType, City, Status, RegistrationDate)
SELECT
  CONCAT(N'User ', i),
  CHOOSE(1 + ABS(CHECKSUM(NEWID())) % 4, N'Basic', N'Standard', N'Premium', N'VIP'),
  CHOOSE(1 + ABS(CHECKSUM(NEWID())) % 8, N'Kyiv', N'Lviv', N'Kharkiv', N'Odesa', N'Dnipro', N'Zaporizhzhia', N'Vinnytsia', N'Poltava'),
  CHOOSE(1 + ABS(CHECKSUM(NEWID())) % 3, N'Active', N'Inactive', N'Suspended'),
  DATEADD(DAY, - (ABS(CHECKSUM(NEWID())) % (365*5)), CAST(GETDATE() AS date))
FROM n;
