{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.dev.shell.zsh;

  # ikostov-zsh-themes = builtins.fetchGit {
  #   url = "https://codeberg.org/iliyan-kostov/zsh-themes.git";
  #   rev = "939914434ce2aeb66a544840026beb0b5edbe2fb";
  # };

  ikostov-zsh-themes = pkgs.fetchFromGitHub {
    owner = "IliyanKostov9";
    repo = "zsh-themes";
    rev = "master";
    hash = "sha256-77w+8eEQOaXYCN/SZYaSH928bHox4DJS1Z00aD5xvHQ=";
  };

  zsh-themes = pkgs.stdenv.mkDerivation {
    name = "oh-my-custom-zsh-theme";
    phases = ["buildPhase"];
    buildPhase = ''
      mkdir -p $out/themes
      cp ${ikostov-zsh-themes}/themes/*.zsh-theme  $out/themes/
    '';
  };
in {
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
      default = {};
      description = mkDoc ''
        Additional env-vars
      '';
    };
  };

  config = mkIf cfg.enable (
    let
      common = pkgs.callPackage ../common {
        inherit (cfg) env-vars;
      };
    in {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = false;
        autocd = true;
        cdpath = [
          ''
            ~/Downloads
          ''
        ];
        history = {
          size = 10000;
          path = "${config.xdg.dataHome}/zsh/history";
        };
        # plugins = [
        #   {
        #     name = "vi-mode";
        #     src = pkgs.zsh-vi-mode;
        #     file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        #   }
        # ];
        oh-my-zsh = {
          enable = true;
          theme = "af-purple-magic";
          custom = "${zsh-themes}";
          plugins = [
            ''
              direnv
              vi-mode
            ''
          ];
        };
        inherit (common) shellAliases;
        inherit (common) sessionVariables;
        initContent = ''
          bindkey -M vicmd 'V' edit-command-line
        '';
        # initExtra = lib.mkOrder 1000 ''
        #   source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        #   bindkey -v
        #   bindkey '^f' autosuggest-accept;
        #   bindkey -M viins '^Q' vi-cmd-modebindkey -M viins '^Q' vi-cmd-mode
        # '';
      };

      programs.direnv = {
        enable = true;
        silent = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    }
  );
}
