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
      keybindings =
        let
          mod = config.xsession.windowManager.i3.config.modifier;
        in
        lib.mkOptionDefault {
          "${mod}+Return" = "exec i3-sensible-terminal";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";

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
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # alternatively, you can use the cursor keys:
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

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
          "${mod}+Shift+space" = "floating toggle";
          # change focus between tiling / floating windows
          "${mod}+space" = "focus mode_toggle";
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
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          # reload the configuration file
          "${mod}+Shift+c" = "reload";
          # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
          "${mod}+Shift+r" = "restart";
          # exit i3 (logs you out of your X session)
          "${mod}+Shift+e" = "exec 'i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";

          #
          # # resize window (you can also use the mouse for that)
          # mode "resize" {
          # # These bindings trigger as soon as you enter the resize mode
          #
          # # Pressing left will shrink the window’s width.
          # # Pressing right will grow the window’s width.
          # # Pressing up will shrink the window’s height.
          # # Pressing down will grow the window’s height.
          # bindsym h resize shrink width 10 px or 10 ppt
          # bindsym j resize grow height 10 px or 10 ppt
          # bindsym k resize shrink height 10 px or 10 ppt
          # bindsym l resize grow width 10 px or 10 ppt
          #
          # # same bindings, but for the arrow keys
          # bindsym Left resize shrink width 10 px or 10 ppt
          # bindsym Down resize grow height 10 px or 10 ppt
          # bindsym Up resize shrink height 10 px or 10 ppt
          # bindsym Right resize grow width 10 px or 10 ppt
          #
          # # back to normal: Enter or Escape or $mod+r
          # bindsym Return mode "default"
          # bindsym Escape mode "default"
          # bindsym $mod+r mode "default"
          # }
          #
          "${mod}+r" = "resize";
        };
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        }
      ];
    };
    extraConfig = ''
      exec --no-startup-id dex --autostart --environment i3
      exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
      exec --no-startup-id nm-applet

      tiling_drag modifier titlebar
    '';
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = [
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            format_mem = " $icon $mem_used_percents ";
            format_swap = " $icon $swap_used_percents ";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            interval = 1;
            format = " $icon $1m ";
          }
          { block = "sound"; }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
        ];
        settings = {
          theme = {
            theme = "solarized-dark";
            overrides = {
              idle_bg = "#123456";
              idle_fg = "#abcdef";
            };
          };
        };
        icons = "awesome5";
        theme = "gruvbox-dark";
      };
    };
  };
}
