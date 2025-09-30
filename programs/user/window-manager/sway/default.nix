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
        value = "${value-name-prefix}'${value}'";
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

    browser-mappings = mkOption {
      type = attrsOf str;
      default = {"m" = "default";};
      description = mkDoc ''
        Additional sway mappings for browser profiles
      '';
    };

    browser-exec = mkOption {
      type = str;
      default = "librewolf -P ";
      description = mkDoc ''
        Executable for profile switching
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
          size = 7.0;
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
            "${alt}+v" = "exec --no-startup-id copyq toggle";

            # Keyboard layout
            "${mod}+space" = "exec swaymsg input '*' xkb_layout us";
            "${mod}+q" = "exec swaymsg input type:keyboard xkb_variant us";
            "${mod}+b" = "exec swaymsg input '*' xkb_layout bgd";
            "${mod}+g" = "exec swaymsg input '*' xkb_layout de";
            "${mod}+c" = "exec swaymsg input '*' xkb_layout fr";

            # PC
            "${mod}+${alt}+Page_Down" = "exec shutdown -h now";
            "${mod}+${alt}+Page_Up" = "exec reboot";
            "${mod}+${alt}+End" = "exec swaymsg exit";
            "${mod}+${alt}+Home" = "exec systemctl suspend";
            "${mod}+${alt}+s" = "exec swaymsg output eDP-1 enable && exec swaymsg output HDMI-A-1 disable";

            ## Audio
            ### Pipewire
            "${mod}+${alt}+equal" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%+'";
            "${mod}+${alt}+minus" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ '5%-'";
            "${mod}+${alt}+m" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

            "${mod}+Return" = "exec ${terminal}";
            "${mod}+${shift}+q" = "kill";
            "${mod}+d" = "exec ${pkgs.wofi}/bin/wofi --show drun --allow-images --sort-order fzf --term ${terminal} --hide-scroll";

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

            "${mod}+z" = "split h";
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
          # Browser
          // key-mappings {
            key-name-prefix = "${mod}+${ctrl}";
            # BUG: can't use --apparmor, due to bug described at apparmor module
            value-name-prefix = "exec ${cfg.browser-exec}";
            attr-mappings = cfg.browser-mappings;
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

         output HDMI-A-1 {
           scale 1.0
           mode 2560x1440@60Hz
         }

        input * {
          xkb_layout us
          xkb_variant dvorak
        }

        input querty {
          xkb_layout us
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
        #exec flatpak run com.viber.Viber
        exec whatsapp
        exec sh -c 'sleep 2 && echo "connect AC:67:84:2B:40:00" | bluetoothctl'

        # Disable touchpad
        #
        ## Thinkpad
        exec_always swaymsg input "Elan Touchpad" events disabled
        ## Legion
        exec_always swaymsg input "1267:12926:ELAN06FA:00_04F3:327E_Touchpad" events disabled

        # Make external display the primary monitor
        exec swaymsg output HDMI-A-1
        exec swaymsg output eDP-1 disable
      '';
    };

    programs.wofi = {
      enable = true;
      settings = {
        allow_markup = true;
        width = 650;
        show = "drun";
        prompt = "Apps";
        normal_window = true;
        layer = "top";
        height = "325px";
        orientation = "vertical";
        halign = "fill";
        line_wrap = "off";
        dynamic_lines = false;
        allow_images = true;
        image_size = 24;
        exec_search = false;
        hide_search = false;
        parse_search = false;
        insensitive = true;
        hide_scroll = true;
        no_actions = true;
        sort_order = "default";
        gtk_dark = true;
        filter_rate = 100;
        key_expand = "Tab";
        key_exit = "Escape";
      };
    };
  };
}
