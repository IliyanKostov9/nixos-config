{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.dev.editor.neovim;
in {
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
    home.packages = with pkgs; [
      neovim
      yamllint
      nodejs_22
      unzip
      ktlint
      tree-sitter
    ];
  };
}
