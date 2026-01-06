CREATE OR ALTER TRIGGER dbo.trg_FactInvoices_ValidateAmounts
ON dbo.FactInvoices
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- 1) no negatives
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE (i.TotalAmount < 0)
           OR (i.PaidAmount < 0)
           OR (i.DebtAmount < 0)
    )
    BEGIN
        RAISERROR ('Amounts cannot be negative (TotalAmount/PaidAmount/DebtAmount).', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- 2) Paid + Debt must equal Total (allow tiny rounding diff)
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.TotalAmount IS NOT NULL
          AND i.PaidAmount IS NOT NULL
          AND i.DebtAmount IS NOT NULL
          AND ABS((i.PaidAmount + i.DebtAmount) - i.TotalAmount) > 0.01
    )
    BEGIN
        RAISERROR ('PaidAmount + DebtAmount must equal TotalAmount.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO
