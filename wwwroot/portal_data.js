const PORTAL_DATA = {
  "complaints": [],
  "merchants": [
    {
      "mid": "104951720199",
      "name": "AL MAHA HYPERMARKET",
      "location": "SALALAH",
      "contact": "+968 9123 4567",
      "terminals_count": 3,
      "status": "Active"
    },
    {
      "mid": "104951720200",
      "name": "CITY FLOWER SALALAH",
      "location": "SAADA",
      "contact": "+968 9765 4321",
      "terminals_count": 2,
      "status": "Active"
    },
    {
      "mid": "104951720201",
      "name": "LULU CENTER DHOFAR",
      "location": "SALALAH",
      "contact": "+968 9888 7766",
      "terminals_count": 5,
      "status": "Active"
    },
    {
      "mid": "104951720202",
      "name": "OMAN OIL PETROL PUMP",
      "location": "TAQAH",
      "contact": "+968 9444 3322",
      "terminals_count": 1,
      "status": "Active"
    },
    {
      "mid": "104951720203",
      "name": "CARREFOUR SALALAH",
      "location": "SALALAH",
      "contact": "+968 9333 2211",
      "terminals_count": 4,
      "status": "Active"
    },
    {
      "mid": "104951720204",
      "name": "GRAND MALL MUSCAT",
      "location": "MUSCAT HQ",
      "contact": "+968 2455 1100",
      "terminals_count": 6,
      "status": "Active"
    }
  ],
  "terminals": [],
  "replacements": [],
  "issues": [
    {
      "code": "ISS-01",
      "name": "PAPER ROLL REQUEST",
      "category": "Stationery Supply",
      "priority": "Normal",
      "sla": "12 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-02",
      "name": "NETWORK TIMEOUT",
      "category": "Connectivity & SIM",
      "priority": "Urgent",
      "sla": "4 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-03",
      "name": "PRINTER JAM",
      "category": "Hardware / Printer",
      "priority": "High",
      "sla": "6 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-04",
      "name": "BATTERY NOT CHARGING",
      "category": "Power & Battery",
      "priority": "High",
      "sla": "6 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-05",
      "name": "CHARGING PORT ISSUE",
      "category": "Hardware / Port",
      "priority": "High",
      "sla": "8 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-06",
      "name": "DISPLAY FADE / SCREEN",
      "category": "Hardware / Screen",
      "priority": "High",
      "sla": "8 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-07",
      "name": "NEW INSTALLATION",
      "category": "Onboarding",
      "priority": "High",
      "sla": "24 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-08",
      "name": "SOFTWARE & DOWNLOAD UPDATE",
      "category": "Firmware & Software",
      "priority": "Medium",
      "sla": "12 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-09",
      "name": "GENERAL CHECKUP & TRAINING",
      "category": "Maintenance",
      "priority": "Normal",
      "sla": "24 Hours",
      "status": "Active"
    },
    {
      "code": "ISS-10",
      "name": "ZERO SALES PICK TERMINAL",
      "category": "Retrieval",
      "priority": "Normal",
      "sla": "48 Hours",
      "status": "Active"
    }
  ],
  "actions_taken": [
    {
      "code": "ACT-01",
      "name": "ROLLS DELIVERED",
      "type": "Stationery Delivery",
      "status": "Active"
    },
    {
      "code": "ACT-02",
      "name": "SIM CARD REPLACED",
      "type": "Hardware / Connectivity",
      "status": "Active"
    },
    {
      "code": "ACT-03",
      "name": "INSPECTION DONE",
      "type": "On-site Maintenance",
      "status": "Active"
    },
    {
      "code": "ACT-04",
      "name": "ADAPTER REPLACED",
      "type": "Power & Hardware",
      "status": "Active"
    },
    {
      "code": "ACT-05",
      "name": "TERMINAL SWAPPED",
      "type": "Asset Replacement",
      "status": "Active"
    },
    {
      "code": "ACT-06",
      "name": "SOFTWARE RELOADED / UPDATED",
      "type": "Firmware & App",
      "status": "Active"
    },
    {
      "code": "ACT-07",
      "name": "PRINTER ROLLER CLEANED",
      "type": "Hardware Repair",
      "status": "Active"
    },
    {
      "code": "ACT-08",
      "name": "BATTERY REPLACED",
      "type": "Hardware Swap",
      "status": "Active"
    },
    {
      "code": "ACT-09",
      "name": "MERCHANT TRAINED",
      "type": "Customer Support",
      "status": "Active"
    },
    {
      "code": "ACT-10",
      "name": "TERMINAL COLLECTED",
      "type": "Asset Recovery",
      "status": "Active"
    }
  ],
  "categories": [
    {
      "code": "CAT-01",
      "name": "STATIONARY DELIVERY",
      "desc": "POS Paper Rolls Supply (50 - 500 rolls)",
      "sla": "12 Hours",
      "priority": "Normal"
    },
    {
      "code": "CAT-02",
      "name": "NEW INSTALLATION",
      "desc": "New Merchant Onboarding & Machine Setup",
      "sla": "24 Hours",
      "priority": "High"
    },
    {
      "code": "CAT-03",
      "name": "HARD WARE ISSUE",
      "desc": "Charger, Battery, Cable, Power Hardware Failure",
      "sla": "4 Hours",
      "priority": "Urgent"
    },
    {
      "code": "CAT-04",
      "name": "CHARGING PORT ISSUE",
      "desc": "Damage to pin / port, cable not locking",
      "sla": "8 Hours",
      "priority": "High"
    },
    {
      "code": "CAT-05",
      "name": "DISPLAY FADE / SCREEN",
      "desc": "Screen backlight fade, broken LCD display",
      "sla": "8 Hours",
      "priority": "High"
    },
    {
      "code": "CAT-06",
      "name": "REPLACEMENT (SWAP)",
      "desc": "Full Terminal Replacement on Field",
      "sla": "6 Hours",
      "priority": "Urgent"
    },
    {
      "code": "CAT-07",
      "name": "ZERO SALES PICK TERMINAL",
      "desc": "Retrieve terminal from dormant merchant",
      "sla": "48 Hours",
      "priority": "Normal"
    },
    {
      "code": "CAT-08",
      "name": "CONNECTION & GPRS ISSUE",
      "desc": "SIM Card / Network / Dial-up connectivity",
      "sla": "4 Hours",
      "priority": "Urgent"
    },
    {
      "code": "CAT-09",
      "name": "GENERAL CHECKUP & TRAINING",
      "desc": "Merchant staff training & preventative checkup",
      "sla": "24 Hours",
      "priority": "Normal"
    },
    {
      "code": "CAT-10",
      "name": "SOFTWARE & DOWNLOAD UPDATE",
      "desc": "Firmware update, V7 / V10 batch download",
      "sla": "12 Hours",
      "priority": "Medium"
    }
  ],
  "technicians": [
    {
      "id": "TECH-01",
      "name": "ANZAR",
      "role": "Senior Field Service Engineer",
      "zone": "Salalah & Dhofar Region",
      "contact": "+968 9275 1955",
      "jobs_done": 227,
      "status": "Active"
    },
    {
      "id": "TECH-02",
      "name": "OMA TEAM",
      "role": "Terminal Delivery & Field Operations",
      "zone": "Muscat, Batinah & Sharqiyah",
      "contact": "+968 2456 7890",
      "jobs_done": 48,
      "status": "Active"
    },
    {
      "id": "TECH-03",
      "name": "POS TEAM",
      "role": "Installation & Handover Specialist",
      "zone": "Dakhiliyah, Sohar & Nizwa",
      "contact": "+968 9802 0354",
      "jobs_done": 35,
      "status": "Active"
    }
  ],
  "users": [
    {
      "id": "USR-101",
      "name": "Administrator",
      "username": "admin",
      "role": "Admin",
      "zone": "Muscat HQ",
      "mobile": "+968 9200 0001",
      "pincode": "123456",
      "email": "admin@smartpos.om",
      "status": "Active"
    },
    {
      "id": "USR-102",
      "name": "Anzar K.",
      "username": "anzar_pos",
      "role": "Field Service Engineer",
      "zone": "Salalah & Dhofar",
      "mobile": "+968 9275 1955",
      "pincode": "112233",
      "email": "anzar@smartpos.om",
      "status": "Active"
    },
    {
      "id": "USR-103",
      "name": "OMA Operations",
      "username": "oma_ops",
      "role": "Operations Manager",
      "zone": "Muscat HQ",
      "mobile": "+968 2456 7890",
      "pincode": "445566",
      "email": "ops@smartpos.om",
      "status": "Active"
    },
    {
      "id": "USR-104",
      "name": "Salim Al-Balushi",
      "username": "salim_tech",
      "role": "Field Service Engineer",
      "zone": "Al Batinah / Sohar",
      "mobile": "+968 9802 0354",
      "pincode": "778899",
      "email": "salim@smartpos.om",
      "status": "Active"
    }
  ],
  "locations": [
    {
      "code": "LOC-01",
      "name": "SALALAH",
      "region": "Dhofar Governorate",
      "merchants_count": 48,
      "status": "Active"
    },
    {
      "code": "LOC-02",
      "name": "SAADA",
      "region": "Dhofar Governorate",
      "merchants_count": 22,
      "status": "Active"
    },
    {
      "code": "LOC-03",
      "name": "TAQAH",
      "region": "Dhofar Governorate",
      "merchants_count": 9,
      "status": "Active"
    },
    {
      "code": "LOC-04",
      "name": "MIRBAT",
      "region": "Dhofar Governorate",
      "merchants_count": 6,
      "status": "Active"
    },
    {
      "code": "LOC-05",
      "name": "MUSCAT HQ",
      "region": "Muscat Capital Area",
      "merchants_count": 64,
      "status": "Active"
    },
    {
      "code": "LOC-06",
      "name": "SOHAR",
      "region": "Al Batinah North",
      "merchants_count": 31,
      "status": "Active"
    },
    {
      "code": "LOC-07",
      "name": "NIZWA",
      "region": "Al Dakhiliyah",
      "merchants_count": 18,
      "status": "Active"
    }
  ]
};
