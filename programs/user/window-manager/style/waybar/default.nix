{config, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #333333;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;
      @define-color main #444444;
      @define-color white #e6e6e6;
      @define-color selection #44475a;

      * {
        font-family: FantasqueSansMono Nerd Font;
        font-size: 12px;
        min-height: 0;
      }

      #waybar {
        background: @main;
        color: @text;
        margin: 5px 5px;
      }

      #workspaces {
        border-radius: 1rem;
        margin: 5px;
        background-color: @surface0;
        margin-left: 1rem;
      }

      #workspaces button {
        color: @flamingo;
        border-radius: 1rem;
        padding: 0.4rem;
      }

      #workspaces button.active {
        background-image: linear-gradient(0deg, @flamingo, @selection);
      }

      #workspaces button:hover {
        color: @sapphire;
        border-radius: 1rem;
      }

      #custom-music,
      #tray,
      #backlight,
      #clock,
      #battery,
      #pulseaudio,
      #custom-lock,
      #custom-power {
        background-color: @surface0;
        padding: 0.5rem 1rem;
        margin: 5px 0;
      }

      #clock {
        color: @white;
        border-radius: 0px 1rem 1rem 0px;
        margin-right: 1rem;
      }

      #battery {
        color: @green;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #backlight {
        color: @yellow;
      }

      #backlight, #battery {
          border-radius: 0;
      }

      #pulseaudio {
        color: @maroon;
        border-radius: 1rem 0px 0px 1rem;
        margin-left: 1rem;
      }

      #custom-music {
        color: @mauve;
        border-radius: 1rem;
      }

      #custom-lock {
          border-radius: 1rem 0px 0px 1rem;
          color: @lavender;
      }

      #custom-power {
          margin-right: 1rem;
          border-radius: 0px 1rem 1rem 0px;
          color: @red;
      }

      #tray {
        margin-right: 1rem;
        border-radius: 1rem;
      }
    '';
    settings = {
      mainBar = {
        layer = "bottom";
        position = "bottom";
        modules-left = [
          "sway/workspaces"
        ];
        # modules-center = [
        #   "sway/window"
        # ];
        modules-right = [
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "tray"
          "clock#utc"
        ];
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [" " " " " " " " " " " " " " " " " "];
        };
        battery = {
          interval = 5;
          states = {
            good = 100;
            warning = 50;
            critical = 25;
          };
          format = "{icon} {capacity}% {power:2.1f}W";
          format-charging = " {capacity}% {power:2.1f}W";
          format-plugged = " {capacity}% {power:2.1f}W";
          format-alt = "{icon} {time}";
          format-icons = [" " " " " " " " " "];
        };
      };
    };
  };
}
