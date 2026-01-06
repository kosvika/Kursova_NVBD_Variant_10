CREATE OR ALTER FUNCTION dbo.fn_DebtRatio
(
    @PaidAmount decimal(10,2),
    @DebtAmount decimal(10,2)
)
RETURNS decimal(10,4)
AS
BEGIN
    DECLARE @total decimal(10,2) = ISNULL(@PaidAmount,0) + ISNULL(@DebtAmount,0);

    IF @total = 0
        RETURN 0;

    RETURN CAST(ISNULL(@DebtAmount,0) / @total AS decimal(10,4));
END;
GO
