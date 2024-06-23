{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ azure-cli ];
}
