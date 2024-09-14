{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.microsoft-edge;
in
{
  options.modules.microsoft-edge = { enable = mkEnableOption "microsoft-edge"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.microsoft-edge
    ];
  };

}
