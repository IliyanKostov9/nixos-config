{ lib, config, pkgs, stateVersion, user, ... }:
let
  username = user;
  user-programs = import ../programs/user/utils.nix { inherit pkgs lib; };
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../programs/user/${username}.nix
    ./${username}/dotfiles
    ./${username}/themes
    ./${username}/options
  ];
  home = {
    homeDirectory = "/home/${username}";
    inherit username stateVersion;
  };

  home.packages = user-programs.all-programs;

  # Disable annoying home news
  news.display = "silent";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

