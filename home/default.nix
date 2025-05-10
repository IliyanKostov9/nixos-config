{
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
  };

  nixpkgs.config.allowUnfree = true;
  news.display = "silent";
  # NOTE: Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
