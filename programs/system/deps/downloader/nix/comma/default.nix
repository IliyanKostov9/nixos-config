{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.comma;
in
{
  options.modules.comma = { enable = mkEnableOption "comma"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.comma
    ];
  };

}

