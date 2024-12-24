{ pkgs, pkgs_unstable, lib, config, ... }:
with lib;
with config.modules.dev.shell;
let
  lst = pkgs.writeShellApplication
    {
      name = "lst";
      runtimeInputs = [ pkgs.eza ];
      text = ''
        eza --header --icons --tree --level="''${1:-1}"
      '';
    };

  fzf-search = pkgs.writeShellApplication {
    name = "fzf-search";
    runtimeInputs = with pkgs; [ fzf bat tree ];
    excludeShellChecks = [ "SC2005" ];

    text = ''
      selection=$(find . -type f -o -type d | fzf --cycle --border=thinblock --border-label='| Search here |' --preview 'bat --color=always --style=numbers --theme=base16-256 --line-range=:500 {} || tree -C {}' --preview-label='Preview');

      if [ -d "$selection" ]; then
        echo "$selection" 
      else
         echo "$(dirname "$selection")"
      fi
    '';
  };
in
{
  home.packages = lib.optionals (zsh.enable || bash.enable) [
    lst
    fzf-search
    # passbolt-get-password
  ];
}
