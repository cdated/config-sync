# config-sync

Personal dotfiles.

## Overview

This repository contains my personal configuration files for various tools.
It provides a quick setup script to synchronize configurations
across different machines.

## Quick Start

Run the installation script to set up everything automatically:

```bash
./install.sh
```

**Note:** The script requires `zsh` to be installed and will set it as your
default shell.

## What's Included

### Shell Configuration

- **`.zshrc`** - Zsh configuration with custom aliases and functions
- **`.bashrc`** - Bash configuration for fallback compatibility

### Development Tools

- **`.vimrc`** - Vim configuration with custom settings and plugins
- **`.tmux.conf`** - Tmux configuration for enhanced terminal multiplexing
- **`.gitconfig`** - Git configuration with aliases and user settings
- **`.taskrc`** - Taskwarrior configuration for task management

### Specialized Configs

- **`nvim/`** - Neovim configuration directory
- **`i3/`** - i3 window manager configuration
- **`taskwarrior/`** - Additional taskwarrior configurations
- **`zsh/`** - Zsh-specific files and themes

## Tmux Configuration

My custom tmux configuration includes optimizations usability.
The rationale for all changes is detailed in this blog post:
<http://cdated.com/the-wonderful-world-of-tmux/>

Key features:

- Custom key bindings for efficient navigation
- Enhanced status bar with useful information

## Installation Details

The `install.sh` script automatically:

1. Sets zsh as the default shell (if installed)
2. Installs Oh My Zsh if not present
3. Applies custom zsh theme
4. Creates symbolic links for configuration files

## Requirements

- `zsh` - Required for shell configuration
- `git` - For cloning and managing the repository

## License

Personal configuration files - use at your own discretion.
