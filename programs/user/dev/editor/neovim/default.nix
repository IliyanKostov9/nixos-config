{ pkgs, lib, config, ... }:
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
      vimAlias = true;
      defaultEditor = lib.mkForce true;
      extraPackages = with pkgs; [ yamllint nodejs_22 unzip ];
    };
  };
}
