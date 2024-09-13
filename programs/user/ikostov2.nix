{ config
, ...
}:
{
  imports = [
    ./api
    ./browsers
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

    awscli2.enable = true;
    azure-cli.enable=true;
    rclone.enable=true;
  };
}
