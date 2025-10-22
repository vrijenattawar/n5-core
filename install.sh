#!/bin/bash
# n5-core install script
# Usage: curl -sSL https://raw.githubusercontent.com/yourname/n5-core/main/install.sh | bash

set -e

echo "🚀 N5 Hiring ATS - Installation"
echo "================================"
echo ""

N5_DIR="/home/workspace/N5"
N5_CORE_REPO="https://github.com/yourname/n5-core.git"

# Step 0: Compatibility scan
echo "📋 Running compatibility scan..."
if curl -fsSL https://raw.githubusercontent.com/yourname/n5-core/main/scripts/01_infrastructure/n5_compat_scan.py | python3 - --json /tmp/n5_compat_report.json; then
    echo "✓ Compatibility check passed"
elif [ $? -eq 2 ]; then
    echo "⚠️  Compatibility check passed with warnings"
    cat /tmp/n5_compat_report.json 2>/dev/null || true
    read -p "Continue installation? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled"
        exit 0
    fi
else
    echo "❌ Compatibility check failed"
    cat /tmp/n5_compat_report.json 2>/dev/null || true
    echo ""
    echo "Please address the issues above before installing N5"
    exit 1
fi

echo ""
echo "📁 Creating N5 directory structure..."
mkdir -p "$N5_DIR"
cd "$N5_DIR"

# Initialize Git (for user's private configs)
if [ ! -d .git ]; then
    echo "🔧 Initializing Git repository..."
    git init
    git branch -M main
fi

# Add n5-core as submodule
echo "📦 Installing n5-core..."
if [ ! -d n5_core ]; then
    git submodule add "$N5_CORE_REPO" n5_core
    git submodule update --init --recursive
else
    echo "✓ n5_core already exists"
fi

# Create user directories
echo "📂 Creating user directories..."
mkdir -p config logs prefs

# Create .gitignore
echo "🔒 Setting up privacy fence..."
cat > .gitignore << 'GITIGNORE_EOF'
# User private data
logs/
*.log
.env
api_keys.json

# Optional: Uncomment if you DON'T want to version your configs
# config/
# prefs/

# Temporary files
*.tmp
*.cache
GITIGNORE_EOF

# Create default prefs
echo "⚙️  Creating default configurations..."
cat > prefs/prefs.md << 'PREFS_EOF'
# N5 Preferences

## System Settings
- Timezone: America/New_York
- Log level: INFO

## Hiring Pipeline Defaults
- Default stages: Sourcing, Screening, Interview, Offer, Hired, Rejected
- Auto-create follow-ups: true
- Follow-up default days: 3

## Notifications
- Daily digest: enabled
- Slack/email integration: TBD
PREFS_EOF

# Create version manager script
cat > n5-version-manager.sh << 'VERSIONMGR_EOF'
#!/bin/bash
# N5 Version Manager

set -e

case "${1:-help}" in
    update)
        echo "🔄 Updating n5-core..."
        cd /home/workspace/N5/n5_core
        git fetch origin
        git pull --ff-only
        echo "✅ Updated to: $(git log -1 --oneline)"
        ;;
    status)
        cd /home/workspace/N5/n5_core
        echo "Current version: $(git log -1 --oneline)"
        echo "Branch: $(git branch --show-current)"
        ;;
    rollback)
        cd /home/workspace/N5/n5_core
        git log --oneline -10
        read -p "Enter commit hash to roll back to: " commit
        git checkout "$commit"
        echo "✅ Rolled back to: $(git log -1 --oneline)"
        ;;
    *)
        echo "Usage: ./n5-version-manager.sh {update|status|rollback}"
        ;;
esac
VERSIONMGR_EOF

chmod +x n5-version-manager.sh

# Create README
cat > README.md << 'README_EOF'
# N5 System

Personal Hiring ATS powered by n5-core.

## Structure
- `n5_core/` - Core functionality (updated from upstream)
- `config/` - Your private configurations
- `prefs/` - Your preferences
- `logs/` - Runtime logs

## Quick Commands

Create pipeline:
```bash
python3 n5_core/scripts/02_lists/n5_lists_create.py --name "Hiring Pipeline" --stages "Sourcing,Screening,Interview,Offer,Hired,Rejected"
```

Add candidate:
```bash
python3 n5_core/scripts/02_lists/n5_lists_add.py --list "Hiring Pipeline" --stage "Sourcing" --item "Name - Role"
```

## Update
```bash
./n5-version-manager.sh update
```

## Documentation
See `n5_core/README.md` and `n5_core/docs/`
README_EOF

# Initial commit
echo "💾 Creating initial commit..."
git add .
git commit -m "Initial N5 setup with n5-core submodule" || true

echo ""
echo "✨ N5 installation complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Create your hiring pipeline (see README.md)"
echo "   2. Customize prefs/prefs.md"
echo "   3. Start adding candidates!"
echo ""
echo "📚 Documentation: n5_core/README.md"
echo "🔄 To update: ./n5-version-manager.sh update"
echo ""
