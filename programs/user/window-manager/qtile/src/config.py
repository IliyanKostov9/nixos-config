import subprocess
import os
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
alt = "mod1"
page_up = "Prior"
page_down = "Next"
end = "End"
home = "Home"
enter = "Return"
ctrl = "control"
tab = "Tab"

# terminal = guess_terminal()
terminal = "ghostty"

keys = [
    # NOTE: Window related
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, alt], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, alt], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, alt], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, alt], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod],
        enter,
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], enter, lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "t", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    # TODO: Change that to something different
    # Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key(
        [mod],
        "d",
        lazy.spawn(
            f"rofi -show drun -icon-theme 'oomox-rose-pine' -show-icons -sidebar-mode -transient-window -matching normal -sorting-method fzf -terminal {terminal}"
        ),
        desc="Spawn a command using a prompt widget",
    ),
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    # NOTE: Common
    Key(
        [mod],
        "space",
        lazy.widget["keyboardlayout"].next_keyboard(),
        desc="Next keyboard layout",
    ),
    Key([mod, alt], "n", lazy.spawn("pcmanfm ~"), desc="File manager"),
    Key([alt], "f", lazy.spawn("flameshot gui"), desc="Flameshot"),
    Key([alt], "n", lazy.spawn("normcap"), desc="OCR"),
    Key([alt], "v", lazy.spawn("copyq menu"), desc="Clipboard manager"),
    # NOTE: PC related
    Key([mod, alt], page_down, lazy.spawn("shutdown -h now"), desc="Shutdown PC"),
    Key([mod, alt], page_up, lazy.spawn("reboot"), desc="Reboot PC"),
    Key([mod, alt], home, lazy.spawn("systemctl suspend"), desc="Suspend PC"),
    Key([mod, alt], end, lazy.shutdown(), desc="Shutdown Qtile"),
    # NOTE: Browser settings
    Key([mod, ctrl], "m", lazy.spawn("librewolf -P Main"), desc="Open librewolf"),
    Key([mod, ctrl], "l", lazy.spawn("librewolf -P Social"), desc="Open librewolf"),
    Key([mod, ctrl], "y", lazy.spawn("librewolf -P Youtube"), desc="Open librewolf"),
    Key([mod, ctrl], "t", lazy.spawn("librewolf -P Test"), desc="Open librewolf"),
    Key([mod, ctrl], "c", lazy.spawn("chromium"), desc="Open chromium"),
    # NOTE: Sound
    Key(
        [mod, "shift"],
        "equal",
        lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%+'"),
        desc="wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%+'",
    ),
    Key(
        [mod, "shift"],
        "minus",
        lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%-'"),
        desc="wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%+'",
    ),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Max(),
    # layout.Columns(border_focus_stack=["#5499c7", "#8f3d3d"], border_width=2),
    # layout.Stack(num_stacks=2),
    layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="0xProto Nerd Font Mono",
    fontsize=15,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper="/etc/nixos/.background-image.jpg",
        wallpaper_mode="fill",
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Sep(),
                widget.Spacer(),
                # widget.Wlan(),
                # widget.Net(format="{interface}: U {up} D {down} T {total}"),
                widget.Battery(),
                widget.BatteryIcon(),
                widget.Wttr(location={"Nice": "Nice, France"}),
                widget.PulseVolume(
                    emoji=True,
                    limit_max_volume=True,
                    step=5,
                    fmt="{}",
                    unmute_format="{emoji} {volume}%",
                    mute_format="🔇 Muted",
                    update_interval=0.5,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn("pwvucontrol"),
                        "Button2": lazy.spawn(
                            "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                        ),
                    },
                ),
                widget.KeyboardLayout(
                    configured_keyboards=["us(dvorak)", "bgd"], font="sans"
                ),
                widget.Clock(
                    format="%Y-%m-%d %a %H:%M",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn("gnome-calendar"),
                    },
                ),
                widget.StatusNotifier(),
            ],
            26,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
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

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
# NOTE: Cursor
wl_xcursor_theme = None
wl_xcursor_size = 23

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    # denv = dict(os.environ)
    # denv["XDG_CURRENT_DESKTOP"] = "qtile"
    # p = subprocess.Popen(
    #     [
    #         "systemctl",
    #         "--user",
    #         "import-environment",
    #         "WAYLAND_DISPLAY",
    #         "XDG_CURRENT_DESKTOP",
    #     ],
    #     env=denv,
    # ).wait()

    home = os.path.expanduser(
        "/etc/nixos/programs/system/window-manager/qtile/src/autostart.sh"
    )
    subprocess.call([home])
