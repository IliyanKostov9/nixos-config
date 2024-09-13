{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.neovim;
in
{
  options.modules.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.neovim
    ];
  };

}
