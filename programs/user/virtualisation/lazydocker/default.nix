{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.virtualisation.lazydocker;
in
{
  options.modules.virtualisation.lazydocker = { enable = mkEnableOption "lazydocker"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.lazydocker
    ];
  };

}
