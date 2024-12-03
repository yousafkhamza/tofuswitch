# tofuswitch

A version manager for [OpenTofu](https://opentofu.org/), inspired by tfswitch. Easily install and switch between different versions of OpenTofu.

## Features

- 🚀 Easy installation and uninstallation
- 📦 Install multiple OpenTofu versions
- 🔄 Switch between installed versions
- 🔍 Interactive version selection
- ⌨️ Shell completion for both tofuswitch and OpenTofu
- 📋 List available and installed versions

## Installation

Install tofuswitch with a single command:

```bash
curl -sSL https://raw.githubusercontent.com/yousafkhamza/tofuswitch/main/install.sh | bash
```

This will:
- Install tofuswitch to `~/.local/bin`
- Add tofuswitch to your PATH
- Set up bash completion for tofuswitch
- Set up OpenTofu autocomplete
- Configure your shell environment automatically

## Usage

### Available Commands

```bash
tofuswitch list           # List installed versions
tofuswitch available      # List and select available versions
tofuswitch install <ver>  # Install specific version
tofuswitch latest         # Install latest stable version
tofuswitch switch <ver>   # Switch to specific version
tofuswitch remove <ver>   # Remove specific version
tofuswitch current        # Show current version
```

### Interactive Version Selection

Most commands support interactive version selection:

#### Installing a Version
```bash
$ tofuswitch available
Available OpenTofu versions:
Latest versions (select a number to install):
1. 1.8.6 (installed)
2. 1.8.5
3. 1.8.4
4. 1.8.3
5. 1.8.2
6. Show all versions
Enter number (1-6) or press Ctrl+C to cancel:
```

#### Removing a Version
```bash
$ tofuswitch remove
Installed OpenTofu versions:
1. 1.8.6 (current)
2. 1.8.5
Enter number to remove (or press Ctrl+C to cancel):
```

### Examples

```bash
# Install latest version
tofuswitch latest

# Install specific version
tofuswitch install 1.8.6

# Switch between versions
tofuswitch switch 1.8.5

# List installed versions
tofuswitch list

# Remove a version
tofuswitch remove 1.8.5
```

## Features in Detail

### Version Management
- Install multiple versions side by side
- Automatic switching to newly installed versions
- Prevent removal of currently active version
- Clear indication of installed and current versions

### Interactive Menus
- Select versions from numbered lists
- Clear marking of installed and current versions
- Easy-to-use interface for installation and removal

### Shell Integration
- Automatic PATH configuration
- Command completion for both tofuswitch and OpenTofu
- No manual shell configuration needed
- Automatic sourcing of shell configurations

## Uninstallation

To uninstall tofuswitch:

```bash
curl -sSL https://raw.githubusercontent.com/yousafkhamza/tofuswitch/main/uninstall.sh | bash
```

This will:
- Remove the tofuswitch executable
- Clean up shell configurations
- Remove installed OpenTofu versions
- Update your shell environment automatically

## Requirements

- Linux-based operating system
- Bash or Zsh shell
- curl
- Internet connection (for downloading versions)

## Directory Structure

```
~/.local/bin/tofuswitch      # Main executable
~/.tofu/                     # OpenTofu versions directory
└── versions/                # Installed versions
    ├── tofu_1.8.6/         # Version-specific directories
    └── tofu_1.8.5/
```

## Contributing

Contributions are welcome! Feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

![tofuswitch](https://github.com/user-attachments/assets/b2b830a7-09ad-49e9-8c06-fdda22c98e79)

