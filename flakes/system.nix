{ inputs, ... }:

with inputs;
let
  shared = import ./shared.nix
    { inherit nixpkgs alacritty-theme nixpkgs_unstable nixgl nixos-hardware; };
in
{
  flake.nixosConfigurations = builtins.mapAttrs
    (_: host_attr:
      nixpkgs.lib.nixosSystem {
        modules = host_attr.modules ++ [
          nix-index-database.nixosModules.nix-index
          sops-nix.nixosModules.sops
          lanzaboote.nixosModules.lanzaboote
        ];
        specialArgs = { inherit host_attr; inherit (shared) pkgs system stateVersion users; };
      }
    )
    shared.config_system.hosts;
}
