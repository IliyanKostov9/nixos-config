{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.langs.lua;
in
{
  options.modules.dev.langs.lua = { enable = mkEnableOption "lua"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lua
      luajitPackages.luarocks # Needed for neovim
    ];
  };

}

