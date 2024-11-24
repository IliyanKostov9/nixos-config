{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.command-line.sops;
in
{
  options.modules.dev.command-line.sops = { enable = mkEnableOption "sops"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.sops
    ];
  };

}
