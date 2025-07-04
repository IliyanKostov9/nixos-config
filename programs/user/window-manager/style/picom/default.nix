_: {
  # pkill picom && picom -b
  services.picom = {
    enable = true;
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
      use-damage = false;
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

        "0:_NET_WM_STATE *= '_NET_WM_STATE_HIDDEN'"
        "100:_GTK_FRAME_EXTENTS"
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

      # NOTE: Rounded corners
      # corner-radius = 15.0;
      shadow = true;
      shadow-radius = 9.0;
      shadow-offset-x = -9.0;
      shadow-offset-y = -9.0;
      shadow-opacity = 0.8;
      clip-shadow-above = true;
      shadow-red = 0.0;
      shadow-green = 0.3;
      shadow-blue = 0.35;
    };
  };
}
