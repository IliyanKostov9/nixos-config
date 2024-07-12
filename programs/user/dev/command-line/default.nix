{ pkgs
, config
, ...
}:
{
  imports = [
    ./sdkmanager
    ./sops
    ./gnupg
    ./pinentry-qt
  ];
}
