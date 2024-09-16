{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dotnet;
in
{
  options.modules.dotnet = { enable = mkEnableOption "dotnet"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.dotnetCorePackages.sdk_8_0_1xx
    ];
  };

}

