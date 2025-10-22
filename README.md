# N5 Core - Hiring ATS for Zo Computer

**Version:** 1.0.0  
**Distribution Pattern:** Git + Submodule Architecture

---

## What is N5?

N5 is a complete, self-setup Hiring ATS (Applicant Tracking System) for Zo Computer. It provides:

- **Pipeline Management** - Track candidates through hiring stages
- **Candidate Profiles** - CRM for applicant relationships
- **Follow-up Tracking** - Never miss a candidate touch-point
- **Search & Query** - Find candidates and context instantly
- **Background Automation** - Email scanning, enrichment, digests
- **Howie Intelligence** ⭐ - **NEW: Automatic meeting analysis and email tagging**
- **Zo Integration** - Deep integration with your Zo Computer

---

## Installation

**One-line install:**

```bash
curl -sSL https://raw.githubusercontent.com/yourname/n5-core/main/install.sh | bash
```

**What it does:**
1. Runs compatibility scan
2. Creates N5 directory structure
3. Installs n5-core as submodule
4. Sets up privacy fence (your data stays private)
5. Creates default configurations

**Time:** 2-3 minutes

---

## Quick Start

### 1. Create Your Hiring Pipeline

```bash
python3 /home/workspace/N5/n5_core/scripts/02_lists/n5_lists_create.py \
  --name "Hiring Pipeline" \
  --stages "Sourcing,Screening,Interview,Offer,Hired,Rejected"
```

### 2. Add a Candidate

```bash
python3 /home/workspace/N5/n5_core/scripts/02_lists/n5_lists_add.py \
  --list "Hiring Pipeline" \
  --stage "Sourcing" \
  --item "Jane Doe - Senior Engineer | jane@example.com"
```

### 3. Move Through Pipeline

```bash
python3 /home/workspace/N5/n5_core/scripts/02_lists/n5_lists_move.py \
  --list "Hiring Pipeline" \
  --item "Jane Doe" \
  --from "Sourcing" \
  --to "Screening"
```

---

## Features

### v1.0 (Current)
✅ Pipeline/List Management (16 scripts)  
✅ CRM/Stakeholder Tracking (7 scripts)  
✅ Follow-up Management (2 scripts)  
✅ Search & Query (1 script)  
✅ Background Processing (3 scripts)  
✅ Zo Integration (5 scripts)  
✅ Infrastructure & Safety (8 scripts)

### v1.1 (Coming Soon - HIGH PRIORITY)
🔜 Interview Processing & Intelligence  
🔜 Meeting Analysis (Howie integration)  
🔜 Email Templates & Mailing  
🔜 Document Generation

---

## Documentation

- **User Guide:** `docs/USER_GUIDE.md`
- **Troubleshooting:** `docs/TROUBLESHOOTING.md`
- **API Reference:** `docs/API.md`

---

## Updating

```bash
cd /home/workspace/N5
./n5-version-manager.sh update
```

**Rollback if needed:**
```bash
./n5-version-manager.sh rollback
```

---

## Architecture

```
/home/workspace/N5/
├── n5_core/          # Submodule (this repo) - DON'T EDIT
├── config/           # Your private configurations
├── prefs/            # Your Zo preferences
└── logs/             # Runtime logs
```

**Privacy:** Your `config/`, `prefs/`, and `logs/` stay private. Only `n5_core/` updates from upstream.

---

## Support

- **Issues:** https://github.com/yourname/n5-core/issues
- **Discussions:** https://github.com/yourname/n5-core/discussions
- **Zo Discord:** https://discord.gg/zocomputer

---

## License

MIT License - See LICENSE file

---

*Built with ❤️ for the Zo Computer community*
