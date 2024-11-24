{ pkgs, pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.dev.langs.terraform;
in
{
  options.modules.dev.langs.terraform = { enable = mkEnableOption "terraform"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs_unstable.terraform
    ];
  };

}

