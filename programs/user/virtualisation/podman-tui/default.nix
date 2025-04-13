{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.virtualisation.podman-tui;
in {
  options.modules.virtualisation.podman-tui = {enable = mkEnableOption "podman-tui";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.podman-tui
    ];
  };
}
