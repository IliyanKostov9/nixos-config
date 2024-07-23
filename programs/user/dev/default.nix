{ pkgs
, config
, ...
}:
{
  imports = [
    ./editor
    ./emulator
    ./git-extras
    ./command-line
    # ./terminal-ui
  ];
}
