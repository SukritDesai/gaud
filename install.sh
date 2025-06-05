#!/usr/bin/env bash

set -e

VERSION="0.1.0"

echo "📦 Installing gaud..."

# Set target install location
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

install_dep() {
  pkg="$1"
  if command -v brew >/dev/null 2>&1; then
    brew install "$pkg"
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y "$pkg"
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y "$pkg"
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y "$pkg"
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm "$pkg"
  elif command -v zypper >/dev/null 2>&1; then
    sudo zypper install -y "$pkg"
  else
    echo "❌ Could not find a supported package manager. Please install $pkg manually."
  fi
}

# Copy the gaud script
cp gaud "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/gaud"

# Ensure INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo "🔧 Adding $INSTALL_DIR to your PATH..."
  SHELL_CONFIG=""
  if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
  elif [ -n "$BASH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
  fi
  echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_CONFIG"
  echo "✅ Added to $SHELL_CONFIG. Restart your shell or run: source $SHELL_CONFIG"
fi

# Check dependencies
echo "🔍 Checking for dependencies..."
for cmd in ffmpeg yt-dlp; do
  if ! command -v "$cmd" &> /dev/null; then
    echo "🔧 Installing dependency: $cmd"
    install_dep "$cmd"
  fi
done

echo "✅ gaud $VERSION installed to $INSTALL_DIR/gaud"
echo "💡 Run it with: gaud --help"

