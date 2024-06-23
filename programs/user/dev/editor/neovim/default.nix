{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ neovim ];
}
