{
  pkgs,
  lib,
  stateVersion,
  user,
  ...
}: let
  username = user;
in {
  imports =
    (
      if builtins.pathExists ./${username}
      then [./${username}]
      else
        lib.warn
        "> User: ${username} DOESN'T have home directory under ./home! Defaulting to NONE... "
        []
    )
    ++ (
      if !lib.trivial.inPureEvalMode && builtins.pathExists ../secrets/user/${username}
      then [../secrets/user/${username}]
      else []
    );
  home = {
    homeDirectory = "/home/${username}";
    inherit username stateVersion;
    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
      name = "DMZ-Black";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };
  # NOTE: Text scaling
  xresources.properties = {
    "Xft.dpi" = "144";
  };

  nixpkgs.config.allowUnfree = true;
  news.display = "silent";
  # NOTE: Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
