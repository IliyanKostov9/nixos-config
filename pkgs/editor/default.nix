{ pkgs
, config
, ...
}:
{
  imports = [
    ./vscodium
    ./android-studio
    ./texstudio
  ];
}
