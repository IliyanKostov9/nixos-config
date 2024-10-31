{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gnu;
in
{
  options.modules.gnu = { enable = mkEnableOption "gnu"; };

  config = mkIf cfg.enable {
    # NOTE: Should probabbly remove this part and move it to lib package
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

