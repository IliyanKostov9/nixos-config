{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    rose-pine-icon-theme
  ];
}
