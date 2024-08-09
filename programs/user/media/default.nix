{ pkgs
, config
, ...
}:
{
  imports = [
    ./vlc
    ./gimp
    ./obs-studio
  ];
}
