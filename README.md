# N5 Hiring ATS for Zo Computer

**Intelligent hiring and recruitment management system for Zo Computer**

## Overview

N5 Core is a productivity operating system built for Zo Computer that helps you manage hiring workflows, candidate tracking, and recruitment operations with AI assistance.

## Quick Start

```bash
curl -sSL https://raw.githubusercontent.com/vrijenattawar/n5-core/main/install.sh | bash
```

## Core Features

### 📋 **List Management**
- Track candidates, open positions, and hiring stages
- Automated action item detection and tracking
- Structured data with schema validation

### 🎯 **Command System**
- Natural language command interface
- Extensible command registry
- Context-aware execution

### 📊 **Session State Management**
- Track conversation context and objectives
- Build vs research vs planning modes
- Automatic state persistence

### 🛡️ **Safety & Validation**
- Schema validation for all data structures
- Safety checks before destructive operations
- Dry-run mode for testing

## Architecture

```
n5-core/
├── scripts/          # Core Python scripts
│   ├── session_state_manager.py
│   ├── n5_safety.py
│   └── n5_schema_validation.py
├── commands/         # Command definitions
├── schemas/          # JSON schemas for data validation
├── config/           # Configuration files
│   ├── commands.jsonl
│   └── settings.example.json
└── docs/            # Documentation
```

## Documentation

- [Installation Guide](docs/INSTALL.md)
- [User Guide](docs/USER_GUIDE.md)
- [Architecture Overview](docs/ARCHITECTURE.md)
- [Command Reference](docs/COMMANDS.md)
- [Schema Documentation](docs/SCHEMAS.md)

## Requirements

- Zo Computer account
- Python 3.12+
- Git (for development)

## Use Cases

- **Hiring Operations**: Manage candidate pipeline, interview scheduling, follow-ups
- **Recruitment Tracking**: Track open positions, candidate status, hiring metrics
- **Interview Management**: Meeting preparation, note-taking, candidate evaluation
- **Team Collaboration**: Shared hiring context, stakeholder coordination

## Version Management

N5 Core uses semantic versioning and includes helper scripts for updates:

```bash
./n5-update.sh       # Update to latest version
./n5-rollback.sh     # Rollback to previous version
./n5-status.sh       # Check current version and installation
```

## Development

For developers contributing to N5 Core:

```bash
# Clone the repository
git clone https://github.com/vrijenattawar/n5-core.git
cd n5-core

# Create a new release
./n5-release.sh 0.2.0 "Feature: Add candidate scoring system"
```

## License

MIT License - See [LICENSE](LICENSE) for details

## Support

- **Issues**: [GitHub Issues](https://github.com/vrijenattawar/n5-core/issues)
- **Discussions**: [GitHub Discussions](https://github.com/vrijenattawar/n5-core/discussions)
- **Zo Community**: [Discord](https://discord.gg/zocomputer)

---

**Built for [Zo Computer](https://zo.computer)** - Your AI Computer in the Cloud
