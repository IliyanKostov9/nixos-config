{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ xclip ];
}
