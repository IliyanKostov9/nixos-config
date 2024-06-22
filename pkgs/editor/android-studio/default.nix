{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ android-stuio ];
  programs.adb.enable = true;
}
