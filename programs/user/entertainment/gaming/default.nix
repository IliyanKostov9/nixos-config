{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.entertainment.gaming;
in
{
  options.modules.entertainment.gaming = { enable = mkEnableOption "gaming"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      steam
      lutris
    ];
  };
}
