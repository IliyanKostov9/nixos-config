{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nix-output-monitor;
in
{
  options.modules.nix-output-monitor = { enable = mkEnableOption "nix-output-monitor"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nix-output-monitor
    ];
  };

}

