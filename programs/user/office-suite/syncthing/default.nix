{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.office-suite.syncthing;
in {
  options.modules.office-suite.syncthing = {enable = mkEnableOption "syncthing";};

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      # BUG: For some reason the settings option is not found in home manager
      #   guiAddress = "127.0.0.1:8384";
      #   settings = {
      #     devices.pi = {
      #       id = pi-device-id;
      #       name = "pi";
      #       autoAcceptFolders = "false";
      #     };
      #
      #     devices.pixel = {
      #       id = pixel-device-id;
      #       name = "Pixel7";
      #       autoAcceptFolders = "false";
      #     };
      #     folders.hdd = {
      #       enable = true;
      #       id = "";
      #       label = "HDD";
      #       path = "/mnt/HDD/Music";
      #       type = "sendreceive";
      #       devices = [
      #         pi-device-id
      #       ];
      #     };
      #   };
    };
  };
}
