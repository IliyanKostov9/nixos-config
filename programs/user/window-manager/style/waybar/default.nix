{config, ...}: let
  font = "${config.modules.preferences.fonts.name}NerdFontMono-Regular";
  font-size = "13px";
  opacity = "0.85";
  text-color = "#ffffff";
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''

      * {
          border: none;
          border-radius: 4px;
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: Noto Sans, Roboto, Helvetica, Arial, sans-serif;
          font-size: 18px;
          min-height: 0;
      }

      window#waybar {
          background-color: rgba(43, 48, 59, 0.9);
          border-radius: 0;
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */

      window#waybar.termite {
          background-color: #3F3F3F;
      }

      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }

      #workspaces button {
          padding: 0 0.4em;
          border-radius: 0;
          background-color: transparent;
          color: #ffffff;
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #mode {
          background-color: #64727D;
          border-bottom: 3px solid #ffffff;
      }

      #clock,
      #custom-clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd {
          padding: 0 10px;
          margin: 6px 3px;
          color: #bfbfbf;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock, #custom-clock {
          background-color: #2d5986;
      }

      #battery {
          background-color: #ffffff;
          color: #000000;
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #000000;
      }

      #cpu {
          background-color: #2ecc71;
          color: #000000;
      }

      #memory {
          background-color: #9b59b6;
      }

      #disk {
          background-color: #964B00;
      }

      #backlight {
          background-color: #90b1b1;
      }

      #network {
          background-color: #2d5986;
      }

      #network.disconnected {
          background-color: #2d5986;
      }

      #pulseaudio {
          background-color: #2d5986;
      }

      #pulseaudio.muted {
          background-color: #2d5986;
          color: #2a5c45;
      }

      #custom-media {
          background-color: #66cc99;
          color: #2a5c45;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          background-color: #66cc99;
      }

      #custom-media.custom-vlc {
          background-color: #ffa000;
      }

      #temperature {
          background-color: #f0932b;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: #2980b9;
      }

      #idle_inhibitor {
          background-color: #2d3436;
      }

      #idle_inhibitor.activated {
          background-color: #ecf0f1;
          color: #2d3436;
      }

      #mpd {
          background-color: #2d5986;
          color: #2a5c45;
      }

      #mpd.disconnected {
          background-color: #2d5986;
      }

      #mpd.stopped {
          background-color: #2d5986;
      }

      #mpd.paused {
          background-color: #2d5986;
      }

      #language {
          background: #2d5986;
          color: #bfbfbf;
          padding: 0 5px;
          margin: 6px 3px;
          min-width: 16px;
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
