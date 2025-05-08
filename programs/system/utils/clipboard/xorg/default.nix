{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils.clipboard.xorg;
in {
  options.modules.utils.clipboard.xorg = {enable = mkEnableOption "xorg";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.xclip
    ];
  };
}
