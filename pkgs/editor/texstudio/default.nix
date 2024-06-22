{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ texstudio ];
}
