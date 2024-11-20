{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.ranger;
in
{
  options.modules.ranger = { enable = mkEnableOption "ranger"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.ranger
    ];

    programs.ranger = {
      enable = true;
      extraConfig = lib.fileContents ./rc.conf;
    };
  };
}
