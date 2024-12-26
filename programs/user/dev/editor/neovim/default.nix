{ pkgs_unstable, lib, user, config, ... }:
with lib;
with lib.types;
let
  cfg = config.modules.dev.editor.neovim;
in
{
  options.modules.dev.editor.neovim = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable neovim 
      '';
    };

    github-config-enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Whether to install neovim config from Github
      '';
    };

    github-owner = mkOption {
      type = str;
      description = mkDoc ''
        Github owner to install the config
      '';
    };

    github-repo = mkOption {
      type = str;
      description = mkDoc ''
        Github repo to install the config
      '';
    };

    github-rev = mkOption {
      type = str;
      description = mkDoc ''
        Github revision to install the config
      '';
    };

    github-sha256 = mkOption {
      type = str;
      description = mkDoc ''
        Github commit sha to install the config
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = pkgs_unstable.neovim;
      defaultEditor = true;
      extraPackages = with pkgs_unstable; [ yamllint nodejs_22 ];
    };
  };
}
