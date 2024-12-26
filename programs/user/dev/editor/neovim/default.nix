{ pkgs_unstable, lib, user, config, ... }:
with lib;
with lib.types;
let
  cfg = config.modules.dev.editor.neovim;
  config-already-exists = if builtins.pathExists "/home/${user}/.config/nvim/init.lua" then true else false;

  neovim-config =
    mkIf cfg.github-config-enable {
      github-repo =
        if config-already-exists then
          pkgs_unstable.fetchFromGitHub
            {
              owner = cfg.github-owner;
              repo = cfg.github-repo;
              rev = cfg.github-rev;
              hash = cfg.github-sha256;
            } else lib.error "Error: neovim config already exists!" { };

      neovim-config-derv =
        if (! config-already-exists) then

          pkgs_unstable.stdenv.mkDerivation
            {
              name = "neovim-config";
              phases = [ "buildPhase" ];
              buildPhase = ''
                mkdir -p ~/.config/nvim
                cp -r ${github-repo} ~/.config/nvim/
              '';
            } else { };
    };
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
