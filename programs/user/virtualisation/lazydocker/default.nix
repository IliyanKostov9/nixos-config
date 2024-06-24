{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ lazydocker ];
}
