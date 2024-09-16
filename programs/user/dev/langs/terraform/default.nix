{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.terraform;
in
{
  options.modules.terraform = { enable = mkEnableOption "terraform"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.terraform
    ];
  };

}

