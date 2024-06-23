{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ openvpn3 ];
}

