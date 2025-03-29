{
  pkgs,
  lib,
  ...
}:
with lib; let
  git-all =
    pkgs.writeShellApplication
    {
      name = "git-all";
      runtimeInputs = with pkgs; [git git-extras];
      text = ''
        git_message="$*"

        git add .
        git-magic -m "''${git_message}" -p
      '';
    };

  git-rm-local-brv =
    pkgs.writeShellApplication
    {
      name = "git-rm-local-brv";
      runtimeInputs = [pkgs.git];
      text = ''
        git fetch -p && \
          for branch in ''$(LC_ALL=C git branch -vv | grep ': gone]' | awk '{print $1}');
            do
              git branch -D "''$branch";
            done
      '';
    };

  git-rob =
    pkgs.writeShellApplication
    {
      name = "git-rob";
      runtimeInputs = with pkgs; [
        git
        gh
        (azure-cli.withExtensions [azure-cli.extensions.azure-devops])
      ];
      excludeShellChecks = ["SC2153"];
      text = builtins.readFile ../bin/bash/git/git-rob.sh;
    };

  gitlab-rob =
    pkgs.writeShellApplication
    {
      name = "gitlab-rob";
      runtimeInputs = with pkgs; [
        git
        glab
        (azure-cli.withExtensions [azure-cli.extensions.azure-devops])
      ];
      excludeShellChecks = ["SC2153"];
      text = builtins.readFile ../bin/bash/git/gitlab-rob.sh;
    };

  git-history-rebase =
    pkgs.writeShellApplication
    {
      name = "git-history-rebase";
      runtimeInputs = [pkgs.git];

      text = builtins.readFile ../bin/bash/git/git-history-rebase.sh;
    };
in {
  home.packages = [
    git-rm-local-brv
    git-all
    git-rob
    gitlab-rob
    git-history-rebase
  ];
}
