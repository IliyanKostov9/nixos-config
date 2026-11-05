{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  inherit (config.sops) secrets;
  cfg = config.modules.dev.shell.zsh;

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
        oh-my-zsh = {
          enable = true;
          theme = "af-purple-magic";
          custom = "${zsh-themes}";
          plugins = [
            "direnv"
            "vi-mode"
          ];
        };
        inherit (common) shellAliases;
        inherit (common) sessionVariables;
        initContent = ''
          bindkey -M vicmd 'V' edit-command-line

          load_secret() {
            local name="$1"
            local path="$2"

            if [[ -r "$path" ]]; then
              export "$name=$(<"$path")"
            fi
          }

          load_secret AZURE_DEVOPS_EXT_PAT ${lib.escapeShellArg secrets.azure_devops_ext_pat.path}
          load_secret GITGUARDIAN_API_KEY ${lib.escapeShellArg secrets.gitguardian_api_key.path}
          load_secret GH_TOKEN ${lib.escapeShellArg secrets.gh_token.path}
          load_secret TF_TOKEN_app_terraform_io ${lib.escapeShellArg secrets.tf_token_app_terraform_io.path}
          load_secret TF_ORG ${lib.escapeShellArg secrets.tf_org.path}

          load_secret WORK_NAME ${lib.escapeShellArg secrets.work_name.path}
          export WORK_NAME="''${WORK_NAME:l}"
        '';
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
