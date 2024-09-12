{ nixpkgs, nixpkgs_unstable, nixgl, nixos-hardware, ... }:

rec {
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

  config_system = import ../config.nix {
    inherit nixos-hardware;
  };
  users = config_system.users;
}
