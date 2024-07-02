{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    i3
  ];

  imports = [
    ./config
    ./themes
  ];
}
