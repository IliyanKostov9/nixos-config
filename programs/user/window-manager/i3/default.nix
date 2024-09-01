{ pkgs
, ...
}:
{
  home.packages = with pkgs; [
    i3
    picom
  ];

  imports = [
    ./themes
  ];
}
