{ pkgs
, config
, ...
}:
{
  imports = [
    ./nnn
    ./sdkmanager
    ./sops
    ./gnupg
    ./pinentry-qt
  ];
}
