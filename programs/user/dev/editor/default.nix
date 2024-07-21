{ pkgs
, config
, ...
}:
{
  imports = [
    ./neovim
    # ./vscodium
    ./android-studio
    # ./texstudio
  ];
}
