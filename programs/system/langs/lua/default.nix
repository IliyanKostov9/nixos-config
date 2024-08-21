{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    lua
    luajitPackages.luarocks # Needed for neovim
  ];
} 
