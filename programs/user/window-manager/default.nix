{
  pkgs,
  config,
  ...
}: let
  terminal = config.modules.dev.emulator.default;
in {
  imports = [
    ./i3wm
    ./qtile
  ];

  # Select theme:  "rofi-theme-selector";
  programs.rofi = {
    enable = true;
    theme = "dmenu";
    # android_notification
    font = "${config.modules.preferences.fonts.name}NerdFontMono-Regular";
    location = "center";
    terminal = "${pkgs.${terminal}}/bin/${terminal}";
    extraConfig = {
      show-icons = false;
      modi = "drun,run";
    };
  };
}
