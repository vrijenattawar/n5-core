# Installation Guide

## Quick Install

The fastest way to install N5 Core on your Zo Computer:

```bash
curl -sSL https://raw.githubusercontent.com/vrijenattawar/n5-core/main/install.sh | bash
```

## What Gets Installed

The installation creates the following structure in your Zo workspace:

```
/home/workspace/N5/
├── scripts/          # Core Python scripts
├── commands/         # Command definitions
├── schemas/          # JSON schemas
├── config/          # Configuration files
├── data/            # Runtime data (created on first use)
└── logs/            # Operation logs (created on first use)
```

## Prerequisites

### Required
- Active Zo Computer account
- Python 3.12+ (pre-installed on Zo)
- Git (pre-installed on Zo)

### Optional
- GitHub account (for contributing)
- Custom configuration preferences

## Manual Installation

If you prefer to install manually:

### 1. Clone the Repository

```bash
cd /home/workspace
git clone https://github.com/vrijenattawar/n5-core.git N5
cd N5
```

### 2. Set Permissions

```bash
chmod +x scripts/*.py
```

### 3. Verify Installation

```bash
python3 scripts/session_state_manager.py --help
```

### 4. Create Configuration

```bash
cp config/settings.example.json config/settings.json
```

Edit `config/settings.json` to customize your installation.

## Post-Installation Setup

### 1. Initialize Your First Session

In any Zo conversation:

```bash
python3 /home/workspace/N5/scripts/session_state_manager.py init \
  --convo-id YOUR_CONVO_ID \
  --type build \
  --load-system
```

### 2. Verify Schema Validation

```bash
python3 /home/workspace/N5/scripts/n5_schema_validation.py \
  --schema schemas/commands.schema.json \
  --data config/commands.jsonl
```

### 3. Test Safety System

```bash
python3 /home/workspace/N5/scripts/n5_safety.py --dry-run
```

## Configuration

### Basic Settings

Edit `config/settings.json`:

```json
{
  "system": {
    "workspace_root": "/home/workspace",
    "n5_root": "/home/workspace/N5",
    "default_conversation_type": "discussion"
  },
  "logging": {
    "level": "INFO",
    "format": "%(asctime)sZ %(levelname)s %(message)s"
  },
  "safety": {
    "require_dry_run": true,
    "anti_overwrite": true
  }
}
```

### Command Registry

The command registry is in `config/commands.jsonl`. Each line is a JSON object:

```json
{"id": "session-init", "trigger": "init session", "script": "session_state_manager.py", "description": "Initialize session state"}
```

Add custom commands by appending new lines to this file.

## Troubleshooting

### Import Errors

If you get Python import errors:

```bash
# Check Python version
python3 --version  # Should be 3.12+

# Verify file structure
ls -la /home/workspace/N5/scripts/
```

### Permission Issues

If scripts aren't executable:

```bash
chmod +x /home/workspace/N5/scripts/*.py
```

### Schema Validation Failures

If schema validation fails:

```bash
# Validate individual files
python3 /home/workspace/N5/scripts/n5_schema_validation.py \
  --schema schemas/lists.item.schema.json \
  --data YOUR_DATA_FILE.json
```

## Updating

### Automatic Update

```bash
./n5-update.sh
```

This will:
1. Pull latest changes from GitHub
2. Backup your current configuration
3. Apply updates
4. Verify installation

### Manual Update

```bash
cd /home/workspace/N5
git pull origin main
```

## Uninstalling

To remove N5 Core:

```bash
cd /home/workspace
rm -rf N5
```

**Note**: This removes all N5 files. Backup any custom configurations first.

## Next Steps

- Read the [User Guide](USER_GUIDE.md) to learn how to use N5 Core
- Review the [Architecture](ARCHITECTURE.md) to understand the system design
- Check out the [Command Reference](COMMANDS.md) for available commands
- Explore [Schema Documentation](SCHEMAS.md) for data structures

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/vrijenattawar/n5-core/issues)
- **Community**: [Zo Discord](https://discord.gg/zocomputer)
- **Documentation**: [Full Docs](https://github.com/vrijenattawar/n5-core/tree/main/docs)
