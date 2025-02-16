{ pkgs, lib, config, ... }:
with lib;
with lib.types;
let
  cfg = config.modules.window-manager.i3wm;
  key-mappings = { key-name-prefix, value-name-prefix, attr-mappings }:
    builtins.listToAttrs (lib.attrsets.mapAttrsToList
      (key: value: {
        name = "${key-name-prefix}+${key}";
        value = "${value-name-prefix} ${value}";
      })
      attr-mappings);
in
{
  options.modules.window-manager.i3wm = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable i3wm window manager
      '';
    };

    librewolf-mappings = mkOption {
      type = attrsOf str;
      default = { "m" = "default"; };
      description = mkDoc ''
        Additional i3wm mappings for librewolf profiles
      '';
    };

    firejail-mappings = mkOption {
      type = attrsOf str;
      default = { };
      description = mkDoc ''
        Additional i3wm mappings for firejail contained pkgs
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      i3
      # picom
    ];

    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        floating.modifier = "Mod4";
        fonts = {
          names = [ "${config.modules.preferences.fonts.name}NerdFontMono-Regular" ];
          style = "Bold Semi-Condensed";
          size = 9.0;
        };
        keybindings =
          let
            mod = config.xsession.windowManager.i3.config.modifier;
            alt = "Mod1";
            ctrl = "Control";
            shift = "Shift";
          in
          {
            "${mod}+${ctrl}+c" = "exec chromium";

            "${mod}+${alt}+n" = "exec --no-startup-id pcmanfm ~/";
            "${alt}+f" = "exec flameshot gui";
            "${alt}+n" = "exec normcap";
            "${alt}+v" = "exec --no-startup-id copyq menu";

            # Keyboard layout
            "${mod}+space" = "exec setxkbmap us dvorak";
            "${mod}+q" = "exec setxkbmap us";
            "${mod}+b" = "exec setxkbmap -layout bgd";
            "${mod}+g" = "exec setxkbmap -layout de";

            # PC
            "${mod}+${alt}+Page_Down" = "exec shutdown -h now";
            "${mod}+${alt}+Page_Up" = "exec reboot";
            "${mod}+${alt}+End" = "exec i3-msg exit";
            "${mod}+${alt}+Home" = "exec systemctl suspend";
            ## Audio
            "${mod}+${alt}+plus" = "exec --no-startup-id pamixer --increase 5";
            "${mod}+${alt}+minus" = "exec --no-startup-id pamixer --decrease 5";
            "${mod}+${alt}+m" = "exec --no-startup-id pamixer --toggle-mute";

            # Default i3 options
            "${mod}+Return" = "exec alacritty";
            "${mod}+${shift}+q" = "kill";
            "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -icon-theme 'oomox-rose-pine' -show-icons -sidebar-mode -transient-window -matching normal -sorting-method fzf -terminal alacritty";
            # Select theme:  "rofi-theme-selector";
            # "${mod}+${alt}+d" = "exec --no-startup-id xfce4-appfinder";

            # Fallback to primary monitor
            "${mod}+${alt}+q" = "exec xrandr --output HDMI-0 --auto";

            # Mark
            "${mod}+m" = "exec i3-input -F 'mark %s' -l 1 -P 'Mark: '";
            # Jump
            "${mod}+/" = "exec i3-input -F '[con_mark = \"%s\"] focus' -l 1 -P 'Goto: '";

            # change focus
            "${mod}+h" = "focus left";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right";

            # move focused window
            "${mod}+${shift}+h" = "move left";
            "${mod}+${shift}+j" = "move down";
            "${mod}+${shift}+k" = "move up";
            "${mod}+${shift}+l" = "move right";

            # split in horizontal orientation
            "${mod}+z" = "split h";
            # split in vertical orientation
            "${mod}+v" = "split v";

            # enter fullscreen mode for the focused container
            "${mod}+f" = "fullscreen toggle";

            # change container layout (stacked, tabbed, toggle split)
            "${mod}+s" = "layout stacking";
            "${mod}+t" = "layout tabbed";
            "${mod}+e" = "layout toggle split";


            # toggle tiling / floating
            "${mod}+${shift}+space" = "floating toggle";
            # change focus between tiling / floating windows
            "${mod}+${alt}+space" = "focus mode_toggle";
            # focus the parent container
            "${mod}+a" = "focus parent";

            "${mod}+${shift}+minus" = "move scratchpad";
            "${mod}+minus" = "scratchpad show";

            # switch to workspace
            "${mod}+1" = "workspace number 1";
            "${mod}+2" = "workspace number 2";
            "${mod}+3" = "workspace number 3";
            "${mod}+4" = "workspace number 4";
            "${mod}+5" = "workspace number 5";
            "${mod}+6" = "workspace number 6";
            "${mod}+7" = "workspace number 7";
            "${mod}+8" = "workspace number 8";
            "${mod}+9" = "workspace number 9";
            "${mod}+0" = "workspace number 10";
            # move focused container to workspace
            "${mod}+${shift}+1" = "move container to workspace number 1";
            "${mod}+${shift}+2" = "move container to workspace number 2";
            "${mod}+${shift}+3" = "move container to workspace number 3";
            "${mod}+${shift}+4" = "move container to workspace number 4";
            "${mod}+${shift}+5" = "move container to workspace number 5";
            "${mod}+${shift}+6" = "move container to workspace number 6";
            "${mod}+${shift}+7" = "move container to workspace number 7";
            "${mod}+${shift}+8" = "move container to workspace number 8";
            "${mod}+${shift}+9" = "move container to workspace number 9";
            "${mod}+${shift}+0" = "move container to workspace number 10";

            # reload the configuration file
            "${mod}+${shift}+c" = "reload";
            # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
            "${mod}+${shift}+r" = "restart";
            # exit i3 (logs you out of your X session)
            "${mod}+${shift}+e" = "exec 'i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";

            # Resize
            "${mod}+${alt}+h" = "resize shrink width 10 px or 10 ppt";
            "${mod}+${alt}+j" = "resize grow height 10 px or 10 ppt";
            "${mod}+${alt}+k" = "resize shrink height 10 px or 10 ppt";
            "${mod}+${alt}+l" = "resize grow width 10 px or 10 ppt";
            # "Return" = "mode 'default'";
            # "${mod}+r" = "resize";

          }
          # Librewolf
          // key-mappings {
            key-name-prefix = "${mod}+${ctrl}";
            # BUG: can't use --apparmor, due to bug described at apparmor module
            value-name-prefix = "exec librewolf -P";
            attr-mappings = cfg.librewolf-mappings;
          }
          # Firejail
          // key-mappings {
            key-name-prefix = "${mod}+${alt}";
            value-name-prefix = "exec firejail --noprofile";
            attr-mappings = cfg.firejail-mappings;
          };

        bars = [
          {
            position = "bottom";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
            colors = {
              background = "#444444";
              focusedWorkspace = {
                background = "#A4936E";
                border = "#333333";
                text = "#ffffff";
              };
            };
          }
        ];
      };
      extraConfig = ''
        default_border pixel 1
        # Disable titlebar
        for_window [class=".*"] border pixel 0
        for_window [class="^.*"] client.focused          #77dd77 #285577 #ffffff #2e9ef4   #285577
        # Enable border color
        # for_window [class="^.*"] border pixel 2
        for_window [class="blueman-manager"] floating enable
        for_window [class="copyq"] focus

        exec --no-startup-id dex --autostart --environment i3
        exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
        exec --no-startup-id nm-applet
        exec --no-startup-id i3-msg "workspace 1"

        # Disable touchpad
        exec --no-startup-id xinput disable "Elan Touchpad"

        # Enable transparency
        # exec --no-startup-id picom &

        # Autostart clipboard
        exec --no-startup-id copyq

        tiling_drag modifier titlebar
      '';
    };

    programs.i3status-rust = {
      enable = true;
      bars = {
        top = {
          blocks = [
            {
              block = "uptime";
              interval = 3600;
            }
            {
              block = "toggle";
              format = " $icon ";
              interval = 5;
              command_on = "xrandr --output HDMI-0 --auto && xrandr --output eDP-1-1 --off";
              command_off = "xrandr --output HDMI-0 --off && xrandr --output eDP-1-1 --auto";
              command_state = "xrandr | grep 'HDMI-0 connected 1920x' | grep -v eDP-1-1";
              click = [
                {
                  button = "left";
                  action = "toggle";
                  widget = ".";
                }
              ];
            }
            {
              block = "net";
              format = "$icon {$signal_strength ssid @$frequency|wired} via $device ";
              interval = 5;
              missing_format = " x ";
              inactive_format = " $icon ";
            }
            {
              block = "external_ip";
              format = "$country_flag ";
              with_network_manager = true;
              interval = 300;
              use_ipv4 = true;
            }
            {
              block = "battery";
              interval = 30;
              format = " $icon $percentage $time"; # $power
              full_format = " $icon";
              info = 60;
              good = 60;
              warning = 30;
              critical = 15;
              full_threshold = 95;
              missing_format = "";
            }
            {
              block = "backlight";
              format = " $icon $brightness |";
              invert_icons = true;
              device = "intel_backlight";
              missing_format = "";
            }
            {
              block = "bluetooth";
              mac = "08:BF:B8:4C:CD:5F";
              format = " $icon $name{$percentage $battery_icon $available|} ";
              disconnected_format = " $icon{ $name|} ";
              click = [
                {
                  button = "left";
                  cmd = "blueman-manager";
                }
              ];
            }
            {
              block = "keyboard_layout";
              driver = "setxkbmap";
              interval = 1;
              format = " ^icon_keyboard $layout ";
            }
            {
              block = "sound";
              show_volume_when_muted = true;
              headphones_indicator = true;
              click = [
                {
                  button = "left";
                  cmd = "pavucontrol --tab=3";
                }
              ];
            }
            {
              block = "time";
              interval = 60;
              format = " $icon $timestamp.datetime(f:'%a %d/%m %R') ";
              click = [
                {
                  button = "left";
                  cmd = "gnome-calendar";
                }
              ];
            }
          ];
          settings = {
            theme = {
              theme = "bad-wolf";
              overrides = { separator = ""; };
            };
          };
          icons = "material-nf";
        };
      };
    };

    # pkill picom && picom -b
    services.picom = {
      enable = false;
      settings = {
        backend = "glx";
        active-opacity = 1.0;
        detect-client-leader = true;
        detect-client-opacity = true;
        detect-rounded-corners = false;
        detect-transient = true;
        frame-opacity = 1.0;
        glx-no-rebind-pixmap = false;
        glx-no-stencil = false;
        glx-swap-method = 1;

        # Remove blur on unfocused windows
        inactive-dim = 0;
        inactive-opacity = 1.0;

        transparent-clipping = false;
        unredir-if-possible = true;
        use-damage = true;
        vsync = false;
        xrender-sync-fence = true; # for nvidia only

        wintypes = {
          dock = {
            opacity = 1.0;
            shadow = false;
            full-shadow = false;
          };
          menu = {
            fade = false;
            opacity = false;
            shadow = false;
            full-shadow = false;
          };
          utility = {
            fade = false;
            opacity = false;
            shadow = false;
            full-shadow = false;
          };
          tooltip = {
            fade = false;
            opacity = false;
            shadow = false;
            full-shadow = false;
            focus = false;
          };
          dropdown_menu = {
            opacity = 0.89;
            fade = false;
            shadow = false;
            full-shadow = false;
          };
          popup_menu = {
            opacity = 0.89;
            fade = false;
            shadow = false;
            full-shadow = false;
          };
        };

        opacity-exclude = [
          "class_g = 'mpv'"
          "class_i = 'mpv'"
        ];

        focus-exclude = [
          "class_g *?= 'Steam'"
          "class_g = 'Polybar'"
          "class_g = 'mpv'"
          "class_g = 'rofi'"
          "class_g = 'slop'"
          "name *?= 'Steam'"
        ];

        blur-background-exclude = [
          "class_g *= 'Peek'"
          "class_g *= 'overlay'"
          "class_g = 'nwim'"
          "class_g = 'slop'"
          "class_g = 'term'"
          "class_g = 'xsnow'"
          "class_i = 'nwim'"
          "class_i = 'term'"
          "name *= 'overlay'"
          "name *= 'polybar-floating_wm'"
          "window_type = 'desktop'"
          "window_type = 'dnd'"

          "_GTK_FRAME_EXTENTS@:c"
        ];

        blur = {
          method = "dual_kawase"; # gaussian
          blur-strength = 7;
          blur-background-fixed = true;
        };

        opacity-rule = [
          "80:class_g = 'i3-frame'"
          "90:class_g = 'Joplin'"
          "95:class_g = 'Zathura'"
          "100:class_g = 'mpv'"
          "100:class_g = 'slop'"
          "100:fullscreen"

          "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
          "100:_GTK_FRAME_EXTENTS@:c"
        ];

        shadow-exclude = [
          "! name~=''"
          "!focused"

          "class_g *= 'overlay'"
          "class_g = 'Conky'"
          "class_g = 'Dunst'"
          "class_g = 'Firefox' && argb"
          "class_g = 'Rofi'"
          "class_g = 'Synapse'"
          "class_g ?= 'Cairo-dock'"

          "name *= 'Chromium'"
          "name *= 'overlay'"
          "name *= 'picom'"
          "name *= 'polybar'"

          # Zoom
          "name = 'cpt_frame_window'"
          "name = 'cpt_frame_xcb_window'"
          "name = 'as_toolbar'"

          "_GTK_FRAME_EXTENTS@:c"
          "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
        ];

        corner-radius = 15.0;
        rounded-corners-exclude = [
          "class_g *= ''"

          "class_g != 'Dunst'"
          "class_g != 'Polybar'"
          "class_g *= 'Thunar'"
          "class_g *= 'thunar'"
          "class_g = 'Alacritty'"
          "class_g = 'URxvt'"
          "class_g = 'XTerm'"
          "class_g = 'awesome'"
          "class_g = 'firefox'"
          "class_g = 'kitty'"

          "window_type = 'menu'"
          "window_type = 'normal'"
          "window_type = 'popup'"
        ];

        shadow = true;
        shadow-radius = 9.0;
        shadow-offset-x = -9.0;
        shadow-offset-y = -9.0;
        shadow-opacity = 0.8;
        shadow-exclude-reg = "x10+0+0";
        shadow-red = 0.0;
        shadow-green = 0.3;
        shadow-blue = 0.35;
      };
    };
  };
}
