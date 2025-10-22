#!/bin/bash
# N5 Core Installation Script
# Usage: curl -sSL https://raw.githubusercontent.com/vrijenattawar/n5-core/main/install.sh | bash

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

INSTALL_DIR="/home/workspace/N5"
REPO_URL="https://github.com/vrijenattawar/n5-core.git"
BACKUP_DIR="/home/workspace/.n5-backups"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 N5 Core Installation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if already installed
if [ -d "$INSTALL_DIR" ]; then
    log_warning "N5 Core is already installed at $INSTALL_DIR"
    read -p "Do you want to reinstall? This will backup your current installation. (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled"
        exit 0
    fi
    
    # Backup existing installation
    log_info "Backing up existing installation..."
    TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    mkdir -p "$BACKUP_DIR"
    cp -r "$INSTALL_DIR" "$BACKUP_DIR/N5-$TIMESTAMP"
    log_success "Backup created at $BACKUP_DIR/N5-$TIMESTAMP"
    
    # Remove old installation
    rm -rf "$INSTALL_DIR"
fi

# Clone repository
log_info "Cloning N5 Core repository..."
git clone "$REPO_URL" "$INSTALL_DIR"
log_success "Repository cloned"

# Set permissions
log_info "Setting permissions..."
chmod +x "$INSTALL_DIR"/scripts/*.py 2>/dev/null || true
log_success "Permissions set"

# Create runtime directories
log_info "Creating runtime directories..."
mkdir -p "$INSTALL_DIR/data"
mkdir -p "$INSTALL_DIR/logs"
log_success "Runtime directories created"

# Create config from example if not exists
if [ ! -f "$INSTALL_DIR/config/settings.json" ]; then
    log_info "Creating default configuration..."
    cp "$INSTALL_DIR/config/settings.example.json" "$INSTALL_DIR/config/settings.json"
    log_success "Configuration created"
fi

# Verify Python
log_info "Verifying Python installation..."
if ! command -v python3 &> /dev/null; then
    log_error "Python 3 is required but not found"
    exit 1
fi
PYTHON_VERSION=$(python3 --version | awk '{print $2}')
log_success "Python $PYTHON_VERSION found"

# Test installation
log_info "Testing installation..."
if python3 "$INSTALL_DIR/scripts/session_state_manager.py" --help &> /dev/null; then
    log_success "Installation test passed"
else
    log_error "Installation test failed"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Installation Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📦 Installed at: $INSTALL_DIR"
echo "📖 Documentation: https://github.com/vrijenattawar/n5-core/tree/main/docs"
echo ""
echo "Next steps:"
echo "  1. Review configuration: $INSTALL_DIR/config/settings.json"
echo "  2. Read the user guide: $INSTALL_DIR/docs/USER_GUIDE.md"
echo "  3. Initialize a session: python3 $INSTALL_DIR/scripts/session_state_manager.py init --convo-id <id> --type build --load-system"
echo ""
log_success "Ready to use N5 Core!"
