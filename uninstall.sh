#!/bin/bash

# tofuswitch Uninstallation Script

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Installation directory
INSTALL_DIR="${TOFUSWITCH_INSTALL_DIR:-$HOME/.local/bin}"
SCRIPT_NAME="tofuswitch"

# Remove tofuswitch executable
if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
    echo -e "${YELLOW}Removing tofuswitch executable...${NC}"
    rm -f "$INSTALL_DIR/$SCRIPT_NAME"
else
    echo -e "${YELLOW}tofuswitch executable not found in $INSTALL_DIR${NC}"
fi

# Function to clean shell config files
clean_shell_config() {
    local shell_config="$1"
    if [ -f "$shell_config" ]; then
        echo -e "${YELLOW}Cleaning $shell_config...${NC}"
        # Remove PATH entries
        sed -i '/# tofuswitch Path/d' "$shell_config"
        sed -i '/export PATH=.*\.local\/bin.*:/d' "$shell_config"
        
        # Remove autocompletion
        sed -i '/# tofuswitch autocompletion/,/complete -F _tofuswitch_completions tofuswitch/d' "$shell_config"
    fi
}

# Clean bash and zsh configs
clean_shell_config "$HOME/.bashrc"
clean_shell_config "$HOME/.zshrc"

# Source the updated shell config files
if [ -n "$BASH" ]; then
    source "$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    source "$HOME/.zshrc"
fi

echo -e "${GREEN}tofuswitch has been successfully uninstalled!${NC}"
echo -e "To complete the uninstallation, please:"
echo -e "1. Restart your terminal, or"
echo -e "2. Run: ${YELLOW}source ~/.bashrc${NC} (for bash) or ${YELLOW}source ~/.zshrc${NC} (for zsh)"
