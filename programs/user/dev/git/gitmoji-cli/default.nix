{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gitmoji-cli;
in
{
  options.modules.gitmoji-cli = { enable = mkEnableOption "gitmoji-cli"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gitmoji-cli
    ];
  };

}
