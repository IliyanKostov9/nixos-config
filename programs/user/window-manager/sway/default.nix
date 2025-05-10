{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  terminal = config.modules.dev.emulator.default;
  cfg = config.modules.window-manager.sway;
  key-mappings = {
    key-name-prefix,
    value-name-prefix,
    attr-mappings,
  }:
    builtins.listToAttrs (lib.attrsets.mapAttrsToList
      (key: value: {
        name = "${key-name-prefix}+${key}";
        value = "${value-name-prefix} ${value}";
      })
      attr-mappings);
in {
  options.modules.window-manager.sway = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable sway window manager
      '';
    };

    librewolf-mappings = mkOption {
      type = attrsOf str;
      default = {"m" = "default";};
      description = mkDoc ''
        Additional sway mappings for librewolf profiles
      '';
    };

    firejail-mappings = mkOption {
      type = attrsOf str;
      default = {};
      description = mkDoc ''
        Additional sway mappings for firejail contained pkgs
      '';
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      swaynag.enable = true;
      wrapperFeatures.gtk = true;
      config = {
        inherit terminal;
        modifier = "Mod4";
        floating.modifier = "Mod4";
        fonts = {
          names = ["${config.modules.preferences.fonts.name}NerdFontMono-Regular"];
          style = "Bold Semi-Condensed";
          size = 9.0;
        };
        keybindings = let
          mod = "Mod4";
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
            "${mod}+c" = "exec setxkbmap -layout fr";

            # PC
            "${mod}+${alt}+Page_Down" = "exec shutdown -h now";
            "${mod}+${alt}+Page_Up" = "exec reboot";
            # "${mod}+${alt}+End" = "exec i3-msg exit";
            "${mod}+${alt}+Home" = "exec systemctl suspend";

            ## Audio
            ### Pipewire
            "${mod}+${alt}+plus" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%+'";
            "${mod}+${alt}+minus" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%-'";
            "${mod}+${alt}+m" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

            ### PulseAudio
            # "${mod}+${alt}+plus" = "exec --no-startup-id pamixer --increase 5";
            # "${mod}+${alt}+minus" = "exec --no-startup-id pamixer --decrease 5";
            # "${mod}+${alt}+m" = "exec --no-startup-id pamixer --toggle-mute";

            # Default sway options
            "${mod}+Return" = "exec ${terminal}";
            "${mod}+${shift}+q" = "kill";
            "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -icon-theme 'oomox-rose-pine' -show-icons -sidebar-mode -transient-window -matching normal -sorting-method fzf -terminal ${terminal}";
            # "${mod}+${alt}+d" = "exec --no-startup-id xfce4-appfinder";

            # Fallback to primary monitor
            "${mod}+${alt}+q" = "exec xrandr --output HDMI-0 --auto";

            # Mark
            # "${mod}+m" = "exec i3-input -F 'mark %s' -l 1 -P 'Mark: '";
            # Jump
            # "${mod}+/" = "exec i3-input -F '[con_mark = \"%s\"] focus' -l 1 -P 'Goto: '";

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
            # restart sway inplace (preserves your layout/session, can be used to upgrade i3)
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

        # exec --no-startup-id nm-applet

        # Disable touchpad
        #
        ## Thinkpad
        exec --no-startup-id xinput disable "Elan Touchpad"
        ## Legion
        exec --no-startup-id xinput disable "ELAN06FA:00 04F3:327E Touchpad"

        # Enable transparency
        # exec --no-startup-id picom &

        # Autostart clipboard
        exec --no-startup-id copyq

        # tiling_drag modifier titlebar
      '';
    };
  };
}
