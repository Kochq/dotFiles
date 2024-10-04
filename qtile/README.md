# Qtile window manager configuration

This is my configuration for the Qtile window manager. A tiling window manager written and configured in Python.

## Installation

To install Qtile, you can follow the instructions on the [official website](https://docs.qtile.org/en/stable/manual/install/index.html).

## Configuration

The configuration file is located at `~/.config/qtile/config.py`. You can clone this repository and replace the configuration file with the one provided here.

## Keybindings

The keybindings are configured in the `settings/keyMaps.py` file.
Some are in `config.py`.

### General

- <kbd>Mod</kbd>: Alt

### Opening things

- <kbd>Mod</kbd> + <kbd>Enter</kbd>: Launch terminal
- <kbd>Mod</kbd> + <kbd>b</kbd>: Launch browser
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>l</kbd>: Rofi launcher

### Moving to workspaces

- <kbd>Mod</kbd> + <kbd>q</kbd>: Switch to workspace 1
- <kbd>Mod</kbd> + <kbd>w</kbd>: Switch to workspace 2
- <kbd>Mod</kbd> + <kbd>e</kbd>: Switch to workspace 3
- <kbd>Mod</kbd> + <kbd>r</kbd>: Switch to workspace 4
- <kbd>Mod</kbd> + <kbd>u</kbd>: Switch to workspace 5
- <kbd>Mod</kbd> + <kbd>i</kbd>: Switch to workspace 6
- <kbd>Mod</kbd> + <kbd>o</kbd>: Switch to workspace 7
- <kbd>Mod</kbd> + <kbd>p</kbd>: Switch to workspace 8

### Moving windows to workspaces

- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>q</kbd>: Move window to workspace 1
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>w</kbd>: Move window to workspace 2
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>e</kbd>: Move window to workspace 3
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>r</kbd>: Move window to workspace 4
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>u</kbd>: Move window to workspace 5
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>i</kbd>: Move window to workspace 6
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>o</kbd>: Move window to workspace 7
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>p</kbd>: Move window to workspace 8

### Moving focus between windows

- <kbd>Mod</kbd> + <kbd>h</kbd>: Move focus to the left
- <kbd>Mod</kbd> + <kbd>l</kbd>: Move focus to the right
- <kbd>Mod</kbd> + <kbd>j</kbd>: Move focus down
- <kbd>Mod</kbd> + <kbd>k</kbd>: Move focus up

### Moving windows

- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>h</kbd>: Move window to the left
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>l</kbd>: Move window to the right
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>j</kbd>: Move window down
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>k</kbd>: Move window up

### Resizing windows

- <kbd>Mod</kbd> + <kbd>Control</kbd> + <kbd>h</kbd>: Resize window to the left
- <kbd>Mod</kbd> + <kbd>Control</kbd> + <kbd>l</kbd>: Resize window to the right
- <kbd>Mod</kbd> + <kbd>Control</kbd> + <kbd>j</kbd>: Resize window down
- <kbd>Mod</kbd> + <kbd>Control</kbd> + <kbd>k</kbd>: Resize window up

### Layouts

- <kbd>Mod</kbd> + <kbd>Tab</kbd>: Switch to next layout

### System

- <kbd>Mod</kbd> + <kbd>Control</kbd> + <kbd>Shift</kbd> + <kbd>q</kbd>: Shutdown system
- <kbd>Mod</kbd> + <kbd>Control</kbd> + <kbd>Shift</kbd> + <kbd>r</kbd>: Restart system
- <kbd>Mod</kbd> + <kbd>Control</kbd> + <kbd>q</kbd>: Shutdown Qtile
- <kbd>Mod</kbd> + <kbd>Control</kbd> + <kbd>r</kbd>: Restart Qtile

### Other

- <kbd>Mod</kbd> + <kbd>f</kbd>: Toggle fullscreen
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>f</kbd>: Toggle float window
- <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>s</kbd>: Take screenshot, copy to clipboard and save to file
