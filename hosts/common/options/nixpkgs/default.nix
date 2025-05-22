{
  lib,
  stateVersion,
  ...
}: {
  system = lib.mkDefault {
    inherit stateVersion;
  };
  nix.settings.experimental-features = lib.mkDefault ["nix-command" "flakes" "pipe-operators"];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
