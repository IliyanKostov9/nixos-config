{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.sh.alias;

  lst = pkgs.writeShellApplication
    {
      name = "lst";
      text = builtins.readFile ../../bin/bash/eza/tree-icons.sh;
    };
  etcher-bin = pkgs.writeShellApplication
    {
      name = "etcher";
      text = builtins.readFile ../../../../disk-image/etcher/result/bin/etcher;
    };
  fzf-file-search = pkgs.writeShellApplication {
    name = "fzf-file-search";
    runtimeInputs = [ pkgs.fzf pkgs.bat pkgs.tree ];

    text = ''
      selection=$(find . -type f -o -type d | fzf --cycle --border=thinblock --border-label='| Search here |' --preview 'bat --color=always --style=numbers --theme=base16-256 --line-range=:500 {} || tree -C {}' --preview-label='Preview')

      if [ -d "$selection" ]; then
        realpath "$selection"
      else
         realpath "$(dirname "$selection")"
      fi
    '';
  };
in
{
  options.modules.sh.alias = { enable = mkEnableOption "alias"; };

  config = mkIf cfg.enable {
    home.packages = [
      lst
      # (if config.modules.etcher then etcher-bin else { })
      fzf-file-search
    ];
  };
}
