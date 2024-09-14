{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.sops;
in
{
  options.modules.sops = { enable = mkEnableOption "sops"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.sops
    ];
  };

}
