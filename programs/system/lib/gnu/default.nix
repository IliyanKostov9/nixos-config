{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lib.gnu;
in
{
  options.modules.lib.gnu = { enable = mkEnableOption "gnu"; };

  config = mkIf cfg.enable {
    # NOTE: Should probabbly remove this part
    environment.systemPackages = with pkgs; [
      gnupg
      pinentry-qt
      groff
      gnutar
      gcc
      cmake
      gnumake
      glibc
      gdb
      libgccjit
      patchelf
      readline
      tcl
      tk
      libffi
      patch
      libuuid
      binutils
      ncurses
    ];
  };
}
