{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.jdk;
in
{
  options.modules.jdk = { enable = mkEnableOption "jdk"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.jdk19
    ];
  };

}


