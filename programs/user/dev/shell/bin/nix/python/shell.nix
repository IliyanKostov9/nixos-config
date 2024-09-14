{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python311
    opencv4
    mesa
    libGL
    libGLU
    glib
    glibc
    stdenv.cc.cc.lib
    zlib
    # libsForQt5.qt5.qtbase
    # libsForQt5.qt5ct
  ]);
  runScript = "zsh";

  LD_LIBRARY_PATH = "${pkgs.zlib}/lib:/run/opengl-driver/lib/:${pkgs.lib.makeLibraryPath}:${pkgs.stdenv.cc.cc.lib.outPath}/lib";
  # QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms";
  #
}).env
