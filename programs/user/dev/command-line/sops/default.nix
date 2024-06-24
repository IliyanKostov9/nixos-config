{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ sops ];
}
