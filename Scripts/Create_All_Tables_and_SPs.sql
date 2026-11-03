-- ============================================================================
-- SMART SERVICE PORTAL - COMPLETE DATABASE SCHEMA & STORED PROCEDURES
-- TARGET DATABASE: smartserviceportal ON 38.247.130.125
-- ============================================================================

USE [smartserviceportal];
GO

-- ============================================================================
-- 1. LOCATION / ZONE MASTER TABLE & PROCEDURES
-- ============================================================================
IF OBJECT_ID(N'dbo.tbl_LocationMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_LocationMaster (
        LocationId      INT IDENTITY(1,1) PRIMARY KEY,
        LocationCode    VARCHAR(50) NULL,
        LocationName    NVARCHAR(200) NOT NULL,
        Region          NVARCHAR(100) NULL,
        Status          VARCHAR(20) DEFAULT 'Active',
        CreatedAt       DATETIME DEFAULT GETDATE(),
        UpdatedAt       DATETIME NULL
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetLocations
    @Search NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT LocationId, LocationCode, LocationName, Region, Status, CreatedAt
    FROM dbo.tbl_LocationMaster
    WHERE (@Search IS NULL OR LocationName LIKE '%' + @Search + '%')
    ORDER BY LocationId ASC;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertLocation
    @LocationName NVARCHAR(200),
    @Region NVARCHAR(100) = NULL,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.tbl_LocationMaster (LocationName, Region, Status, CreatedAt)
    VALUES (@LocationName, @Region, 'Active', GETDATE());
    
    SET @NewId = SCOPE_IDENTITY();
    
    UPDATE dbo.tbl_LocationMaster 
    SET LocationCode = 'LOC-' + RIGHT('00' + CAST(@NewId AS VARCHAR(10)), 3)
    WHERE LocationId = @NewId AND LocationCode IS NULL;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_UpdateLocation
    @LocationId INT,
    @LocationName NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.tbl_LocationMaster
    SET LocationName = @LocationName,
        UpdatedAt = GETDATE()
    WHERE LocationId = @LocationId;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_DeleteLocation
    @LocationId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tbl_LocationMaster WHERE LocationId = @LocationId;
END
GO


-- ============================================================================
-- 2. ISSUE MASTER TABLE & PROCEDURES
-- ============================================================================
IF OBJECT_ID(N'dbo.tbl_IssueMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_IssueMaster (
        IssueId         INT IDENTITY(1,1) PRIMARY KEY,
        IssueCode       VARCHAR(50) NULL,
        IssueName       NVARCHAR(250) NOT NULL,
        Category        NVARCHAR(100) NULL,
        Priority        VARCHAR(50) DEFAULT 'Normal',
        SlaTarget       VARCHAR(50) DEFAULT '8 Hours',
        Status          VARCHAR(20) DEFAULT 'Active',
        CreatedAt       DATETIME DEFAULT GETDATE(),
        UpdatedAt       DATETIME NULL
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetIssues
    @Search NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IssueId, IssueCode, IssueName, Category, Priority, SlaTarget, Status, CreatedAt
    FROM dbo.tbl_IssueMaster
    WHERE (@Search IS NULL OR IssueName LIKE '%' + @Search + '%')
    ORDER BY IssueId ASC;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertIssue
    @IssueName NVARCHAR(250),
    @Category NVARCHAR(100) = 'General Service',
    @Priority VARCHAR(50) = 'Normal',
    @SlaTarget VARCHAR(50) = '8 Hours',
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.tbl_IssueMaster (IssueName, Category, Priority, SlaTarget, Status, CreatedAt)
    VALUES (@IssueName, @Category, @Priority, @SlaTarget, 'Active', GETDATE());
    
    SET @NewId = SCOPE_IDENTITY();
    
    UPDATE dbo.tbl_IssueMaster 
    SET IssueCode = 'ISS-' + RIGHT('00' + CAST(@NewId AS VARCHAR(10)), 2)
    WHERE IssueId = @NewId AND IssueCode IS NULL;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_UpdateIssue
    @IssueId INT,
    @IssueName NVARCHAR(250)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.tbl_IssueMaster
    SET IssueName = @IssueName,
        UpdatedAt = GETDATE()
    WHERE IssueId = @IssueId;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_DeleteIssue
    @IssueId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tbl_IssueMaster WHERE IssueId = @IssueId;
END
GO


-- ============================================================================
-- 3. ACTION TAKEN MASTER TABLE & PROCEDURES
-- ============================================================================
IF OBJECT_ID(N'dbo.tbl_ActionTakenMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_ActionTakenMaster (
        ActionId        INT IDENTITY(1,1) PRIMARY KEY,
        ActionCode      VARCHAR(50) NULL,
        ActionName      NVARCHAR(250) NOT NULL,
        ActionType      NVARCHAR(100) NULL,
        Status          VARCHAR(20) DEFAULT 'Active',
        CreatedAt       DATETIME DEFAULT GETDATE(),
        UpdatedAt       DATETIME NULL
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetActionTakens
    @Search NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ActionId, ActionCode, ActionName, ActionType, Status, CreatedAt
    FROM dbo.tbl_ActionTakenMaster
    WHERE (@Search IS NULL OR ActionName LIKE '%' + @Search + '%')
    ORDER BY ActionId ASC;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertActionTaken
    @ActionName NVARCHAR(250),
    @ActionType NVARCHAR(100) = NULL,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.tbl_ActionTakenMaster (ActionName, ActionType, Status, CreatedAt)
    VALUES (@ActionName, @ActionType, 'Active', GETDATE());
    
    SET @NewId = SCOPE_IDENTITY();
    
    UPDATE dbo.tbl_ActionTakenMaster 
    SET ActionCode = 'ACT-' + RIGHT('00' + CAST(@NewId AS VARCHAR(10)), 2)
    WHERE ActionId = @NewId AND ActionCode IS NULL;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_UpdateActionTaken
    @ActionId INT,
    @ActionName NVARCHAR(250)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.tbl_ActionTakenMaster
    SET ActionName = @ActionName,
        UpdatedAt = GETDATE()
    WHERE ActionId = @ActionId;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_DeleteActionTaken
    @ActionId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tbl_ActionTakenMaster WHERE ActionId = @ActionId;
END
GO


-- ============================================================================
-- 4. MERCHANT MASTER TABLE & PROCEDURES
-- ============================================================================
IF OBJECT_ID(N'dbo.tbl_MerchantMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_MerchantMaster (
        SlNo            INT IDENTITY(1,1) PRIMARY KEY,
        ReceivingDate   VARCHAR(50) NULL,
        ServiceDate     VARCHAR(50) NULL,
        Sla             VARCHAR(100) NULL,
        MerchantName    NVARCHAR(300) NOT NULL,
        Mid             VARCHAR(100) NULL,
        Tid             VARCHAR(100) NULL,
        SerialNumber    VARCHAR(100) NULL,
        Type            VARCHAR(100) DEFAULT 'CALL CENTER',
        Location        NVARCHAR(200) NULL,
        Mobile          VARCHAR(50) NULL,
        Model           VARCHAR(100) DEFAULT 'SMART POS',
        Issue           NVARCHAR(300) NULL,
        ActionTaken     NVARCHAR(300) NULL,
        DoneBy          NVARCHAR(150) NULL,
        Remarks         NVARCHAR(MAX) NULL,
        Status          VARCHAR(50) DEFAULT 'Active',
        CreatedAt       DATETIME DEFAULT GETDATE(),
        UpdatedAt       DATETIME NULL
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetMerchants
    @Search NVARCHAR(100) = NULL,
    @Location NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        SlNo, ReceivingDate, ServiceDate, Sla, MerchantName, Mid, Tid,
        SerialNumber, Type, Location, Mobile, Model, Issue,
        ActionTaken, DoneBy, Remarks, Status, CreatedAt
    FROM dbo.tbl_MerchantMaster
    WHERE (@Search IS NULL OR MerchantName LIKE '%' + @Search + '%' OR Tid LIKE '%' + @Search + '%' OR Mid LIKE '%' + @Search + '%')
      AND (@Location IS NULL OR @Location = '' OR Location = @Location)
    ORDER BY SlNo DESC;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertMerchant
    @ReceivingDate VARCHAR(50) = NULL,
    @ServiceDate   VARCHAR(50) = NULL,
    @Sla           VARCHAR(100) = NULL,
    @MerchantName  NVARCHAR(300),
    @Mid           VARCHAR(100) = NULL,
    @Tid           VARCHAR(100) = NULL,
    @SerialNumber  VARCHAR(100) = NULL,
    @Type          VARCHAR(100) = 'CALL CENTER',
    @Location      NVARCHAR(200) = NULL,
    @Mobile        VARCHAR(50) = NULL,
    @Model         VARCHAR(100) = 'SMART POS',
    @Issue         NVARCHAR(300) = NULL,
    @ActionTaken   NVARCHAR(300) = NULL,
    @DoneBy        NVARCHAR(150) = NULL,
    @Remarks       NVARCHAR(MAX) = NULL,
    @NewSlNo       INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.tbl_MerchantMaster (
        ReceivingDate, ServiceDate, Sla, MerchantName, Mid, Tid,
        SerialNumber, Type, Location, Mobile, Model, Issue,
        ActionTaken, DoneBy, Remarks, Status, CreatedAt
    )
    VALUES (
        @ReceivingDate, @ServiceDate, @Sla, @MerchantName, @Mid, @Tid,
        @SerialNumber, @Type, @Location, @Mobile, @Model, @Issue,
        @ActionTaken, @DoneBy, @Remarks, 'Active', GETDATE()
    );
    
    SET @NewSlNo = SCOPE_IDENTITY();
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_UpdateMerchant
    @SlNo          INT,
    @ReceivingDate VARCHAR(50) = NULL,
    @ServiceDate   VARCHAR(50) = NULL,
    @Sla           VARCHAR(100) = NULL,
    @MerchantName  NVARCHAR(300),
    @Mid           VARCHAR(100) = NULL,
    @Tid           VARCHAR(100) = NULL,
    @SerialNumber  VARCHAR(100) = NULL,
    @Type          VARCHAR(100) = 'CALL CENTER',
    @Location      NVARCHAR(200) = NULL,
    @Mobile        VARCHAR(50) = NULL,
    @Model         VARCHAR(100) = 'SMART POS',
    @Issue         NVARCHAR(300) = NULL,
    @ActionTaken   NVARCHAR(300) = NULL,
    @DoneBy        NVARCHAR(150) = NULL,
    @Remarks       NVARCHAR(MAX) = NULL,
    @Status        VARCHAR(50) = 'Active'
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.tbl_MerchantMaster
    SET ReceivingDate = @ReceivingDate,
        ServiceDate   = @ServiceDate,
        Sla           = @Sla,
        MerchantName  = @MerchantName,
        Mid           = @Mid,
        Tid           = @Tid,
        SerialNumber  = @SerialNumber,
        Type          = @Type,
        Location      = @Location,
        Mobile        = @Mobile,
        Model         = @Model,
        Issue         = @Issue,
        ActionTaken   = @ActionTaken,
        DoneBy        = @DoneBy,
        Remarks       = @Remarks,
        Status        = @Status,
        UpdatedAt     = GETDATE()
    WHERE SlNo = @SlNo;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_DeleteMerchant
    @SlNo INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tbl_MerchantMaster WHERE SlNo = @SlNo;
END
GO


-- ============================================================================
-- 5. TERMINAL MASTER TABLE & PROCEDURES
-- ============================================================================
IF OBJECT_ID(N'dbo.tbl_TerminalMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_TerminalMaster (
        TerminalId      INT IDENTITY(1,1) PRIMARY KEY,
        Tid             VARCHAR(100) NOT NULL UNIQUE,
        Merchant        NVARCHAR(300) NULL,
        Mid             VARCHAR(100) NULL,
        Serial          VARCHAR(100) NULL,
        Model           VARCHAR(100) DEFAULT 'SMART POS',
        Location        NVARCHAR(200) NULL,
        Status          VARCHAR(50) DEFAULT 'Active',
        CreatedAt       DATETIME DEFAULT GETDATE(),
        UpdatedAt       DATETIME NULL
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetTerminals
    @Search NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TerminalId, Tid, Merchant, Mid, Serial, Model, Location, Status, CreatedAt
    FROM dbo.tbl_TerminalMaster
    WHERE (@Search IS NULL OR Tid LIKE '%' + @Search + '%' OR Merchant LIKE '%' + @Search + '%')
    ORDER BY TerminalId ASC;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertTerminal
    @Tid VARCHAR(100),
    @Merchant NVARCHAR(300) = NULL,
    @Mid VARCHAR(100) = NULL,
    @Serial VARCHAR(100) = NULL,
    @Model VARCHAR(100) = 'SMART POS',
    @Location NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM dbo.tbl_TerminalMaster WHERE Tid = @Tid)
    BEGIN
        INSERT INTO dbo.tbl_TerminalMaster (Tid, Merchant, Mid, Serial, Model, Location, Status, CreatedAt)
        VALUES (@Tid, @Merchant, @Mid, @Serial, @Model, @Location, 'Active', GETDATE());
    END
END
GO


-- ============================================================================
-- 6. USER MASTER TABLE & PROCEDURES
-- ============================================================================
IF OBJECT_ID(N'dbo.tbl_UserMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_UserMaster (
        UserId          INT IDENTITY(1,1) PRIMARY KEY,
        UserCode        VARCHAR(50) NOT NULL UNIQUE,
        Name            NVARCHAR(200) NOT NULL,
        Email           VARCHAR(200) NULL,
        Role            VARCHAR(50) DEFAULT 'Technician', -- Admin, Technician, Supervisor
        Zone            NVARCHAR(200) NULL,
        Pin             VARCHAR(50) NOT NULL,
        Status          VARCHAR(20) DEFAULT 'Active',
        CreatedAt       DATETIME DEFAULT GETDATE()
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetUsers
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserId, UserCode, Name, Email, Role, Zone, Status, CreatedAt
    FROM dbo.tbl_UserMaster
    ORDER BY UserId ASC;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ValidateUserPin
    @Pin VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserId, UserCode, Name, Email, Role, Zone, Status
    FROM dbo.tbl_UserMaster
    WHERE Pin = @Pin AND Status = 'Active';
END
GO


-- ============================================================================
-- 7. DESIGNATION MASTER TABLE & PROCEDURES
-- ============================================================================
IF OBJECT_ID(N'dbo.tbl_DesignationMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_DesignationMaster (
        DesignationId   INT IDENTITY(1,1) PRIMARY KEY,
        Code            VARCHAR(50) NULL,
        Title           NVARCHAR(200) NOT NULL,
        Department      NVARCHAR(150) NULL,
        AccessLevel     VARCHAR(50) DEFAULT 'Standard',
        Status          VARCHAR(20) DEFAULT 'Active',
        CreatedAt       DATETIME DEFAULT GETDATE()
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetDesignations
AS
BEGIN
    SET NOCOUNT ON;
    SELECT DesignationId, Code, Title, Department, AccessLevel, Status
    FROM dbo.tbl_DesignationMaster
    ORDER BY DesignationId ASC;
END
GO


-- ============================================================================
-- 8. COMPLAINTS / SERVICE TICKETS TABLE & PROCEDURES
-- ============================================================================
IF OBJECT_ID(N'dbo.tbl_Complaints', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_Complaints (
        ComplaintId     INT IDENTITY(1,1) PRIMARY KEY,
        TicketNo        VARCHAR(50) NOT NULL UNIQUE,
        Date            VARCHAR(50) NULL,
        Merchant        NVARCHAR(300) NOT NULL,
        Mid             VARCHAR(100) NULL,
        Tid             VARCHAR(100) NULL,
        Serial          VARCHAR(100) NULL,
        Location        NVARCHAR(200) NULL,
        Mobile          VARCHAR(50) NULL,
        Model           VARCHAR(100) NULL,
        Issue           NVARCHAR(300) NULL,
        Action          NVARCHAR(300) NULL,
        Technician      NVARCHAR(150) NULL,
        Status          VARCHAR(50) DEFAULT 'pending', -- solved, pending, progress
        CreatedAt       DATETIME DEFAULT GETDATE()
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetComplaints
    @Status VARCHAR(50) = NULL,
    @Search NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        ComplaintId, TicketNo, Date, Merchant, Mid, Tid, Serial,
        Location, Mobile, Model, Issue, Action, Technician, Status, CreatedAt
    FROM dbo.tbl_Complaints
    WHERE (@Status IS NULL OR @Status = 'all' OR Status = @Status)
      AND (@Search IS NULL OR Merchant LIKE '%' + @Search + '%' OR Tid LIKE '%' + @Search + '%' OR Issue LIKE '%' + @Search + '%')
    ORDER BY ComplaintId DESC;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetDashboardStats
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Total INT, @Solved INT, @Pending INT;
    
    SELECT 
        @Total = COUNT(*),
        @Solved = SUM(CASE WHEN Status = 'solved' THEN 1 ELSE 0 END),
        @Pending = SUM(CASE WHEN Status <> 'solved' THEN 1 ELSE 0 END)
    FROM dbo.tbl_Complaints;
    
    SELECT 
        ISNULL(@Total, 0) AS Total,
        ISNULL(@Solved, 0) AS Solved,
        ISNULL(@Pending, 0) AS Pending,
        CASE WHEN ISNULL(@Total, 0) > 0 
             THEN ROUND((CAST(ISNULL(@Solved,0) AS FLOAT) / CAST(@Total AS FLOAT)) * 100, 1) 
             ELSE 0 END AS SolvedPercent;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_MarkComplaintSolved
    @TicketNo VARCHAR(50),
    @Action NVARCHAR(300) = 'COMPLETED & RESOLVED'
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.tbl_Complaints
    SET Status = 'solved',
        Action = @Action
    WHERE TicketNo = @TicketNo;
END
GO


-- ============================================================================
-- 9. DEFAULT SEED DATA
-- ============================================================================

-- Seed Locations
IF NOT EXISTS (SELECT 1 FROM dbo.tbl_LocationMaster)
BEGIN
    INSERT INTO dbo.tbl_LocationMaster (LocationCode, LocationName, Status) VALUES
    ('LOC-001', 'SALALAH', 'Active'),
    ('LOC-002', 'SAADA', 'Active'),
    ('LOC-003', 'TAQA', 'Active'),
    ('LOC-004', 'AWQATH', 'Active'),
    ('LOC-005', 'MIRSAT', 'Active'),
    ('LOC-006', 'DHAHARIZ', 'Active'),
    ('LOC-007', 'AL HAFFA', 'Active'),
    ('LOC-008', 'RAYSUT', 'Active'),
    ('LOC-009', 'NEW SALALAH', 'Active'),
    ('LOC-010', 'AL WADI', 'Active'),
    ('LOC-011', 'THUMRAIT', 'Active'),
    ('LOC-012', 'MUGHSAIL', 'Active'),
    ('LOC-013', 'SADAH', 'Active');
END
GO

-- Seed Issues
IF NOT EXISTS (SELECT 1 FROM dbo.tbl_IssueMaster)
BEGIN
    INSERT INTO dbo.tbl_IssueMaster (IssueCode, IssueName, Status) VALUES
    ('ISS-01', 'STATIONARY DELIVERY', 'Active'),
    ('ISS-02', 'HARD WARE ISSUE', 'Active'),
    ('ISS-03', 'NEW INSTALLATION', 'Active'),
    ('ISS-04', 'PICK TERMINAL FOR REPLACEMENT', 'Active'),
    ('ISS-05', 'REPLACEMENT', 'Active'),
    ('ISS-06', 'CONNECTION ISSUE', 'Active'),
    ('ISS-07', 'ZERO SALES PICK TERMINAL', 'Active'),
    ('ISS-08', 'SOFTWARE / CONFIGURATION ISSUE', 'Active'),
    ('ISS-09', 'POWER / CHARGER ISSUE', 'Active'),
    ('ISS-10', 'PRINTER JAM / ROLLER ISSUE', 'Active');
END
GO

-- Seed Actions Taken
IF NOT EXISTS (SELECT 1 FROM dbo.tbl_ActionTakenMaster)
BEGIN
    INSERT INTO dbo.tbl_ActionTakenMaster (ActionCode, ActionName, Status) VALUES
    ('ACT-01', 'DELIVERED PAPER ROLLS', 'Active'),
    ('ACT-02', 'TERMINAL REPLACED WITH NEW', 'Active'),
    ('ACT-03', 'NEW POS INSTALLED & TESTED', 'Active'),
    ('ACT-04', 'FAULTY TERMINAL COLLECTED', 'Active'),
    ('ACT-05', 'REPLACEMENT COMPLETED', 'Active'),
    ('ACT-06', 'SIM REPLACED / NETWORK RESET', 'Active'),
    ('ACT-07', 'ZERO SALES POS RETRIEVED', 'Active'),
    ('ACT-08', 'SOFTWARE UPDATED & REBOOTED', 'Active'),
    ('ACT-09', 'POWER ADAPTER REPLACED', 'Active'),
    ('ACT-10', 'PRINTER MECHANISM CLEANED', 'Active'),
    ('ACT-11', 'MERCHANT TRAINING PROVIDED', 'Active'),
    ('ACT-12', 'CONFIGURATION PARAMETERS RELOADED', 'Active'),
    ('ACT-13', 'PENDING PARTS / ESCALATED', 'Active');
END
GO

-- Seed Admin User
IF NOT EXISTS (SELECT 1 FROM dbo.tbl_UserMaster)
BEGIN
    INSERT INTO dbo.tbl_UserMaster (UserCode, Name, Email, Role, Zone, Pin, Status) VALUES
    ('USR-001', 'Admin', 'admin@smartservice.com', 'Admin', 'ALL ZONES', '123456', 'Active'),
    ('USR-002', 'ANZAR', 'anzar@smartservice.com', 'Technician', 'SALALAH', '112233', 'Active');
END
GO

-- Seed Designations
IF NOT EXISTS (SELECT 1 FROM dbo.tbl_DesignationMaster)
BEGIN
    INSERT INTO dbo.tbl_DesignationMaster (Code, Title, Department, AccessLevel, Status) VALUES
    ('DES-01', 'System Administrator', 'IT & Operations', 'Full Access', 'Active'),
    ('DES-02', 'Field Service Engineer', 'Field Support', 'Standard Access', 'Active'),
    ('DES-03', 'Service Coordinator', 'Operations', 'Supervisor Access', 'Active');
END
GO
