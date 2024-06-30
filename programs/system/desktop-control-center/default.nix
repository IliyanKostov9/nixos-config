{ pkgs, config, ... }:

{
  imports = [ ./pavucontrol ./pamixer ];
}
