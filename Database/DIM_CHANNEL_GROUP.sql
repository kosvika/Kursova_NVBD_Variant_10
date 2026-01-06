CREATE TABLE DimChannelGroup (
    ChannelGroupKey INT IDENTITY PRIMARY KEY,
    ChannelGroupID INT,
    GroupName NVARCHAR(100),
    Description NVARCHAR(200)
);
