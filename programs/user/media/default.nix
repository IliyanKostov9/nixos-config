{ pkgs
, config
, ...
}:
{
  imports = [
    ./vlc
    ./gimp
    ./shotwell
    ./obs-studio
  ];
}
