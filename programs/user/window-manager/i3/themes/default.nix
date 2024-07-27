{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    gruvbox-dark-gtk
  ];
}
