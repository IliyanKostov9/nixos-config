{
  lib,
  stateVersion,
  ...
}: {
  system = lib.mkDefault {
    inherit stateVersion;
  };
  nix.settings.experimental-features = lib.mkDefault ["nix-command" "flakes" "pipe-operators"];
  documentation.nixos.enable = false;

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
