{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.command-line.ranger;
in
{
  options.modules.dev.command-line.ranger = { enable = mkEnableOption "ranger"; };

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
