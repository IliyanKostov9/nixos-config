{ pkgs
, config
, ...
}:
{
  imports = [
    ./chromium
    ./librewolf
    ./microsoft-edge
  ];
}
