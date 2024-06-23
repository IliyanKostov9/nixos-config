{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ microsoft-edge ];
}
