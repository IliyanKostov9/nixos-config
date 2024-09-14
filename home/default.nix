{ lib, pkgs, stateVersion, user, ... }:
{
  imports = [
    ./${user}
  ];
  home = {
    homeDirectory = "/home/${user}";
    inherit user stateVersion;
  };

  nixpkgs.config.allowUnfree = true;
  # Disable annoying home news
  news.display = "silent";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

