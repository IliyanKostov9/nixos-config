{ self, inputs, ... }:

let
  shared = import ./shared.nix
    { inherit (inputs) nixpkgs nixpkgs_unstable nixgl nixos-hardware; };
in
{
  flake.homeConfigurations = builtins.mapAttrs
    (user: _user-attr: inputs.home-manager.lib.homeManagerConfiguration {
      inherit (shared) pkgs;
      extraSpecialArgs = { inherit self user; inherit (shared) system stateVersion pkgs_unstable; };
      modules = [
        ./home
      ] ++ [
        inputs.nix-index-database.hmModules.nix-index
      ];
    })
    shared.users;
}
