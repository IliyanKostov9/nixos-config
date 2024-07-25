{ pkgs
, config
, ...
}:
{
  imports = [
    ./chat
    ./vlc
    ./gimp
    ./shotwell
    ./obs-studio
  ];
}
