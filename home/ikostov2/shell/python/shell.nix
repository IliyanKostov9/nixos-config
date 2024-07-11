{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python311
    poetry
    zsh
    opencv4
    mesa
    libGL
    libGLU
    xorg.libX11
    glib
    glibc
    stdenv.cc.cc.lib
    libsForQt5.qt5.qtbase
    libsForQt5.qt5ct
  ]);
  runScript = "zsh";


  shellHook = ''
    export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms";
  '';
}).env
