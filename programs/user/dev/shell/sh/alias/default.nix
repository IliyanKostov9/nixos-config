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

  passbolt-get-password = pkgs.writeShellApplication {
    name = "passbolt-get-password";
    runtimeInputs = with pkgs_unstable; [ go-passbolt-cli ];
    excludeShellChecks = [ ];

    text = ''
      password_uuid=$(passbolt list resource -c "id" -c "name" | fzf --cycle --border=thinblock --border-label='| Get password secret |' | awk '{print $1;}')
      password_entry=$(passbolt get resource --id "$password_uuid")
      name=$(echo "''$password_entry" | head -n 2 | tail -n 1 | awk '{print $2;}')
      username=$(echo "''$password_entry" | head -n 3 | tail -n 1 | awk '{print $2;}')
      password=$(echo "''$password_entry" | head -n 5 | tail -n 1 | awk '{print $2;}')

      result=$(echo -e "''${username}\n''${password}" | fzf --cycle --border=thinblock --border-label="| ''$name |")

      echo "$result"
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
