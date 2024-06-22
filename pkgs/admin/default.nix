{ pkgs
, config
, ...
}:
{
  imports = [
    ./htop
    ./xclip
    ./neofetch
  ];
}
