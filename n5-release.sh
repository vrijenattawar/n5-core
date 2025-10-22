#!/bin/bash
# n5-release.sh - Create a new release of n5-core
# Usage: ./n5-release.sh <version> <release-notes>
# Example: ./n5-release.sh 0.2.0 "Added candidate scoring system"

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

# Check arguments
if [ $# -lt 2 ]; then
    log_error "Usage: $0 <version> <release-notes>"
    echo "Example: $0 0.2.0 'Added candidate scoring system'"
    exit 1
fi

VERSION=$1
NOTES=$2

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 Creating Release v$VERSION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Verify we're in the right directory
if [ ! -f "VERSION" ]; then
    log_error "Not in n5-core root directory"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    log_error "You have uncommitted changes. Commit or stash them first."
    git status --short
    exit 1
fi

# Update VERSION file
log_info "Updating VERSION file..."
echo "$VERSION" > VERSION
git add VERSION
log_success "VERSION updated to $VERSION"

# Update CHANGELOG
log_info "Would you like to add details to CHANGELOG.md? (y/N)"
read -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ${EDITOR:-nano} CHANGELOG.md
    git add CHANGELOG.md
    log_success "CHANGELOG updated"
fi

# Commit version bump
log_info "Committing version bump..."
git commit -m "chore: Bump version to $VERSION"
log_success "Version committed"

# Create git tag
log_info "Creating git tag v$VERSION..."
git tag -a "v$VERSION" -m "$NOTES"
log_success "Tag created"

# Push to GitHub
log_info "Pushing to GitHub..."
git push origin main
git push origin "v$VERSION"
log_success "Pushed to GitHub"

# Create GitHub release
log_info "Creating GitHub release..."
gh release create "v$VERSION" \
    --title "v$VERSION" \
    --notes "$NOTES" \
    --verify-tag
log_success "GitHub release created"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Release Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🏷️  Version: $VERSION"
echo "🔗 Release: https://github.com/vrijenattawar/n5-core/releases/tag/v$VERSION"
echo ""
log_success "Users can now install: curl -sSL https://raw.githubusercontent.com/vrijenattawar/n5-core/main/install.sh | bash"
