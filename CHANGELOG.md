# Changelog

All notable changes to N5 Core will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2025-10-22

### Added
- Helper scripts for version and release management:
  - `n5-release.sh` - Create new releases with automated GitHub integration
  - `n5-update.sh` - Update N5 Core to latest version with backup
  - `n5-status.sh` - Check installation health and version status
- All management scripts include color-coded output and comprehensive error handling

### Changed
- Updated VERSION to 0.2.0

## [0.1.0] - 2025-10-22

### Added
- Initial release of N5 Core for Zo Computer
- Core scripts:
  - `session_state_manager.py` - Session state tracking and management
  - `n5_safety.py` - Safety checks and validation
  - `n5_schema_validation.py` - Schema validation system
- JSON schemas:
  - `commands.schema.json` - Command structure validation
  - `lists.item.schema.json` - List item validation
  - `lists.registry.schema.json` - List registry validation
  - `index.schema.json` - Index structure validation
- Configuration system:
  - `commands.jsonl` - Command registry (124 commands)
  - `settings.example.json` - Configuration template
- Documentation:
  - Installation guide
  - Architecture overview
  - User guide (coming soon)
  - Command reference (coming soon)
  - Schema documentation (coming soon)
- Installation script with backup support
- GitHub Actions workflow for testing
- Issue templates for bug reports and feature requests
- MIT License

### Philosophy
- Human-readable first (P1)
- Single source of truth (P2)
- Safety by default (P5, P7)
- Modular design (P20)

## [Unreleased]

### Planned
- User guide with examples
- Command reference documentation
- Schema documentation with examples
- Additional core scripts for hiring workflows
- Example configurations for common use cases
- Integration tests
- Performance benchmarks

---

[0.1.0]: https://github.com/vrijenattawar/n5-core/releases/tag/v0.1.0
