{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ pinetry-qt ];
}
