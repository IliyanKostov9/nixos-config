{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python311
    pdm
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
    zlib
  ]);
  runScript = "zsh";


  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.zlib}/lib"
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath}:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH"
  '';
}).env
