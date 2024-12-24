{ pkgs, lib, config, user, ... }:
with lib;
with lib.types;
let cfg = config.modules.dev.shell.zsh;
in
{
  options.modules.dev.shell.zsh = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable zsh shell 
      '';
    };

    env-vars = mkOption {
      type = attrsOf str;
      default = { };
      description = mkDoc ''
        Additional env-vars
      '';
    };
  };

  config = mkIf cfg.enable (
    let
      common = pkgs.callPackage (../common) { inherit (cfg) env-vars; };
    in
    {
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
          theme = ./theme/af-magic.zsh-theme;
          plugins = [
            "gh"
            "direnv"
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

      programs = {
        direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
      };
    }
  );
}
