{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.xclip;
in
{
  options.modules.xclip = { enable = mkEnableOption "xclip"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.xclip
    ];
  };

}

