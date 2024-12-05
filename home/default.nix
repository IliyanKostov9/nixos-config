{ lib, stateVersion, user, ... }:
let
  username = user;
in
{
  imports = [
    ./${username}
    (lib.optional (builtins.pathExists ../secrets/user/${username})  ../secrets/user/${username})
  ];

  home = {
    homeDirectory = "/home/${username}";
    inherit username stateVersion;
  };

  nixpkgs.config.allowUnfree = true;
  # Disable annoying home news
  news.display = "silent";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
