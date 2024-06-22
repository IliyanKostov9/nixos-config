{ pkgs
, config
, ...
}:
{
  imports = [
    ./admin
    ./api
    ./archive
    ./browsers
    ./cloud
    ./dbms
    ./dev
    ./editor
    ./emulator
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
