{ pkgs, lib, config, ... }:
with lib;

let
  git-all = pkgs.writeShellApplication
    {
      name = "git-all";
      runtimeInputs = [ pkgs.git ];

      text = builtins.readFile ../bin/bash/git/git-all.sh;
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
    git-all
    git-rob
    git-history-rebase
  ];
}
