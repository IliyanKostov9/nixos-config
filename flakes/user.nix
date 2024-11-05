{ self, inputs, ... }:

with inputs;
let
  shared = import ./shared.nix
    {
      inherit nixpkgs alacritty-theme nixpkgs_unstable nixgl nixos-hardware;
    };
in
{
  flake.homeConfigurations = builtins.mapAttrs
    (user: _user-attr: home-manager.lib.homeManagerConfiguration {
      inherit (shared) pkgs;
      extraSpecialArgs = { inherit self user; inherit (shared) system stateVersion pkgs_unstable; };
      modules = [
        ../home
      ] ++ [
        nix-index-database.hmModules.nix-index
        sops-nix.homeManagerModules.sops
      ];
    })
    shared.users;
}
