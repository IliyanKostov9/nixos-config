{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lazy-docker;
in
{
  options.modules.lazy-docker = { enable = mkEnableOption "lazy-docker"; };

  config = mkIf cfg.enable {
    home.packages = [
      lazydocker
    ];
  };

}
