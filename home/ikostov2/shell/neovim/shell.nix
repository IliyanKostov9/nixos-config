{ pkgs ? import <nixpkgs> { } }:
# A `Fix` for installing delve for neovim
pkgs.mkShell {
  buildInputs = [
    pkgs.go
    pkgs.gcc
    pkgs.glibc
    pkgs.binutils
  ];
}
