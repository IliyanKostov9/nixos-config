{ pkgs, config, ... }:

{
  imports = [
    ./pavucontrol
    ./audio
    ./red-light
    ./app-search
    ./network
  ];
}
