{ self, inputs, pkgs, nixpkgs, nixgl, nixpkgs_unstable, ... }:
# {
# perSystem =
#   { config
#   , pkgs
#   , system
#   , lib
#   , ...
#   }:
let
  # packages = {
  #   nix-index = config.packages.nix-index-database.nixosModules.nix-index;
  # };

  system = "x86_64-linux";
  stateVersion = "24.05";

  pkgs = import nixpkgs {
    inherit system;
    overlays = [ (nixgl.overlay) ];
    config = { allowUnfree = true; };
  };
  pkgs_unstable = import nixpkgs_unstable {
    inherit system;
  };

  lib = pkgs.lib;

  config_system = import ../config.nix {
    inherit (inputs) nixos-hardware;
  };
  users = config_system.users;
in
{
  flake.nixosConfigurations = builtins.mapAttrs
    (host: host_attr:
      inputs.nixpkgs.lib.nixosSystem {
        # inherit (config) system;
        # system = config.getSystem;
        modules = host_attr.modules ++ [ inputs.nix-index-database.nixosModules.nix-index ];
        specialArgs = { inherit system stateVersion host_attr users; };
      }
    )
    config_system.hosts;
  # };
}
