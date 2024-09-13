{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.sdkmanager;
in
{
  options.modules.sdkmanager = { enable = mkEnableOption "sdkmanager"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.sdkmanager
    ];
  };

}
