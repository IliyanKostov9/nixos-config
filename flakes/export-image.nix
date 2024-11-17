{ inputs, ... }:

with inputs;
let
  shared = import ./shared.nix
    { inherit nixpkgs alacritty-theme nixpkgs_unstable nixgl nixos-hardware; };
in
rec {
  flake.packages.x86_64-linux = builtins.mapAttrs
    (host_name: host_attr:
      nixos-generators.nixosGenerate
        {
          system = "x86_64-linux";
          modules = host_attr.modules ++ [
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            lanzaboote.nixosModules.lanzaboote
          ];
          format = "iso";
          specialArgs = { inherit host_name host_attr; inherit (shared) pkgs system stateVersion users; };
        }
    )
    shared.config_system.hosts;

  flake.defaultPackage.x86_64-linux = builtins.head (builtins.attrValues flake.packages.x86_64-linux);
}
