{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.vim;
in
{
  options.modules.vim = { enable = mkEnableOption "vim"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.vim
      pkgs.sqlite
    ];
  };

}

