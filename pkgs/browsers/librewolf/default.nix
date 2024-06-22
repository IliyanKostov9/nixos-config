{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ librewolf ];
}
