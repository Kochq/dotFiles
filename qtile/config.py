# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Match, Screen, Match, Key
from libqtile.lazy import lazy
from settings.keyMaps import keys, mod
from settings.utilFunctions import *

import os

CaskaydiaFont = 'CaskaydiaCove Nerd Font Mono'

othersColors = [["#282828", "#1c1f24", "#cc241d", "#98971a", "#d79921", "#458588", "#b16286", "#689d6a", "#a89984"], # Gruvbox
                [ "#282c34", "#1c1f24", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf"], # OneDark
                [ "#282c34", "#263238", "#f07178", "#c3e88d", "#ffcb6b", "#82aaff", "#c792ea", "#89ddff", "#eeffff", "f78c6c"], # Material 
                [ "#26233a", "#1f1d2e", "#eb6f92", "#31748f", "#f6c177", "#ebbcba", "#c4a7e7", "#9ccfd8", "#eeffff", "f78c6c"]] # Rose pine

colors = othersColors[3]

#groups = [Group(i) for i in "123456789"]

__groups = {
    "q": Group(""),
    "w": Group(""),
    "e": Group(""),
    "r": Group(""),
    "u": Group(""),
    "i": Group(""),
    "o": Group(""),
    "p": Group(""),
}

groups = [__groups[i] for i in __groups]

def get_group_key(name):
    return [k for k, g in __groups.items() if g.name == name][0]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                str(get_group_key(i.name)),
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + letter of group = switch to group

            Key(
                [mod, "shift"],
                str(get_group_key(i.name)),
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group

            # Or, use below if you prefer not to switch to that group.
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
            # # mod1 + shift + letter of group = move focused window to group
        ]
    )

layouts = [
    layout.Columns(
        margin=0,
        border_width=1,
        margin_on_single=0,
        border_focus=colors[5],
    ),

    # layout.MonadTall(
    #      margin=5,
    #      single_margin=0,
    #      border_width=1,
    #      single_border_width=0,
    #      border_focus=colors[5],
    #  ),

    layout.Max(),

    layout.TreeTab(
        active_bg=colors[5]+"80",
        inactive_bg="60606060",
        bg_color='00000080',
        sections = ['Internet', 'Terminales'],
    ),

    # layout.Tile(),
    # layout.Zoomy(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.VerticalTile(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(margin=4),
]

widget_defaults = dict(
    font="CaskaydiaCove Nerd Font Mono",
    fontsize=17,
    padding=1,
    background=colors[0]
)

extension_defaults = widget_defaults.copy()

fsize = 15

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font=CaskaydiaFont,
                    fontsize=27,
                    margin_x=0,
                    padding_y=8,
                    padding_x=5,
                    this_current_screen_border=colors[6],
                    borderwidth=1,
                    inactive="777777",
                    rounded=False,
                    highlight_method='block',
                    urgent_alert_method='block',
                    disable_drag=True,
                ),
                widget.Spacer(length=5),
                widget.Sep(
                    linewidth=0,
                    padding=6,
                    foreground="#333333",
                    background="#333333"
                ),
                widget.Spacer(length=5),

                widget.TaskList(
                    font=CaskaydiaFont,
                    border=colors[0],
                    margin=1,
                    padding=3,
                    fontsize=13,
                    icon_size=15
                ),

                # Disk freespace
                widget.DF(warn_space=3),
                # CPU Temperature 
                widget.TextBox(
                    text='',
                    font="Ubuntu Mono",
                    background=colors[0],
                    foreground=colors[7],
                    padding=-6.1,
                    fontsize=45
                ),
                widget.ThermalSensor(
                    font=CaskaydiaFont,
                    foreground=colors[1],
                    background=colors[7],
                    threshold=60,
                    fmt='Temp: {}',
                    padding=5
                ),

                # Apps Icons
                widget.TextBox(
                    text='',
                    font="Ubuntu Mono",
                    background=colors[7],
                    foreground=colors[6],
                    padding=-6.1,
                    fontsize=45
                ),
                widget.Systray(
                    foreground=colors[1],
                    background=colors[6],
                    padding=5
                ),
                widget.Sep(linewidth=1, foreground=colors[6], background=colors[6]),
                widget.CurrentLayoutIcon(
                    foreground=colors[1],
                    background=colors[6],
                    padding=5,
                ),
                widget.Sep(linewidth=1, foreground=colors[6], background=colors[6]),

                # Battery
                widget.TextBox(
                    text='',
                    font="Ubuntu Mono",
                    background=colors[6],
                    foreground=colors[5],
                    padding=-5.1,
                    fontsize=45
                ),
                widget.Battery(
                    foreground=colors[1],
                    font=CaskaydiaFont,
                    padding=5,
                    background=colors[5],
                    update_interval=10,
                    charge_char='󰂄',
                    discharge_char='󰂎',
                    unknown_char='󰂑',
                    format='{char} {percent:2.0%}'
                ),

                # Brightness
                widget.TextBox(
                    text='',
                    font="Ubuntu Mono",
                    background=colors[5],
                    foreground=colors[4],
                    padding=-5.1,
                    fontsize=45
                ),
                widget.TextBox(
                    text="", font=CaskaydiaFont,
                    fontsize=27,
                    padding=5,
                    background=colors[4],
                    foreground=colors[1],
                ),
                widget.Backlight(
                    font=CaskaydiaFont,
                    backlight_name='intel_backlight',
                    mouse_callbacks={'Button1': incBrightness,
                                     'Button3': decBrightness},
                    fmt="{} ",
                    background=colors[4],
                    foreground=colors[1],
                ),

                #Volume
                widget.TextBox(
                    text='',
                    font="Ubuntu Mono",
                    background=colors[4],
                    foreground=colors[3],
                    padding=-6.1,
                    fontsize=45
                ),
                widget.TextBox(
                    text="󰕾", font=CaskaydiaFont,
                    fontsize=27,
                    padding=5,
                    foreground=colors[1],
                    background=colors[3]
                ),
                widget.Volume(
                    channel="Master",
                    font=CaskaydiaFont,
                    fmt='{} ',
                    foreground=colors[1],
                    background=colors[3]
                ),
                widget.TextBox(
                    text="", font=CaskaydiaFont,
                    fontsize=22,
                    padding=5,
                    foreground=colors[1],
                    background=colors[3]
                ),
                widget.Volume(
                    channel="Capture",
                    font=CaskaydiaFont,
                    fmt='{} ',
                    foreground=colors[1],
                    background=colors[3]
                ),
                # widget.KeyboardLayout(
                #       foreground = colors[1],
                #       background = colors[6],
                #       configured_keyboards=['latam','us'],
                #       padding = 5
                #       ),

                # Calendar
                widget.TextBox(
                    text='',
                    font="Ubuntu Mono",
                    background=colors[3],
                    foreground=colors[2],
                    padding=-6.1,
                    fontsize=45
                ),
                widget.TextBox(
                    text="󰃰", font=CaskaydiaFont,
                    fontsize=27,
                    padding=7,
                    background=colors[2],
                    foreground=colors[1],
                ),
                widget.Clock(
                    font=CaskaydiaFont,
                    foreground=colors[1],
                    background=colors[2],
                    format="%d/%m/%y - %H:%M "
                ),
            ],
            25,
            # border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = False

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

wl_input_rules = None

wmname = "LG3D"

autostart = [
    "feh --bg-fill /home/koch/Pictures/wallpapers/moon.jpg",
    "picom --no-vsync --fade-in-step=1 --fade-out-step=1 --fade-delta=0 &",
    "~/dotFiles/myScripts/MouseSettings",
]

for a in autostart:
    os.system(a)
