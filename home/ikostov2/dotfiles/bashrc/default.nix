{ pkgs
, ...
}:

let
  shared = import ../shared { inherit pkgs; };
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  home = {
    inherit (shared) shellAliases;
    inherit (shared) sessionVariables;
  };
}
