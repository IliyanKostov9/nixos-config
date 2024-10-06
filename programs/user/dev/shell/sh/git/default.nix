{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.sh.git;

  git-all = pkgs.writeShellApplication
    {
      name = "git-all";
      runtimeInputs = [ git ];

      text = ''
        #!${pkgs.bash}/bin/bash
        IFS=' '
        git_message="$*"

        git add .
        git commit -m "${git_message}"

        ( git push || git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD) )
      '';
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
