{ pkgs, lib, ... }:
with lib;
with lib.types;
{
  options.modules.preferences.fonts = {
    name = mkOption {
      type = str;
      default = "0xProto";
    };
  };

  config = {
    fonts.fontconfig.enable = true;
    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" "0xProto" ]; })
    ];
  };
}
