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
