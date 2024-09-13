{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.librewolf;
in
{
  options.modules.librewolf = { enable = mkEnableOption "librewolf"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.librewolf
    ];
  };

}
