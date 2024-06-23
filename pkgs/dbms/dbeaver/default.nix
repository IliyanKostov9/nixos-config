{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ dbeaver-bin ];
}
