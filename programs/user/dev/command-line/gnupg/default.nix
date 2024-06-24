{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ gnupg ];
}
