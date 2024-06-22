{ pkgs
, config
, ...
}:
{
  imports = [
    ./chromium
    ./firefox
    ./librewolf
    ./microsoft-edge
  ];
}
