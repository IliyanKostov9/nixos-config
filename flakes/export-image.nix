{ inputs, ... }:

let
  shared = import ./shared.nix
    { inherit (inputs) nixpkgs nixpkgs_unstable nixgl nixos-hardware; };
in
rec {
  flake.packages.x86_64-linux = builtins.mapAttrs
    (_: host_attr:
      inputs.nixos-generators.nixosGenerate
        {
          system = "x86_64-linux";
          modules = host_attr.modules ++ [ inputs.nix-index-database.nixosModules.nix-index ];
          format = "iso";
          specialArgs = { inherit host_attr; inherit (shared) pkgs system stateVersion users; };
        }
    )
    shared.config_system.hosts;

  flake.defaultPackage.x86_64-linux = (builtins.head (builtins.attrValues flake.packages.x86_64-linux));
}
