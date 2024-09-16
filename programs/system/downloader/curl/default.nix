{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.curl;
in
{
  options.modules.curl = { enable = mkEnableOption "curl"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.curl
    ];
  };

}

