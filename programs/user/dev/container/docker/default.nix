{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.container.docker;
in
{
  options.modules.dev.container.docker = { enable = mkEnableOption "docker"; };

  config = mkIf cfg.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        docker
        docker-buildx
        docker-credential-helpers;
      # nerdctl
    };
  };
}

