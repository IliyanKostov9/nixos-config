{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.git-extras;
in
{
  options.modules.git-extras = { enable = mkEnableOption "git-extras"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.git-extras
    ];
  };

}

