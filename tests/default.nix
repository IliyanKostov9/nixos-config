{ inputs, ... }: {
  flake.checks."x86_64-linux" = {
    users = import ./user {
      inherit (inputs) home-manager;
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    };
  };
}
