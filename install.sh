#!/bin/bash

# tofuswitch Installation Script

set -e

# Installation configuration
INSTALL_DIR="${TOFUSWITCH_INSTALL_DIR:-$HOME/.local/bin}"
SCRIPT_NAME="tofuswitch"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Ensure installation directory exists
mkdir -p "$INSTALL_DIR"

# Download tofuswitch script
echo -e "${GREEN}Downloading tofuswitch script...${NC}"
curl -L "https://raw.githubusercontent.com/yousafkhamza/tofuswitch/main/tofuswitch" -o "$INSTALL_DIR/$SCRIPT_NAME"

# Make script executable
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Update PATH for different shells
update_shell_config() {
    local shell_config="$1"
    if [ -f "$shell_config" ]; then
        # Remove any existing entries
        sed -i '/# tofuswitch Path/d' "$shell_config"
        sed -i '/export PATH=.*\.local\/bin.*:/d' "$shell_config"
        
        # Add new path entry
        echo -e "\n# tofuswitch Path\nexport PATH=\"$INSTALL_DIR:\$PATH\"" >> "$shell_config"
    fi
}

# Add to bash and zsh configs if they exist
update_shell_config "$HOME/.bashrc"
update_shell_config "$HOME/.zshrc"

# Install autocompletion for bash
if [ -f "$HOME/.bashrc" ]; then
    # Remove existing completion
    sed -i '/# tofuswitch autocompletion/,/complete -F _tofuswitch_completions tofuswitch/d' "$HOME/.bashrc"

    cat << 'EOF' >> "$HOME/.bashrc"

# tofuswitch autocompletion
_tofuswitch_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Available commands
    local commands="list available install remove switch current latest help"

    # Subcommand completion
    case "${prev}" in
        install|remove|switch)
            # List available versions for install/remove commands
            local versions=$(curl -s https://api.github.com/repos/opentofu/opentofu/releases \
                | grep '"tag_name":' \
                | sed -E 's/.*"v?([^"]+)".*/\1/' \
                | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$')
            COMPREPLY=( $(compgen -W "${versions}" -- "${cur}") )
            return 0
            ;;
    esac

    # Main command completion
    COMPREPLY=( $(compgen -W "${commands}" -- "${cur}") )
    return 0
}

complete -F _tofuswitch_completions tofuswitch
EOF
fi

# Source the shell config files
if [ -n "$BASH" ]; then
    source "$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    source "$HOME/.zshrc"
fi

# Verify installation
echo -e "${GREEN}tofuswitch has been successfully installed!${NC}"
echo -e "${GREEN}Shell configuration has been updated and sourced.${NC}"
echo -e "\nTry running: ${YELLOW}tofuswitch available${NC} to get started!"