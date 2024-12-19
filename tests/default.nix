{ inputs, lib, ... }:
let
  shared = import ../flakes/shared.nix
    {
      inherit inputs;
    };
in
{
  flake.checks."x86_64-linux" = {
    users = import ./user {
      inherit (inputs) home-manager;
      inherit shared lib;
    };
  };
}
