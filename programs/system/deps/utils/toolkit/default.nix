{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
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
