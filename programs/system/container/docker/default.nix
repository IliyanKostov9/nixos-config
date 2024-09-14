{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.docker;
in
{
  options.modules.docker = { enable = mkEnableOption "docker"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      docker
      docker-buildx
      docker-credential-helpers
      # nerdctl
    ];
  };

}

