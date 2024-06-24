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
    ./window
    ./x11-utils
  ];
}
