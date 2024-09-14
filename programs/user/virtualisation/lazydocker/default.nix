{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lazydocker;
in
{
  options.modules.lazydocker = { enable = mkEnableOption "lazydocker"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.lazydocker
    ];
  };

}
