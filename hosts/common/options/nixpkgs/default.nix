{
  lib,
  stateVersion,
  ...
}: {
  system = lib.mkDefault {
    inherit stateVersion;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = lib.mkDefault ["nix-command" "flakes" "pipe-operators"];
  documentation.nixos.enable = false;
}
