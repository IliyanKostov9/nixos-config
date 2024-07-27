{ pkgs
, config
, lib
, ...
}:

{
  programs.git = {
    enable = true;
    userName = "iliyan-kostov";
    userEmail = "iliyan.kostov@email.ikostov.org";
  };
}

