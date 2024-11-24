{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.build-tools.maven;
in
{
  options.modules.dev.build-tools.maven = { enable = mkEnableOption "maven"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.maven
    ];
  };

}

