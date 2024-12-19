{ inputs, ... }:

let
  shared = import ./shared.nix
    { inherit inputs; };
in
rec {
  flake.packages.x86_64-linux = builtins.mapAttrs
    (host_name: host_attr:
      inputs.nixos-generators.nixosGenerate
        {
          system = "x86_64-linux";
          modules = host_attr.modules ++ (with inputs; [
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            lanzaboote.nixosModules.lanzaboote
          ]);
          format = "iso";
          specialArgs = { inherit host_name host_attr; inherit (shared) pkgs_unstable system stateVersion users; };
        }
    )
    shared.config_system.hosts;
}
