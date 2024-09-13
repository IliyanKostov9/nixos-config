{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.android-studio;
in
{
  options.modules.android-studio = { enable = mkEnableOption "android-studio"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.android-studio
    ];
  };

}
