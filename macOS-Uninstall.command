#!/bin/bash
clear
echo ""
echo -e "\033[1;31mUninstalling github-sync...\033[0m"
echo ""

# Remove symlink
if [ -L "$HOME/.local/bin/github-sync" ]; then
    rm -f "$HOME/.local/bin/github-sync"
    echo "* Removed CLI 'github-sync' from ~/.local/bin"
fi

# Remove Linux desktop entry
if [ -f "$HOME/.local/share/applications/github-sync.desktop" ]; then
    rm -f "$HOME/.local/share/applications/github-sync.desktop"
    echo "* Removed Linux .desktop application entry"
fi

# Remove Mac App if exists in repo dir
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -d "$DIR/GitHub Sync.app" ]; then
    rm -rf "$DIR/GitHub Sync.app"
    echo "* Removed macOS 'GitHub Sync.app' from repository directory"
fi

# Remove Mac App if user dragged it to system /Applications
if [ -d "/Applications/GitHub Sync.app" ]; then
    rm -rf "/Applications/GitHub Sync.app"
    echo "* Removed macOS 'GitHub Sync.app' from /Applications"
fi

# Remove Mac App if user dragged it to user ~/Applications
if [ -d "$HOME/Applications/GitHub Sync.app" ]; then
    rm -rf "$HOME/Applications/GitHub Sync.app"
    echo "* Removed macOS 'GitHub Sync.app' from ~/Applications"
fi

echo ""
echo -e "\033[1;32m✅ Uninstallation Complete.\033[0m"
echo ""
