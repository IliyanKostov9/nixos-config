{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python311
    pdm
    opencv4
    mesa
    libGL
    libGLU
    glib
    glibc
    zlib
    stdenv.cc.cc.lib
  ]);
  runScript = "zsh";

  LD_LIBRARY_PATH = "${pkgs.zlib}/lib:/run/opengl-driver/lib/:${pkgs.lib.makeLibraryPath}:${pkgs.stdenv.cc.cc.lib.outPath}/lib";
}).env
