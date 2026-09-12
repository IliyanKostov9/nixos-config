{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.entertainment.gaming;
in {
  options.modules.entertainment.gaming = {enable = mkEnableOption "gaming";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      steam
    ];

    programs.lutris = {
      enable = true;
      defaultWinePackage = pkgs.wineWow64Packages.stagingFull;
      winePackages = with pkgs; [wineWow64Packages.stagingFull];
      protonPackages = with pkgs; [proton-ge-bin];
    };
  };
}
