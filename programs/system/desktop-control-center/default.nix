{ pkgs, config, ... }:

{
  imports = [
    ./display
    ./pavucontrol
    ./pamixer
    ./xfce4-appfinder
    ./network
  ];
}
