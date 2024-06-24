{ pkgs
, config
, ...
}:
{
  imports = [
    ./editor
    ./emulator
    ./git-extras
    ./build-tools/sdkmanager
  ];
}
