{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.podman-tui;
in
{
  options.modules.podman-tui = { enable = mkEnableOption "podman-tui"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.podman-tui
    ];
  };

}
