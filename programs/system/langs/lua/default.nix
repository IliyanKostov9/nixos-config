{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    lua
  ];
} 
