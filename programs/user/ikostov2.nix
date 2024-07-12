{ pkgs
, config
, ...
}:
{
  imports = [
    ./api
    ./archive
    ./browsers
    ./cloud
    ./dbms
    ./dev
    ./iot
    ./media
    ./office-suite
    ./password-manager
    ./translate
    ./virtualisation
    ./vpn
    ./window-manager
    ./x11-utils
    ./win-api
  ];
}
