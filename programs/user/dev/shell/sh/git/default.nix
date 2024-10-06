{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.sh.git;

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

      text = builtins.readFile ../bin/bash/git/git-rob.sh;
    };
  git-history-rebase = pkgs.writeShellApplication
    {
      name = "git-history-rebase ";
      runtimeInputs = [ pkgs.git ];

      text = builtins.readFile ../bin/bash/git/git-rebase.sh;
    };

in
{
  options.modules.sh.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    home.packages = [
      git-all
      git-rob
      git-history-rebase
    ];
  };
}
