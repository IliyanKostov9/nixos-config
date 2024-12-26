{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.dev.editor.neovim;
in
{
  options.modules.dev.editor.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = pkgs_unstable.neovim;
      defaultEditor = true;
      extraPackages = with pkgs_unstable; [ yamllint nodejs_22 ];
    };
  };
}
