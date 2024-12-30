{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lib.utils;
in
{
  options.modules.lib.utils = { enable = mkEnableOption "utils"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # patchelf
      # readline
      # tcl
      # libffi
      # libuuid
      # ncurses
    ];
  };
}
