{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.scm.subversion;
in
{
  options.modules.scm.subversion = { enable = mkEnableOption "subversion"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.subversion
    ];
  };
}
