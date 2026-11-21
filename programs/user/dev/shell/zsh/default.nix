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

  get-secret = {secret}:
    if secrets ? ${secret}
    then escapeShellArg secrets."${secret}".path
    else warn "> Secret ${secret} is missing. Moving on..." "";

  ikostov-zsh-themes = pkgs.fetchFromGitHub {
    owner = "IliyanKostov9";
    repo = "zsh-themes";
    rev = "master";
    hash = "sha256-d1SCz/mi3HPJI8wi0RXrwjy8U1nt/Le1une7bPCSFCY=";
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

    theme = mkOption {
      type = str;
      default = "af-purple-magic";
      description = mkDoc ''
        Theme of Ohmyzsh
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
          inherit (cfg) theme;
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

          load_secret AZURE_DEVOPS_EXT_PAT ${get-secret {secret = "azure_devops_ext_pat";}}
          load_secret GITGUARDIAN_API_KEY ${get-secret {secret = "gitguardian_api_key";}}
          load_secret GH_TOKEN ${get-secret {secret = "gh_token";}}
          load_secret TF_TOKEN_app_terraform_io ${get-secret {secret = "tf_token_app_terraform_io";}}
          load_secret TF_ORG ${get-secret {secret = "tf_org";}}

          load_secret WORK_NAME ${get-secret {secret = "work_name";}}
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
