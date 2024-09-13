{ config
, ...
}:
{
  imports = [
    ./api
    ./cloud
    ./dev
    ./gpu
    ./office-suite
    ./virtualisation
    ./window-manager
    ./x11-utils
    ./win-api
  ];

  config.modules = {
    postman.enable = true;
    librewolf.enable=true;
    chromium.enable=true;
    microsoft-edge.enable=true;
  };
}
