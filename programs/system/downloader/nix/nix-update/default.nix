{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nix-update;
in
{
  options.modules.nix-update = { enable = mkEnableOption "nix-update"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nix-update
    ];
  };

}

