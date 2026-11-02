namespace SmartServicePortal.Models;

public class Complaint
{
    public string Id { get; set; } = string.Empty;
    public string Date { get; set; } = string.Empty;
    public string Merchant { get; set; } = string.Empty;
    public string Mid { get; set; } = string.Empty;
    public string Tid { get; set; } = string.Empty;
    public string Serial { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public string Mobile { get; set; } = string.Empty;
    public string Model { get; set; } = string.Empty;
    public string Issue { get; set; } = string.Empty;
    public string Action { get; set; } = string.Empty;
    public string Technician { get; set; } = string.Empty;
    public string Status { get; set; } = "pending"; // solved, pending, progress
}

public class Merchant
{
    public int SlNo { get; set; }
    public string ReceivingDate { get; set; } = string.Empty;
    public string ServiceDate { get; set; } = string.Empty;
    public string Sla { get; set; } = string.Empty;
    public string MerchantName { get; set; } = string.Empty;
    public string Mid { get; set; } = string.Empty;
    public string Tid { get; set; } = string.Empty;
    public string SerialNumber { get; set; } = string.Empty;
    public string Type { get; set; } = "CALL CENTER";
    public string Location { get; set; } = string.Empty;
    public string Mobile { get; set; } = string.Empty;
    public string Model { get; set; } = "SMART POS";
    public string Issue { get; set; } = string.Empty;
    public string ActionTaken { get; set; } = string.Empty;
    public string DoneBy { get; set; } = string.Empty;
    public string Remarks { get; set; } = string.Empty;
    public string Status { get; set; } = "Active";
}

public class Terminal
{
    public string Tid { get; set; } = string.Empty;
    public string Merchant { get; set; } = string.Empty;
    public string Mid { get; set; } = string.Empty;
    public string Serial { get; set; } = string.Empty;
    public string Model { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public string Status { get; set; } = "Active";
}

public class PortalUser
{
    public string Id { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;
    public string Zone { get; set; } = string.Empty;
    public string Pin { get; set; } = string.Empty;
    public string Status { get; set; } = "Active";
}

public class LocationItem
{
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Region { get; set; } = string.Empty;
    public int MerchantsCount { get; set; } = 0;
    public string Status { get; set; } = "Active";
}

public class IssueItem
{
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string Priority { get; set; } = "Normal";
    public string Sla { get; set; } = "8 Hours";
    public string Status { get; set; } = "Active";
}

public class ActionTakenItem
{
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public string Status { get; set; } = "Active";
}

public class DesignationItem
{
    public string Code { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Department { get; set; } = string.Empty;
    public string AccessLevel { get; set; } = string.Empty;
    public string Status { get; set; } = "Active";
}

public class StatsResponse
{
    public int Total { get; set; }
    public int Solved { get; set; }
    public int Pending { get; set; }
    public double SolvedPercent { get; set; }
}

public class PinLoginRequest
{
    public string Pin { get; set; } = string.Empty;
}
