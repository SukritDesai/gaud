#!/bin/bash

set -e

echo "📦 Installing gaud..."

# Set target install location
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

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
    echo "❌ Missing dependency: $cmd"
    echo "   Please install it using your package manager (e.g., brew install $cmd)"
  fi
done

echo "✅ gaud installed to $INSTALL_DIR/gaud"
echo "💡 Run it with: gaud --help"

