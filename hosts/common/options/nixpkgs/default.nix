{
  lib,
  stateVersion,
  pkgs,
  ...
}: {
  system = lib.mkDefault {
    inherit stateVersion;
  };
  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = lib.mkDefault ["nix-command" "flakes" "pipe-operators"];
  };
  documentation.nixos.enable = false;
}
