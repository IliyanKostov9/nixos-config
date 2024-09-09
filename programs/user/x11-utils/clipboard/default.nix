{ pkgs
, ...
}:
{
  home.packages = with pkgs; [
    copyq
    # gnome.gpaste 
  ];
}
