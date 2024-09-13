{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gh;
in
{
  options.modules.gh = { enable = mkEnableOption "gh"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gh
    ];
  };

}
