{ pkgs, lib, ... }:
with lib;

let
  git-all = pkgs.writeShellApplication
    {
      name = "git-all";
      runtimeInputs = [ pkgs.git ];
      text = ''
        IFS=' '
        git_message="''$*"

        git add .
        git commit -m "''${git_message}"

        git push || git push --set-upstream origin "''$(git rev-parse --abbrev-ref HEAD)"
      '';
    };
  git-rm-local-brv = pkgs.writeShellApplication
    {
      name = "git-rm-local-brv";
      runtimeInputs = [ pkgs.git ];
      text = ''
        git fetch -p && \
          for branch in ''$(LC_ALL=C git branch -vv | grep ': gone]' | awk '{print $1}');
            do 
              git branch -D "''$branch"; 
            done
      '';
    };
  git-rob = pkgs.writeShellApplication
    {
      name = "git-rob";
      runtimeInputs = [ pkgs.git ];
      excludeShellChecks = [ "SC2153" ];
      text = builtins.readFile ../bin/bash/git/git-rob.sh;
    };
  git-history-rebase = pkgs.writeShellApplication
    {
      name = "git-history-rebase ";
      runtimeInputs = [ pkgs.git ];

      text = builtins.readFile ../bin/bash/git/git-history-rebase.sh;
    };
in
{
  home.packages = [
    git-rm-local-brv
    git-all
    git-rob
    git-history-rebase
  ];
}
