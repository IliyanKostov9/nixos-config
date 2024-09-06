{ pkgs
, config
, ...
}:

{
  # Should probabbly remove this part and move it to lib package
  environment.systemPackages = with pkgs; [
    gnutar
    gcc
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
    vulkan-tools
  ];
}
