{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.zsh;
in
{
  options.modules.zsh = { enable = mkEnableOption "zsh"; };

  config = mkIf cfg.enable (
    let
      common = import ../common.nix { inherit pkgs; };
    in
    {
      home.packages = [
        pkgs.zsh
      ];

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = false;
        autocd = true;
        history = {
          size = 10000;
          path = "${config.xdg.dataHome}/zsh/history";
        };
        oh-my-zsh = {
          enable = true;
          theme = "af-magic";
          # af-magic
          # wezm
          # norm
          # muse
          # macovsky
          # lambda
          # kolo ?
          # jnrowe
          plugins = [
            "gh"
          ];
        };
        inherit (common) shellAliases;
        inherit (common) sessionVariables;
        initExtra = ''
          bindkey "''${key[Up]}" up-line-or-search
          bindkey -v
          bindkey -M menuselect 'h' vi-backward-char
          bindkey -M menuselect 'k' vi-up-line-or-history
          bindkey -M menuselect 'l' vi-forward-char
          bindkey -M menuselect 'j' vi-down-line-or-history
          bindkey "^A" vi-beginning-of-line
          bindkey "^E" vi-end-of-line
        '';
      };
    }
  );
}