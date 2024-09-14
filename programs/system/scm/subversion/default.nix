{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.subversion;
in
{
  options.modules.subversion = { enable = mkEnableOption "subversion"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.subversion
    ];
  };

}

