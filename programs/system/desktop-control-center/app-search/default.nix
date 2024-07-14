{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ xfce.xfce4-appfinder ];
}


