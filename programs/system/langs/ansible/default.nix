{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.ansible;
in
{
  options.modules.ansible = { enable = mkEnableOption "ansible"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ansible
    ];
  };

}

