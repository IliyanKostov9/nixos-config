{ inputs, ... }:
let
  shared = import ./shared.nix
    {
      inherit inputs;
    };
in
{
  flake.checks."x86_64-linux" = {
    users = import ./user {
      inherit (inputs) home-manager;
      inherit shared;
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    };
  };
}
