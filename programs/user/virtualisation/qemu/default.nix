{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.qemu;
in
{
  options.modules.qemu = { enable = mkEnableOption "qemu"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.qemu
    ];
  };

}

