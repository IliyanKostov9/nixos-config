{ pkgs ? import <nixpkgs> {} }:

pkgs.buildFHSUserEnv {
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
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXinerama
    glib
    glibc
    stdenv.cc.cc.lib
    dbus
    atk
    cairo
    cups
    expat
    fontconfig
    freetype
    gdk-pixbuf
    gtk3
    libjpeg
    libpng
    pango
    qtbase
    qtx11extras
  ]);
  runScript = "zsh";
}

