{ pkgs, lib, config, user, ... }:
with lib;
with lib.types;
let
  cfg = config.modules.dev.shell.zsh;

  # ikostov-zsh-themes = builtins.fetchGit {
  #   url = "https://github.com/IliyanKostov9/zsh-themes";
  #   rev = "";
  # };
  ikostov-zsh-themes = pkgs.fetchFromGitHub {
    owner = "IliyanKostov9";
    repo = "zsh-themes";
    rev = "master";
    hash = "sha256-77w+8eEQOaXYCN/SZYaSH928bHox4DJS1Z00aD5xvHQ=";
  };

  zsh-themes = pkgs.stdenv.mkDerivation {
    name = "oh-my-custom-zsh-theme";
    phases = [ "buildPhase" ];
    buildPhase = ''
      mkdir -p $out/themes
      cp ${ikostov-zsh-themes}/themes/*.zsh-theme  $out/themes/
    '';
  };
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
          theme = "af-purple-magic";
          custom = "${zsh-themes}";
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
