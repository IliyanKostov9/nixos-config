{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.virtualisation.qemu;
in
{
  options.modules.virtualisation.qemu = { enable = mkEnableOption "qemu"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.qemu
    ];
  };

}

