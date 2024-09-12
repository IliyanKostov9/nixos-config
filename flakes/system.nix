{ inputs, ... }:

let
  shared = import ./shared.nix
    { inherit (inputs) nixpkgs nixpkgs_unstable nixgl nixos-hardware; };
in
{
  flake.nixosConfigurations = builtins.mapAttrs
    (_: host_attr:
      inputs.nixpkgs.lib.nixosSystem {
        modules = host_attr.modules ++ [ inputs.nix-index-database.nixosModules.nix-index ];
        specialArgs = { inherit host_attr; inherit (shared) pkgs system stateVersion users; };
      }
    )
    shared.config_system.hosts;
}
