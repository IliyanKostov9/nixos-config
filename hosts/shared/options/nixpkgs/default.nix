{ lib, stateVersion, ... }:
{
  # NixOS version
  system = lib.mkDefault {
    inherit stateVersion;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = lib.mkDefault true;
    allowBroken = lib.mkDefault true;
  };
}
