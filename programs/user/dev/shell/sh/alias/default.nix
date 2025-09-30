{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  ...
}:
with lib;
with config.modules.dev.shell; let
  fzf-search = pkgs.writeShellApplication {
    name = "fzf-search";
    runtimeInputs = with pkgs; [fzf bat tree];
    excludeShellChecks = ["SC2005"];

    text = ''
      selection=$(find . -type f -o -type d | fzf --cycle --border=thinblock --border-label='| Search here |' --preview 'bat --line-range=:500 {} || tree -C {}' --preview-label='Preview');

      if [ -d "$selection" ]; then
        echo "$selection"
      else
         echo "$(dirname "$selection")"
      fi
    '';
  };

  youtube-download = pkgs.writeShellApplication {
    name = "youtube-download";
    runtimeInputs = with pkgs; [yt-dlp];
    text = ''
      link=$1

      if [ -z "$link" ]; then
        echo "You need to add a youtube link!"
      elif [[ ! "$link" =~ ^https://youtu.be/.* ]]; then
        echo "Youtube link needs to start with https://youtu.be/"
      else
        yt-dlp -x --audio-format mp3 --cookies-from-browser chromium --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/140.0.7339.185 Safari/537.36" -o "$HOME/Downloads/%(title)s.%(ext)s" "$link"
      fi
    '';
  };
  # passbolt-get-password = pkgs.writeShellApplication {
  #   name = "passbolt-get-password";
  #   runtimeInputs = with pkgs-unstable; [ go-passbolt-cli ];
  #   excludeShellChecks = [ ];
  #
  #   text = ''
  #     password_uuid=$(passbolt list resource -c "id" -c "name" | fzf --cycle --border=thinblock --border-label='| Get password secret |' | awk '{print $1;}')
  #     password_entry=$(passbolt get resource --id "$password_uuid")
  #     name=$(echo "''$password_entry" | head -n 2 | tail -n 1 | awk '{print $2;}')
  #     username=$(echo "''$password_entry" | head -n 3 | tail -n 1 | awk '{print $2;}')
  #     password=$(echo "''$password_entry" | head -n 5 | tail -n 1 | awk '{print $2;}')
  #
  #     result=$(echo -e "''${username}\n''${password}" | fzf --cycle --border=thinblock --border-label="| ''$name |")
  #
  #     echo "$result"
  #   '';
  # };
in {
  home.packages = lib.optionals (zsh.enable || bash.enable) [
    fzf-search
    youtube-download
    # passbolt-get-password
  ];
}
