CREATE INDEX IX_FactInvoices_DateKey       ON dbo.FactInvoices(DateKey);
CREATE INDEX IX_FactInvoices_SubscriberKey ON dbo.FactInvoices(SubscriberKey);

CREATE INDEX IX_FactMovieOrders_DateKey       ON dbo.FactMovieOrders(DateKey);
CREATE INDEX IX_FactMovieOrders_SubscriberKey ON dbo.FactMovieOrders(SubscriberKey);
CREATE INDEX IX_FactMovieOrders_MovieKey      ON dbo.FactMovieOrders(MovieKey);
