from libqtile.config import Key
from libqtile.command import lazy

mod = "mod1"
terminal = "alacritty"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "f", lazy.hide_show_bar(), desc="Toggle top bar"),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "x", lazy.window.kill(), desc="Kill focused window"),
    #Shutdown/Restart Qtile
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    #Shutdown/Restart System
    Key([mod, "control", "shift"], "q", lazy.spawn("shutdown now"), desc="Shutdown system"),
    Key([mod, "control", "shift"], "r", lazy.spawn("reboot"), desc="Reboot system"),
    #Rofi (https://github.com/adi1090x/rofi)
    Key([mod], "l", lazy.spawn("/home/koch/.config/rofi/launchers/type-1/launcher.sh")),
    Key([mod], "t", lazy.spawn("/home/koch/.config/rofi/launchers/type-1/launcherW.sh")),
    #ScreenShot
    Key(["mod4"], "s", lazy.spawn("scrot 'Pictures/ScreenShot.png' -z -o -e 'xclip -selection clipboard -t image/png -i $f'")),
    Key(["mod4", "shift"], "s", lazy.spawn("scrot 'Pictures/ScreenShot.png' -o -f -s -z -e 'xclip -selection clipboard -t image/png -i $f'")),
    #Volume control
    Key([mod], "F3", lazy.spawn("amixer -c 1 sset Master 5%+")),
    Key([mod], "F2", lazy.spawn("amixer -c 1 sset Master 5%-")),
    Key([mod], "F4", lazy.spawn("amixer -c 1 sset Master toggle")),
    #Brightness control
    Key([mod], "F6", lazy.spawn("brightnessctl s 5%+")),
    Key([mod], "F5", lazy.spawn("brightnessctl s 5%-")),
    #Screens control
    Key([], "F1", lazy.next_screen(), desc='Next monitor'),
    Key([mod], "b", lazy.spawn("thorium-browser"))
]

