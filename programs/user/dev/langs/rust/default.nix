{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.langs.rust;
in
{
  options.modules.dev.langs.rust = { enable = mkEnableOption "rust"; };

  config = mkIf cfg.enable {
    # Needed for Neovim rnix-lsp and rnix-fmt
    home.packages = with pkgs; [ rustup ];
  };

}

