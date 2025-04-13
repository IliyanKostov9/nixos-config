{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop-settings.lenovo-legion;
in {
  options.modules.desktop-settings.lenovo-legion = {enable = mkEnableOption "lenovo-legion";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [lenovo-legion];
  };
}
