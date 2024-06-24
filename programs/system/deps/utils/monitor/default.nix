{ pkgs
, config
, ...
}:
{
  imports = [
    ./htop
    ./neofetch
  ];
}
