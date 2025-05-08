{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils.clipboard.wayland;
in {
  options.modules.utils.clipboard.wayland = {enable = mkEnableOption "wayland";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wl-clipboard
    ];
  };
}
