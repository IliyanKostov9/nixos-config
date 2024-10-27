{ pkgs, lib, config, user, ... }:
with lib;
with lib.types;

let cfg = config.modules.fonts;
in
{
  options.modules.fonts = {
    name = mkOption {
      type = str;
      default = "0xProto";
    };
  };

  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "0xProto" ]; })
  ];
}
