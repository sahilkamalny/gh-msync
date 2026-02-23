#!/bin/bash
# Git Multi-Sync uninstaller — for installations done via scripts/install.sh or
# macOS-Install.command / Linux-Install.sh. If you installed via Homebrew, use:
#   brew uninstall git-msync
# and remove ~/.config/git-msync manually if desired.

printf '\033[2J\033[3J\033[H'

# Detect OS
OS="$(uname -s)"

echo -e "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;31m  ☯︎  Git Multi-Sync Uninstaller\033[0m"
echo -e "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""

if [ ! -f "$HOME/.local/bin/git-msync" ] && [ ! -d "$HOME/.config/git-msync" ]; then
    echo -e "    \033[1;33mGit Multi-Sync is not currently installed on this system.\033[0m"
    echo -e "\n\n    ©  2026 Sahil Kamal"
    echo ""
    exit 0
fi

# Define Colors
CYAN="\033[1;36m"
RESET="\033[0m"

FORCE_CLI=0
for arg in "$@"; do
    if [[ "$arg" == "--cli" || "$arg" == "--headless" ]]; then
        FORCE_CLI=1
    fi
done

HAS_GUI=0
if [ "$FORCE_CLI" -eq 0 ]; then
    if [[ "$OS" == "Darwin" ]] && [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
        HAS_GUI=1
    elif [[ "$OS" == "Linux" ]] && { [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; }; then
        HAS_GUI=1
    fi
fi

# Native Uninstallation Confirmation
if [ "$HAS_GUI" -eq 1 ]; then
    if [[ "$OS" == "Darwin" ]]; then
    echo -ne "    \033[3mPlease interact with the pop-up...\033[0m"
    response=$(osascript -e '
        try
            set theResult to display dialog "Are you sure you want to completely uninstall Git Multi-Sync?\n\nThis will remove the git msync command, configuration, and the desktop application." buttons {"Cancel", "Uninstall"} default button "Cancel" with title "Git Multi-Sync Uninstaller" with icon caution
            return button returned of theResult
        on error
            return "Cancel"
        end try
    ' 2>/dev/null)
    
    if [ "$response" != "Uninstall" ]; then
        echo -e "\r\033[K    \033[1;33mUninstallation cancelled.\033[0m"
        echo -e "\n\n    ©  2026 Sahil Kamal\n"
        exit 0
    fi
    echo -ne "\r\033[K"
elif [[ "$OS" == "Linux" ]]; then
    if command -v zenity >/dev/null; then
        echo -ne "    \033[3mPlease interact with the pop-up...\033[0m"
        zenity --question --title="Git Multi-Sync Uninstaller" --text="Are you sure you want to completely uninstall Git Multi-Sync?\n\nThis will remove the git msync command, configuration, and the desktop application." --ok-label="Uninstall" --cancel-label="Cancel" --icon-name=dialog-warning 2>/dev/null
        if [ $? -ne 0 ]; then
            echo -e "\r\033[K    \033[1;33mUninstallation cancelled.\033[0m"
            echo -e "\n\n    ©  2026 Sahil Kamal\n"
            exit 0
        fi
        echo -ne "\r\033[K"
    elif command -v kdialog >/dev/null; then
        echo -ne "    \033[3mPlease interact with the pop-up...\033[0m"
        kdialog --warningcontinuecancel "Are you sure you want to completely uninstall Git Multi-Sync?\n\nThis will remove the git msync command, configuration, and the desktop application." --title "Git Multi-Sync Uninstaller" --continue-label "Uninstall" 2>/dev/null
        if [ $? -ne 0 ]; then
            echo -e "\r\033[K    \033[1;33mUninstallation cancelled.\033[0m"
            echo -e "\n\n    ©  2026 Sahil Kamal\n"
            exit 0
        fi
        echo -ne "\r\033[K"
        else
            HAS_GUI=0
        fi
    fi
fi

if [ "$HAS_GUI" -eq 0 ]; then
    printf "    ${CYAN}Are you sure you want to uninstall Git Multi-Sync? (y/n): ${RESET}"
    read -r confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "\n    \033[1;33mUninstallation cancelled.\033[0m"
        echo ""
        exit 0
    fi
    echo ""
fi

# Remove Git subcommand
if [ -L "$HOME/.local/bin/git-msync" ] || [ -f "$HOME/.local/bin/git-msync" ]; then
    rm -f "$HOME/.local/bin/git-msync"
    echo -e "    \033[1;31m∘\033[0m Removed Git subcommand (\033[4m~/.local/bin/git-msync\033[0m)"
fi

if grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
    sed -i '' '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$HOME/.zshrc" 2>/dev/null || sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$HOME/.zshrc" 2>/dev/null
    echo -e "    \033[1;31m∘\033[0m Removed PATH injection (\033[4m~/.zshrc\033[0m)"
fi
if grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bash_profile" 2>/dev/null; then
    sed -i '' '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$HOME/.bash_profile" 2>/dev/null || sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$HOME/.bash_profile" 2>/dev/null
    echo -e "    \033[1;31m∘\033[0m Removed PATH injection (\033[4m~/.bash_profile\033[0m)"
fi
if grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    sed -i '' '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$HOME/.bashrc" 2>/dev/null || sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$HOME/.bashrc" 2>/dev/null
    echo -e "    \033[1;31m∘\033[0m Removed PATH injection (\033[4m~/.bashrc\033[0m)"
fi
if grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.profile" 2>/dev/null; then
    sed -i '' '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$HOME/.profile" 2>/dev/null || sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$HOME/.profile" 2>/dev/null
    echo -e "    \033[1;31m∘\033[0m Removed PATH injection (\033[4m~/.profile\033[0m)"
fi

# Remove Configuration
if [ -d "$HOME/.config/git-msync" ]; then
    rm -rf "$HOME/.config/git-msync"
    echo -e "    \033[1;31m∘\033[0m Removed configurations (\033[4m~/.config/git-msync\033[0m)"
fi

# Remove Linux desktop entry
if [ -f "$HOME/.local/share/applications/git-msync.desktop" ]; then
    rm -f "$HOME/.local/share/applications/git-msync.desktop"
    echo -e "    \033[1;31m∘\033[0m Removed Linux App entry (\033[4mgit-msync.desktop\033[0m)"
fi

# Remove Mac App if exists in repo dir
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -d "$DIR/Git Multi-Sync.app" ]; then
    rm -rf "$DIR/Git Multi-Sync.app"
    echo -e "    \033[1;31m∘\033[0m Removed macOS App (\033[4mGit Multi-Sync.app\033[0m)"
fi

# Remove Mac App if user dragged it to system /Applications
if [ -d "/Applications/Git Multi-Sync.app" ]; then
    rm -rf "/Applications/Git Multi-Sync.app"
    echo -e "    \033[1;31m∘\033[0m Removed macOS App from system (\033[4m/Applications\033[0m)"
fi

# Remove Mac App if user dragged it to user ~/Applications
if [ -d "$HOME/Applications/Git Multi-Sync.app" ]; then
    rm -rf "$HOME/Applications/Git Multi-Sync.app"
    echo -e "    \033[1;31m∘\033[0m Removed macOS App from user (\033[4m~/Applications\033[0m)"
fi

# Remove Mac App if user dragged it to their Desktop
if [ -d "$HOME/Desktop/Git Multi-Sync.app" ]; then
    rm -rf "$HOME/Desktop/Git Multi-Sync.app"
    echo -e "    \033[1;31m∘\033[0m Removed macOS App from (\033[4m~/Desktop\033[0m)"
fi

# Remove Linux desktop entry if user dragged it to their Desktop
if [ -f "$HOME/Desktop/git-msync.desktop" ]; then
    rm -f "$HOME/Desktop/git-msync.desktop"
    echo -e "    \033[1;31m∘\033[0m Removed Linux App entry from (\033[4m~/Desktop\033[0m)"
fi

# Remove legacy data dir if exists in repo dir
if [ -d "$DIR/Git Multi-Sync" ]; then
    rm -rf "$DIR/Git Multi-Sync"
    echo -e "    \033[1;31m∘\033[0m Removed legacy directory (\033[4mGit Multi-Sync\033[0m)"
fi

echo ""
echo -e "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;32m  ✓  Uninstallation Complete.\033[0m"
echo -e "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e "    \033[1;34mGit Multi-Sync has been successfully uninstalled.\033[0m"
echo ""

if [[ "$OS" == "Darwin" ]]; then
    osascript -e 'display notification "Uninstallation complete. All configurations and files have been removed." with title "Git Multi-Sync"'
elif [[ "$OS" == "Linux" ]]; then
    if command -v notify-send >/dev/null; then
        notify-send "Git Multi-Sync" "Uninstallation complete. All configurations and files have been removed."
    fi
fi

echo -e "\n    ©  2026 Sahil Kamal"
echo ""
