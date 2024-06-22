{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ awscli2 ];
}
