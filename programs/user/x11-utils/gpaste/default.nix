{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ gnome.gpaste ];
}
