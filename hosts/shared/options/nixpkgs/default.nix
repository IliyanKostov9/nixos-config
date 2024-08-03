{ lib, stateVersion, ... }:
{
  # NixOS version
  system = lib.mkDefault {
    inherit stateVersion;
  };
  nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = lib.mkDefault true;
}
