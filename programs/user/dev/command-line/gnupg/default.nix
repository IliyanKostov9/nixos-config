{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gnupg;
in
{
  options.modules.gnupg = { enable = mkEnableOption "gnupg"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gnupg
      pkgs.pinentry-qt
    ];
  };

}
