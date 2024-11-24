{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.langs.jdk;
in
{
  options.modules.dev.langs.jdk = { enable = mkEnableOption "jdk"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.jdk
    ];
  };

}


