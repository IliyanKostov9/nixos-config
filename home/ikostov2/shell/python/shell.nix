{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python311
    poetry
    python311Packages.virtualenv
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
    export LD_LIBRARY_PATH="${pkgs.zlib}/lib"
  '';
}).env
