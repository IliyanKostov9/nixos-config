{ inputs, ... }:

let
  shared = import ../../flakes/shared.nix
    { inherit (inputs) nixpkgs nixpkgs_unstable nixgl nixos-hardware; };
in
{
  packages.x86_64-linux = builtins.mapAttrs
    (host: host_attr:
      inputs.nixos-generators.nixosGenerate
        {
          system = "x86_64-linux";
          modules = host_attr.modules ++ [ inputs.nix-index-database.nixosModules.nix-index ];
          format = "iso";
          specialArgs = { inherit host_attr; inherit (shared) pkgs system stateVersion users; };
        }
    )
    shared.config_system.hosts;
}
