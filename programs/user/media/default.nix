{ pkgs
, config
, ...
}:
{
  imports = [ ./vlc ./inkscape ./shotwell ./obs-studio ];
}
