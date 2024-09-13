{ ... }:
{
  programs.chromium.enable = true;
  nixpkgs.config.chromium = {
    enableWideVine = true;
  };
}
