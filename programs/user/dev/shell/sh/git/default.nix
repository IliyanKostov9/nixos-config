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
        git-magic -m "''$(printf '%s' "''$git_message")" -p
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
        jq
        (azure-cli.withExtensions [azure-cli.extensions.azure-devops])
      ];
      text = builtins.readFile ../bin/bash/git/gitlab-rob.sh;
    };

  git-rebase-v2 =
    pkgs.writeShellApplication
    {
      name = "git-rebase-v2";
      runtimeInputs = [pkgs.git];

      text = builtins.readFile ../bin/bash/git/git-rebase-v2.sh;
    };

  git-follow-remote =
    pkgs.writeShellApplication
    {
      name = "git-follow-remote";
      runtimeInputs = with pkgs; [git];
      text = ''
        current_branch="''$(git branch --show-current)"
        is_there_merge_conflict="''$(git status --porcelain | grep -q '^UU\|^AA\|^DD' && echo "true" || echo "false")"

        if [[ ''$is_there_merge_conflict == "true" ]]; then
          git merge --abort
        fi

        git reset --hard "origin/''$current_branch"
      '';
    };
in {
  home.packages = [
    git-rm-local-brv
    git-all
    git-rob
    gitlab-rob
    git-rebase-v2
    git-follow-remote
  ];
}
