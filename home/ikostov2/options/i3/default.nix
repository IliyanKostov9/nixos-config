{ pkgs
, config
, lib
, ...
}:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      floating.modifier = "Mod4";
      fonts = {
        names = [ "0xProtoNerdFontMono-Regular" ];
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
        lib.mkOptionDefault {
          # Programs
          "${mod}+${ctrl}+l" = "exec ${pkgs.librewolf}/bin/librewolf -P";
          "${mod}+${ctrl}+c" = "exec ${pkgs.chromium}/bin/chromium";
          # "${mod}+${ctrl}+e" = "exec ${pkgs.microsoft-edge}/bin/microsoft-edge";

          "${mod}+${alt}+n" = "exec --no-startup-id nautilus ~/";
          "${alt}+f" = "exec flameshot gui";
          "${alt}+n" = "exec normcap";
          "${alt}+v" = "exec --no-startup-id gpaste-client ui";

          # Keyboard layout
          "${mod}+space" = "exec setxkbmap -layout us";
          "${mod}+b" = "exec setxkbmap -layout bg -variant phonetic";

          # PC
          "${mod}+${alt}+Page_Down" = "exec shutdown -h now";
          "${mod}+${alt}+End" = "exec reboot";
          "${mod}+${alt}+Delete" = "exec i3-msg exit";
          ## Audio
          "${mod}+${alt}+plus" = "exec --no-startup-id pamixer --increase 5";
          "${mod}+${alt}+minus" = "exec --no-startup-id pamixer --decrease 5";
          "${mod}+${alt}+m" = "exec --no-startup-id pamixer --toggle-mute";

          # Default i3 options
          "${mod}+Return" = "exec i3-sensible-terminal";
          "${mod}+${shift}+q" = "kill";
          "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
          "${mod}+${alt}+d" = "exec --no-startup-id xfce4-appfinder";

          # Mark
          "${mod}+m" = "exec i3-input -F 'mark %s' -l 1 -P 'Mark: '";
          # Jump
          "${mod}+g" = "exec i3-input -F '[con_mark = \"%s\"] focus' -l 1 -P 'Goto: '";

          # change focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          # alternatively, you can use the cursor keys:
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          # move focused window
          "${mod}+${shift}+h" = "move left";
          "${mod}+${shift}+j" = "move down";
          "${mod}+${shift}+k" = "move up";
          "${mod}+${shift}+l" = "move right";

          # alternatively, you can use the cursor keys:
          "${mod}+${shift}+Left" = "move left";
          "${mod}+${shift}+Down" = "move down";
          "${mod}+${shift}+Up" = "move up";
          "${mod}+${shift}+Right" = "move right";

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
        };
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
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

      exec --no-startup-id dex --autostart --environment i3
      exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
      exec --no-startup-id nm-applet
      exec --no-startup-id i3-msg "workspace 1"

      # Disable touchpad
      exec --no-startup-id xinput disable "Elan Touchpad"
      # Red-light
      exec --no-startup-id redshift-gtk

      tiling_drag modifier titlebar
    '';
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = [
          { block = "focused_window"; format = "$title.str(max_w:180)| "; }
          {
            block = "music";
            format = "{$icon $combo $play |}";
            separator = " – ";
          }
          {
            block = "net";
            format = "$icon {$signal_strength SSID @$frequency|Wired connection} via $device ";
            interval = 5;
          }
          {
            block = "battery";
            interval = 30;
            format = " $icon $percentage $time";
            missing_format = "";
          }
          {
            block = "backlight";
            format = " $icon $brightness |";
            invert_icons = true;
            device = "intel_backlight";
          }
          {
            block = "bluetooth";
            mac = "CC:98:8B:D1:40:88";
            format = {
              full = "$icon $percentage";
              short = "";
            };
            click = [
              {
                button = "left";
                cmd = "blueman-manager";
              }
            ];
          }
          {
            block = "sound";
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
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            click = [
              {
                button = "left";
                cmd = "gnome-calendar";
              }
            ];

          }
          {
            block = "keyboard_layout";
            driver = "sway";
            format = " ^icon_keyboard $layout ";
            mappings = {
              "English (US)" = "US";
              "Bulgarian (N/A)" = "BG";
            };
          }
        ];
        settings = {
          theme = {
            theme = "bad-wolf";
            # overrides = {
            # };
          };
        };
        icons = "material-nf";
      };
    };
  };
}
