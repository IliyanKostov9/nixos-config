{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.langs.dotnet;
in
{
  options.modules.dev.langs.dotnet = { enable = mkEnableOption "dotnet"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.dotnetCorePackages.sdk_8_0_1xx
    ];
  };

}

