{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.sh.git;

  git-all = pkgs.writeShellApplication
    {
      name = "git-all";
      runtimeInputs = [ pkgs.git ];

      text = builtins.readFile ../../bin/bash/git/git-all.sh;
    };

in
{
  options.modules.sh.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    home.packages = [
      git-all
    ];
  };
}
