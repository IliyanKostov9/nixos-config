{config, ...}: let
  cfg = config.modules.window-manager;
  keyboard-driver =
    if cfg.sway.enable == true
    then "sway"
    else "setxkbmap";
in {
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = let
          uptime = {
            block = "uptime";
            interval = 3600;
          };
          toggle = {
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
          };

          net = {
            block = "net";
            format = "$icon {$signal_strength ssid @$frequency|wired} via $device ";
            interval = 5;
            missing_format = " x ";
            inactive_format = " $icon ";
          };

          external-ip = {
            block = "external_ip";
            format = "$country_flag ";
            with_network_manager = true;
            interval = 300;
            use_ipv4 = true;
          };
          battery = {
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
          };

          backlight = {
            block = "backlight";
            format = " $icon $brightness |";
            invert_icons = true;
            # NOTE: for amd cpu this option is not required!
            # device = "intel_backlight";
            missing_format = "";
          };

          keyboard-layout = {
            block = "keyboard_layout";
            driver = keyboard-driver;
            interval = 1;
            format = " ^icon_keyboard $layout ";
          };
          sound = {
            block = "sound";
            show_volume_when_muted = true;
            headphones_indicator = true;
            click = [
              {
                button = "left";
                cmd = "pwvucontrol";
              }
            ];
          };
          time = {
            block = "time";
            interval = 60;
            format = " $icon $timestamp.datetime(f:'%a %d/%m %R') ";
            click = [
              {
                button = "left";
                cmd = "gnome-calendar";
              }
            ];
          };
        in [
          uptime
          toggle
          net
          external-ip
          battery
          backlight
          keyboard-layout
          sound
          time
        ];
        settings = {
          theme = {
            theme = "bad-wolf";
            overrides = {separator = "";};
          };
        };
        icons = "material-nf";
      };
    };
  };
}
