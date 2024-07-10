{ pkgs ? import <nixpkgs> {} }:

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
  ]);
  runScript = "zsh";
}).env
