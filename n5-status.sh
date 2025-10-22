#!/bin/bash
# n5-status.sh - Check N5 Core installation status
# Usage: ./n5-status.sh

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

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 N5 Core Status"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if installed
if [ ! -d "$N5_DIR" ]; then
    log_error "N5 Core is not installed"
    echo ""
    echo "Install with:"
    echo "  curl -sSL https://raw.githubusercontent.com/vrijenattawar/n5-core/main/install.sh | bash"
    exit 1
fi

cd "$N5_DIR"

# Version info
log_info "Version Information"
CURRENT_COMMIT=$(git rev-parse --short HEAD)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRENT_MESSAGE=$(git log -1 --format=%s)
CURRENT_DATE=$(git log -1 --format=%cd --date=short)

echo "  Commit:  $CURRENT_COMMIT"
echo "  Branch:  $CURRENT_BRANCH"
echo "  Date:    $CURRENT_DATE"
echo "  Message: $CURRENT_MESSAGE"
echo ""

# Check for updates
log_info "Checking for updates..."
git fetch origin --quiet 2>/dev/null
REMOTE_COMMIT=$(git rev-parse --short origin/main 2>/dev/null)

if [ "$CURRENT_COMMIT" = "$REMOTE_COMMIT" ]; then
    log_success "Up to date with origin/main"
else
    log_warning "Updates available!"
    echo ""
    echo "  Available updates:"
    git log --oneline --decorate HEAD..origin/main 2>/dev/null | head -5 | sed 's/^/    /'
    echo ""
    echo "  Run './n5-update.sh' to upgrade"
fi
echo ""

# Installation health
log_info "Installation Health"

# Check scripts
SCRIPT_COUNT=$(find scripts/ -name "*.py" -type f 2>/dev/null | wc -l)
if [ $SCRIPT_COUNT -gt 0 ]; then
    log_success "$SCRIPT_COUNT scripts installed"
else
    log_error "No scripts found"
fi

# Check schemas
SCHEMA_COUNT=$(find schemas/ -name "*.json" -type f 2>/dev/null | wc -l)
if [ $SCHEMA_COUNT -gt 0 ]; then
    log_success "$SCHEMA_COUNT schemas installed"
else
    log_error "No schemas found"
fi

# Check commands
if [ -f "config/commands.jsonl" ]; then
    CMD_COUNT=$(wc -l < config/commands.jsonl)
    log_success "$CMD_COUNT commands registered"
else
    log_warning "No command registry found"
fi

# Check config
if [ -f "config/settings.json" ]; then
    log_success "Configuration file exists"
else
    log_warning "No configuration file (using defaults)"
fi

echo ""

# Python version
log_info "Dependencies"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | awk '{print $2}')
    log_success "Python $PYTHON_VERSION"
else
    log_error "Python 3 not found"
fi

echo ""

# Directory structure
log_info "Directory Structure"
echo "  $N5_DIR/"
for dir in scripts commands schemas config data logs; do
    if [ -d "$dir" ]; then
        item_count=$(find "$dir" -type f 2>/dev/null | wc -l)
        echo "  ├── $dir/ ($item_count files)"
    else
        echo "  ├── $dir/ (missing)"
    fi
done

echo ""
log_success "Status check complete"
