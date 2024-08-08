{ ... }:

{
  programs.git = {
    enable = true;
    userName = "iliyan-kostov";
    userEmail = "iliyan.kostov@email.ikostov.org";

    lfs.enable = false;

    extraConfig = {
      diff.colorMoved = "default";
      pull.rebase = false;
      init = {
        defaultBranch = "master";
      };
      core = {
        editor = "nvim";
      };
    };
  };

}

