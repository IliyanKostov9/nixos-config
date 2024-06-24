{ pkgs, config, ...}:

{
  environment.systemPackages = with pkgs; [
    lua-language-server
  ];
} 
