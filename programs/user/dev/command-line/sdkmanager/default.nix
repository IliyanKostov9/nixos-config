{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.command-line.sdkmanager;
in
{
  options.modules.dev.command-line.sdkmanager = { enable = mkEnableOption "sdkmanager"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.sdkmanager
    ];
  };

}
