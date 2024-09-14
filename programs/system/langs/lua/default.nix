{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lua;
in
{
  options.modules.lua = { enable = mkEnableOption "lua"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lua
      luajitPackages.luarocks # Needed for neovim
    ];
  };

}

