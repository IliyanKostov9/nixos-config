{ pkgs ? (import ../nixpkgs.nix) { } }: {
  discord = pkgs.callPackage ./discord { };
}
