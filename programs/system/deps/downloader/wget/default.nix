{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.wget;
in
{
  options.modules.wget = { enable = mkEnableOption "wget"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wget
    ];
  };

}

