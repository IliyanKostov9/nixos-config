{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    lua
    lua-language-server
  ];
} 
