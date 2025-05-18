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
  imports = [
    ../style/waybar
  ];

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
      extraOptions = ["--unsupported-gpu"];
      extraSessionCommands = ''
        export XDG_CACHE_HOME="${config.home.homeDirectory}/.cache"
        export WLR_NO_HARDWARE_CURSORS=1
        export WLR_RENDERER_ALLOW_SOFTWARE=1
        export WLR_BACKEND="drm"
        export XDG_SESSION_DESKTOP=sway
        export SDL_VIDEODRIVER=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export CLUTTER_BACKEND=wayland
        export ELM_ENGINE=wayland_egl
        export NO_AT_BRIDGE=1
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
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
            "${mod}+space" = "exec swaymsg input '*' xkb_layout us";

            "${mod}+q" = "exec swaymsg input type:keyboard xkb_variant ' '";
            "${mod}+b" = "exec swaymsg input '*' xkb_layout bgd";
            "${mod}+g" = "exec swaymsg input '*' xkb_layout de";
            "${mod}+c" = "exec swaymsg input '*' xkb_layout fr";

            # PC
            "${mod}+${alt}+Page_Down" = "exec shutdown -h now";
            "${mod}+${alt}+Page_Up" = "exec reboot";
            "${mod}+${alt}+End" = "exec swaymsg exit";
            "${mod}+${alt}+Home" = "exec systemctl suspend";

            ## Audio
            ### Pipewire
            "${mod}+${alt}+equal" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%+'";
            "${mod}+${alt}+minus" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%-'";
            "${mod}+${alt}+m" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

            "${mod}+Return" = "exec ${terminal}";
            "${mod}+${shift}+q" = "kill";
            "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -icon-theme 'oomox-rose-pine' -show-icons -sidebar-mode -transient-window -matching normal -sorting-method fzf -terminal ${terminal}";

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

            "${mod}+${shift}+r" = "exec swaymsg reload";

            # Resize
            "${mod}+${alt}+h" = "resize shrink width 10 px or 10 ppt";
            "${mod}+${alt}+j" = "resize grow height 10 px or 10 ppt";
            "${mod}+${alt}+k" = "resize shrink height 10 px or 10 ppt";
            "${mod}+${alt}+l" = "resize grow width 10 px or 10 ppt";
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

        bars = [];
      };
      extraConfig = ''
        default_border pixel 1

        # NOTE: Hide tabs if it's only 1
        gaps outer 0
        gaps inner 0
        hide_edge_borders --i3 smart
        workspace_layout tabbed

        output eDP-1 {
          scale 1.5
          mode 2560x1600@165Hz
        }

        input * {
          xkb_layout us
          xkb_variant dvorak
        }

        # Enable border color
        # for_window [class="^.*"] border pixel 2
        for_window [class="blueman-manager"] floating enable
        for_window [class="copyq"] focus

        # Wallpaper
        exec swaybg -i /etc/nixos/.background-image.jpg -m fill

        exec_always dex --autostart --environment sway
        exec_always swaymsg workspace 1
        exec_always xss-lock --transfer-sleep-lock -- i3lock --nofork

        # Autostart
        exec nm-applet
        exec copyq
        exec viber
        exec whatsapp
        exec librewolf

        # Disable touchpad
        #
        ## Thinkpad
        exec_always swaymsg input "Elan Touchpad" events disabled
        ## Legion
        exec_always swaymsg input "1267:12926:ELAN06FA:00_04F3:327E_Touchpad" events disabled

        ## Autoplace apps in workplaces
        assign [class="ghostty"] 1
        assign [class="librewolf"] 2
        assign [class="chromium"] 5
      '';
    };
  };
}
