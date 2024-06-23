{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ sdkmanager ];
}
