{ config, inputs, pkgs, system, stateVersion, ... }:

let

  imports = [
    ./shared.nix
  ];
in
{
  flake.nixosConfigurations = builtins.mapAttrs
    (host: host_attr:
      inputs.nixpkgs.lib.nixosSystem {
        modules = host_attr.modules ++ [ inputs.nix-index-database.nixosModules.nix-index ];
        specialArgs = { inherit pkgs system stateVersion host_attr users; };
        # };
      }
    )
    config_system.hosts;
  # };
}
