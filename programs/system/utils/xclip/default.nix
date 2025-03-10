{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils.xclip;
in {
  options.modules.utils.xclip = {enable = mkEnableOption "xclip";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.xclip
    ];
  };
}
