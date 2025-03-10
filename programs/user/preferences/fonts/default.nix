{
  pkgs,
  lib,
  ...
}:
with lib;
with lib.types; {
  options.modules.preferences.fonts = {
    name = mkOption {
      type = str;
      default = "0xProto";
      description = lib.mkDoc ''
        Nerd font for the terminal and apps
      '';
    };
  };

  config = {
    fonts.fontconfig.enable = true;
    home.packages = [
      (pkgs.nerdfonts.override {fonts = ["FiraCode" "0xProto"];})
    ];
  };
}
