{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.files;
in {
  options.modules.files = {enable = mkEnableOption "files";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tree
      zip
      unzip
      p7zip
    ];
  };
}
