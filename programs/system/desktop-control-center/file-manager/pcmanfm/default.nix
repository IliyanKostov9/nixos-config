{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.pcmanfm;
in
{
  options.modules.pcmanfm = { enable = mkEnableOption "pcmanfm"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pcmanfm ];
  };
}

