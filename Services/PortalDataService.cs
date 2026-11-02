using System.Text.Json;
using SmartServicePortal.Models;

namespace SmartServicePortal.Services;

public class PortalDataService
{
    private readonly List<Complaint> _complaints = new();
    private readonly List<Merchant> _merchants = new();
    private readonly List<Terminal> _terminals = new();
    private readonly List<PortalUser> _users = new();
    private readonly List<LocationItem> _locations = new();
    private readonly object _lock = new();

    public PortalDataService()
    {
        InitializeSeedData();
    }

    private void InitializeSeedData()
    {
        // Started with empty initial data
    }

    public IEnumerable<Complaint> GetComplaints(string? filter = null, string? search = null)
    {
        lock (_lock)
        {
            IEnumerable<Complaint> query = _complaints;
            if (!string.IsNullOrEmpty(filter) && !filter.Equals("all", StringComparison.OrdinalIgnoreCase))
            {
                query = query.Where(c => c.Status.Equals(filter, StringComparison.OrdinalIgnoreCase));
            }
            if (!string.IsNullOrEmpty(search))
            {
                var q = search.ToLowerInvariant();
                query = query.Where(c => c.Merchant.ToLowerInvariant().Contains(q) ||
                                         c.Tid.ToLowerInvariant().Contains(q) ||
                                         c.Issue.ToLowerInvariant().Contains(q) ||
                                         c.Location.ToLowerInvariant().Contains(q));
            }
            return query.ToList();
        }
    }

    public StatsResponse GetStats()
    {
        lock (_lock)
        {
            var total = _complaints.Count;
            var solved = _complaints.Count(c => c.Status.Equals("solved", StringComparison.OrdinalIgnoreCase));
            var pending = _complaints.Count(c => !c.Status.Equals("solved", StringComparison.OrdinalIgnoreCase));
            var pct = total > 0 ? Math.Round((double)solved / total * 100, 1) : 0;

            return new StatsResponse
            {
                Total = total,
                Solved = solved,
                Pending = pending,
                SolvedPercent = pct
            };
        }
    }

    public Complaint AddComplaint(Complaint complaint)
    {
        lock (_lock)
        {
            if (string.IsNullOrEmpty(complaint.Id))
            {
                complaint.Id = $"SRV-{(_complaints.Count + 1):D4}";
            }
            if (string.IsNullOrEmpty(complaint.Date))
            {
                complaint.Date = DateTime.UtcNow.ToString("yyyy-MM-dd");
            }
            _complaints.Insert(0, complaint);
            return complaint;
        }
    }

    public bool MarkSolved(string id)
    {
        lock (_lock)
        {
            var item = _complaints.FirstOrDefault(c => c.Id.Equals(id, StringComparison.OrdinalIgnoreCase));
            if (item != null)
            {
                item.Status = "solved";
                item.Action = "COMPLETED & RESOLVED";
                return true;
            }
            return false;
        }
    }

    public bool ValidatePin(string pin, out PortalUser? user)
    {
        lock (_lock)
        {
            user = _users.FirstOrDefault(u => u.Pin == pin && u.Status == "Active");
            // Allow default demo PINs 123456 or 4+ digits
            return user != null || (pin.Length >= 4);
        }
    }

    public int ImportCsvLines(IEnumerable<string> lines, bool replaceExisting = false)
    {
        lock (_lock)
        {
            var imported = new List<Complaint>();
            var lineList = lines.Where(l => !string.IsNullOrWhiteSpace(l)).ToList();
            if (lineList.Count < 2) return 0;

            var header = lineList[0].Split(',').Select(h => h.Trim().ToUpperInvariant()).ToList();
            var mIdx = header.FindIndex(h => h.Contains("MERCHANT") || h.Contains("CLIENT"));
            var tIdx = header.FindIndex(h => h.Contains("TID") || h.Contains("TERMINAL"));
            var iIdx = header.FindIndex(h => h.Contains("ISSUE") || h.Contains("PROBLEM"));
            var aIdx = header.FindIndex(h => h.Contains("ACTION"));
            var lIdx = header.FindIndex(h => h.Contains("LOCATION") || h.Contains("CITY"));
            var sIdx = header.FindIndex(h => h.Contains("STATUS"));

            for (int i = 1; i < lineList.Count; i++)
            {
                var cols = lineList[i].Split(',').Select(c => c.Trim()).ToList();
                if (cols.Count == 0) continue;

                var merchant = mIdx >= 0 && mIdx < cols.Count ? cols[mIdx] : $"MERCHANT-{i}";
                var tid = tIdx >= 0 && tIdx < cols.Count ? cols[tIdx] : $"POS{10000 + i}";
                var issue = iIdx >= 0 && iIdx < cols.Count ? cols[iIdx] : "SERVICE CALL";
                var action = aIdx >= 0 && aIdx < cols.Count ? cols[aIdx] : "INSPECTED";
                var loc = lIdx >= 0 && lIdx < cols.Count ? cols[lIdx] : "SALALAH";
                var st = sIdx >= 0 && sIdx < cols.Count ? cols[sIdx].ToLowerInvariant() : "solved";

                imported.Add(new Complaint
                {
                    Id = $"SRV-{(_complaints.Count + imported.Count + 1):D4}",
                    Date = DateTime.UtcNow.ToString("yyyy-MM-dd"),
                    Merchant = merchant,
                    Tid = tid,
                    Issue = issue,
                    Action = action,
                    Location = loc,
                    Status = (st.Contains("solve") || st.Contains("close") || st.Contains("done") || st.Contains("complete")) ? "solved" : "pending"
                });
            }

            if (replaceExisting)
            {
                _complaints.Clear();
            }
            _complaints.AddRange(imported);
            return imported.Count;
        }
    }

    public void ClearAllData()
    {
        lock (_lock)
        {
            _complaints.Clear();
            _merchants.Clear();
            _terminals.Clear();
            _locations.Clear();
            _users.Clear();
        }
    }
}
