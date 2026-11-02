using SmartServicePortal.Models;
using SmartServicePortal.Services;

var builder = WebApplication.CreateBuilder(args);

// Register Portal Data Service as Singleton in .NET 10
builder.Services.AddSingleton<PortalDataService>();

var app = builder.Build();

// Enable serving wwwroot/index.html as default landing page
app.UseDefaultFiles();
app.UseStaticFiles();

// 1. PIN Login API
app.MapPost("/api/auth/login", (PinLoginRequest req, PortalDataService service) =>
{
    if (string.IsNullOrWhiteSpace(req.Pin))
    {
        return Results.BadRequest(new { success = false, message = "PIN code is required" });
    }

    if (service.ValidatePin(req.Pin, out var user))
    {
        return Results.Ok(new
        {
            success = true,
            message = "Authentication successful",
            user = user?.Name ?? "Admin",
            role = user?.Role ?? "Administrator",
            redirectUrl = "/dashboard.html"
        });
    }

    return Results.Unauthorized();
});

// 2. Metrics & Dashboard Stats API
app.MapGet("/api/stats", (PortalDataService service) =>
{
    return Results.Ok(service.GetStats());
});

// 3. Complaints List API
app.MapGet("/api/complaints", (string? filter, string? search, PortalDataService service) =>
{
    var list = service.GetComplaints(filter, search);
    return Results.Ok(list);
});

// 4. Create New Service Call API
app.MapPost("/api/complaints", (Complaint complaint, PortalDataService service) =>
{
    var created = service.AddComplaint(complaint);
    return Results.Created($"/api/complaints/{created.Id}", created);
});

// 5. Mark Complaint as Solved API
app.MapPut("/api/complaints/{id}/solve", (string id, PortalDataService service) =>
{
    var success = service.MarkSolved(id);
    return success ? Results.Ok(new { success = true, id }) : Results.NotFound();
});

// 6. CSV File Import API
app.MapPost("/api/import/csv", async (IFormFile file, bool? replace, PortalDataService service) =>
{
    if (file == null || file.Length == 0)
    {
        return Results.BadRequest(new { success = false, message = "No file uploaded" });
    }

    using var stream = new StreamReader(file.OpenReadStream());
    var lines = new List<string>();
    string? line;
    while ((line = await stream.ReadLineAsync()) != null)
    {
        if (!string.IsNullOrWhiteSpace(line))
        {
            lines.Add(line);
        }
    }

    var count = service.ImportCsvLines(lines, replace ?? false);
    return Results.Ok(new
    {
        success = true,
        importedCount = count,
        message = $"Successfully imported {count} records into .NET 10 Portal backend!"
    });
});

// 7. Clear All Portal Data API
app.MapPost("/api/data/clear", (PortalDataService service) =>
{
    service.ClearAllData();
    return Results.Ok(new { success = true, message = "All portal data cleared successfully." });
});

app.Run();
