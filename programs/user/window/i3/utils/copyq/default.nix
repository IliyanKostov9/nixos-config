{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ copyq ];
}



