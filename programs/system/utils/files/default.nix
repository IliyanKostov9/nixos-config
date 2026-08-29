{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils.files;
in {
  options.modules.utils.files = {enable = mkEnableOption "files";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tree
      zip
      unzip
      p7zip
    ];
  };
}
