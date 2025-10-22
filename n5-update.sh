#!/bin/bash
# n5-update.sh - Update N5 Core to latest version
# Usage: ./n5-update.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ${NC} $1"; }
log_success() { echo -e "${GREEN}✓${NC} $1"; }
log_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
log_error() { echo -e "${RED}✗${NC} $1"; }

N5_DIR="/home/workspace/N5"
BACKUP_DIR="/home/workspace/.n5-backups"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⬆️  Updating N5 Core"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if N5 is installed
if [ ! -d "$N5_DIR" ]; then
    log_error "N5 Core is not installed"
    log_info "Install it with: curl -sSL https://raw.githubusercontent.com/vrijenattawar/n5-core/main/install.sh | bash"
    exit 1
fi

cd "$N5_DIR"

# Show current version
log_info "Current version:"
CURRENT_COMMIT=$(git rev-parse --short HEAD)
CURRENT_MESSAGE=$(git log -1 --format=%s)
echo "  $CURRENT_COMMIT - $CURRENT_MESSAGE"
echo ""

# Check for updates
log_info "Checking for updates..."
git fetch origin --quiet

REMOTE_COMMIT=$(git rev-parse --short origin/main)

if [ "$CURRENT_COMMIT" = "$REMOTE_COMMIT" ]; then
    log_success "Already up to date!"
    exit 0
fi

# Show available updates
log_info "Updates available:"
git log --oneline --decorate HEAD..origin/main
echo ""

# Prompt for confirmation
read -p "Do you want to update? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_info "Update cancelled"
    exit 0
fi

# Create backup
log_info "Creating backup..."
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
mkdir -p "$BACKUP_DIR"
cp -r "$N5_DIR/config" "$BACKUP_DIR/config-$TIMESTAMP" 2>/dev/null || true
log_success "Backup created at $BACKUP_DIR/config-$TIMESTAMP"

# Pull updates
log_info "Pulling updates..."
git pull origin main
log_success "Updates installed"

# Show new version
NEW_COMMIT=$(git rev-parse --short HEAD)
NEW_MESSAGE=$(git log -1 --format=%s)
echo ""
log_success "Updated to: $NEW_COMMIT - $NEW_MESSAGE"
echo ""
log_info "If you encounter any issues, you can restore from: $BACKUP_DIR/config-$TIMESTAMP"
