{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ android-studio ];
  # programs.adb.enable = true;
}
