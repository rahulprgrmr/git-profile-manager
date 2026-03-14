#!/usr/bin/env bash

set -e

SCRIPT_NAME="git-profile-manager"
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_URL="https://raw.githubusercontent.com/rahulprgrmr/git-profile-manager/main/git-profile-manager"
TMP_SCRIPT="/tmp/$SCRIPT_NAME"

echo "Installing $SCRIPT_NAME..."

# Ensure install directory exists
mkdir -p "$INSTALL_DIR"

echo "Downloading latest version..."

curl -fsSL "$SCRIPT_URL" -o "$TMP_SCRIPT"

# Move script to install location
mv "$TMP_SCRIPT" "$INSTALL_DIR/$SCRIPT_NAME"

# Make executable
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

echo "Installed to $INSTALL_DIR/$SCRIPT_NAME"

# Ensure ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo
    echo "Adding ~/.local/bin to PATH"

    if [[ -f "$HOME/.bashrc" ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi

    if [[ -f "$HOME/.zshrc" ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    fi

    echo "Restart your terminal to update PATH."
fi

# Install dependencies (Arch Linux)
if command -v pacman >/dev/null; then
    echo
    echo "Installing dependencies..."

    sudo pacman -S --needed gum fzf wl-clipboard openssh curl
fi

# Ensure .ssh directory exists
mkdir -p "$HOME/.ssh"

echo
echo "Installation complete!"
echo
echo "Run the tool using:"
echo
echo "    git-profile-manager"
echo
