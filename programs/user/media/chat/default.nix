{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ viber ];
}
