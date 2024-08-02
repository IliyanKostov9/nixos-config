{ pkgs
, config
, ...
}:

let
  shared = import ../shared;
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  home = {
    shellAliases = shared.shellAliases;
    sessionVariables = shared.sessionVariables;
  };
}
