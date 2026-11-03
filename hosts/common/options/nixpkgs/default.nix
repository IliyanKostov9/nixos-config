{
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = lib.mkDefault ["nix-command" "flakes" "pipe-operators"];
  };
  documentation = {
    nixos.enable = false;
    man.cache.enable = false;
  };
}
