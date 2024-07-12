{ pkgs
, config
, ...
}:

{
  # Should probabbly remove this part and move it to lib package
  environment.systemPackages = with pkgs; [
    glib
    gcc
    gnumake
    glibc
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
}
