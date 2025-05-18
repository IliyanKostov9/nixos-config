{...}: {
  programs.waybar = {
    settings = {
      mainBar = {
        modules-right = [
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "tray"
          "clock#utc"
          "clock#local"
        ];
        "custom/ectool-fan" = {
          interval = 1;
          format = "󰈐 {}";
          exec = "cat /tmp/ectool-fan-rpm";
          tooltip = "Fan speed";
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [" " " " " " " " " " " " " " " " " "];
        };
        "battery" = {
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
