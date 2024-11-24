{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.dev.editor.neovim;
in
{
  options.modules.dev.editor.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs_unstable.neovim
    ];
  };

}
