{ pkgs, lib, config, ... }:
with lib;
let
  lst = pkgs.writeShellApplication
    {
      name = "lst";
      text = builtins.readFile ../bin/bash/eza/tree-icons.sh;
    };

  # fzf-file-search = pkgs.writeShellApplication {
  #   name = "fzf-file-search";
  #   runtimeInputs = [ pkgs.fzf pkgs.bat pkgs.tree ];
  #
  #   text = ''
  #     selection=$(find . -type f -o -type d | fzf --cycle --border=thinblock --border-label='| Search here |' --preview 'bat --color=always --style=numbers --theme=base16-256 --line-range=:500 {} || tree -C {}' --preview-label='Preview')
  #
  #     if [ -d "$selection" ]; then
  #       "$selection" 
  #     else
  #        "$(dirname "$selection")"
  #     fi
  #   '';
  # };
in
{
  home.packages = lib.optionals (config.modules.zsh.enable || config.modules.bash.enable) [
    lst
    # fzf-file-search
  ];
}
