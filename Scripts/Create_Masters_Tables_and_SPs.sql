-- ============================================================================
-- SMART SERVICE PORTAL - DATABASE TABLES & STORED PROCEDURES (SQL SERVER)
-- ============================================================================

USE [master];
GO

-- Create database if not exists (Optional)
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = N'SmartServicePortalDB')
BEGIN
    CREATE DATABASE [SmartServicePortalDB];
END
GO

USE [SmartServicePortalDB];
GO

-- ============================================================================
-- 1. LOCATION MASTER TABLE & STORED PROCEDURES
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

-- SP: Get Locations
CREATE OR ALTER PROCEDURE dbo.sp_GetLocations
    @Search NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        LocationId,
        LocationCode,
        LocationName,
        Region,
        Status,
        CreatedAt
    FROM dbo.tbl_LocationMaster
    WHERE (@Search IS NULL OR LocationName LIKE '%' + @Search + '%')
    ORDER BY LocationId ASC;
END
GO

-- SP: Insert Location
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
    
    -- Auto-generate code if needed
    UPDATE dbo.tbl_LocationMaster 
    SET LocationCode = 'LOC-' + RIGHT('00' + CAST(@NewId AS VARCHAR(10)), 3)
    WHERE LocationId = @NewId AND LocationCode IS NULL;
END
GO

-- SP: Update Location
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

-- SP: Delete Location
CREATE OR ALTER PROCEDURE dbo.sp_DeleteLocation
    @LocationId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tbl_LocationMaster WHERE LocationId = @LocationId;
END
GO


-- ============================================================================
-- 2. ISSUE MASTER TABLE & STORED PROCEDURES
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

-- SP: Get Issues
CREATE OR ALTER PROCEDURE dbo.sp_GetIssues
    @Search NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        IssueId,
        IssueCode,
        IssueName,
        Category,
        Priority,
        SlaTarget,
        Status,
        CreatedAt
    FROM dbo.tbl_IssueMaster
    WHERE (@Search IS NULL OR IssueName LIKE '%' + @Search + '%')
    ORDER BY IssueId ASC;
END
GO

-- SP: Insert Issue
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

-- SP: Update Issue
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

-- SP: Delete Issue
CREATE OR ALTER PROCEDURE dbo.sp_DeleteIssue
    @IssueId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tbl_IssueMaster WHERE IssueId = @IssueId;
END
GO


-- ============================================================================
-- 3. ACTION TAKEN MASTER TABLE & STORED PROCEDURES
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

-- SP: Get Actions Taken
CREATE OR ALTER PROCEDURE dbo.sp_GetActionTakens
    @Search NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        ActionId,
        ActionCode,
        ActionName,
        ActionType,
        Status,
        CreatedAt
    FROM dbo.tbl_ActionTakenMaster
    WHERE (@Search IS NULL OR ActionName LIKE '%' + @Search + '%')
    ORDER BY ActionId ASC;
END
GO

-- SP: Insert Action Taken
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

-- SP: Update Action Taken
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

-- SP: Delete Action Taken
CREATE OR ALTER PROCEDURE dbo.sp_DeleteActionTaken
    @ActionId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tbl_ActionTakenMaster WHERE ActionId = @ActionId;
END
GO


-- ============================================================================
-- 4. MERCHANT MASTER TABLE & STORED PROCEDURES
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

-- SP: Get Merchants (with pagination / filtering)
CREATE OR ALTER PROCEDURE dbo.sp_GetMerchants
    @Search NVARCHAR(100) = NULL,
    @Location NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        SlNo,
        ReceivingDate,
        ServiceDate,
        Sla,
        MerchantName,
        Mid,
        Tid,
        SerialNumber,
        Type,
        Location,
        Mobile,
        Model,
        Issue,
        ActionTaken,
        DoneBy,
        Remarks,
        Status,
        CreatedAt
    FROM dbo.tbl_MerchantMaster
    WHERE (@Search IS NULL OR MerchantName LIKE '%' + @Search + '%' OR Tid LIKE '%' + @Search + '%' OR Mid LIKE '%' + @Search + '%')
      AND (@Location IS NULL OR @Location = '' OR Location = @Location)
    ORDER BY SlNo DESC;
END
GO

-- SP: Insert Merchant
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

-- SP: Update Merchant
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

-- SP: Delete Merchant
CREATE OR ALTER PROCEDURE dbo.sp_DeleteMerchant
    @SlNo INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tbl_MerchantMaster WHERE SlNo = @SlNo;
END
GO


-- ============================================================================
-- 5. INITIAL SEED DATA
-- ============================================================================

-- Locations
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

-- Issues
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

-- Actions Taken
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

PRINT '>>> Smart Service Portal Database Scripts Executed Successfully! <<<';
