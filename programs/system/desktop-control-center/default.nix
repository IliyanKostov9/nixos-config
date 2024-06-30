{ pkgs, config, ... }:

{
  imports = [ ./pavucontrol ./pamixer ./xfce4-appfinder ./network ];
}
