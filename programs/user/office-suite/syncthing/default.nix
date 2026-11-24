{
  lib,
  config,
  user,
  ...
}:
with lib; let
  cfg = config.modules.office-suite.syncthing;
  syncthingRootDir = "/home/${user}/Documents/Syncthing";
  versioningTrashNoCleanup = {
    type = "trashcan";
    cleanupIntervalS = 0;
    params.cleanoutDays = "0";
  };
in {
  options.modules.office-suite.syncthing = {enable = mkEnableOption "syncthing";};

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      settings = {
        devices = {
          pi = {
            id = "NZT7DOU-TPREBSK-BUN3Y2O-LGNZWA3-TMKNS7Y-PHQMTU3-3OJTKCM-YAGUZQL";
            name = "pi";
            autoAcceptFolders = false;
          };
          pixel7 = {
            id = "44PHGHN-QVFVQOJ-E3V77A5-6OT5ZIL-SWPRC4U-73EAP5D-S4LDTQ6-JIFZVAK";
            name = "Pixel7";
            autoAcceptFolders = false;
          };
        };
        folders = {
          Backup = {
            enable = true;
            label = "Backup";
            path = "${syncthingRootDir}/Backup";
            type = "sendonly";
            devices = [
              "pi"
              "pixel7"
            ];
          };

          Books = {
            enable = true;
            label = "Books";
            path = "${syncthingRootDir}/Books";
            type = "sendreceive";
            versioning = versioningTrashNoCleanup;
            devices = [
              "pixel7"
            ];
          };
          temp = {
            enable = true;
            label = "temp";
            path = "${syncthingRootDir}/temp";
            type = "sendreceive";
            devices = [
              "pixel7"
            ];
          };
          Wallpapers = {
            enable = true;
            label = "Wallpapers";
            path = "${syncthingRootDir}/Wallpapers";
            type = "sendreceive";
            devices = [
              "pixel7"
            ];
          };
          Documents = {
            enable = true;
            label = "Documents";
            path = "${syncthingRootDir}/Documents";
            type = "sendonly";
            devices = [
              "pi"
            ];
          };
          Music = {
            enable = true;
            label = "Music";
            path = "${syncthingRootDir}/Music";
            type = "sendonly";
            devices = [
              "pixel7"
            ];
          };

          PicturesPersonalReceivePixels = {
            enable = true;
            label = "(Pictures Personal) <= Pixel";
            path = "${syncthingRootDir}/Pictures/Personal/Pictures";
            type = "receiveonly";
            versioning = versioningTrashNoCleanup;
            devices = [
              "pixel7"
            ];
          };
          PicturesWorkReceivePixels = {
            enable = true;
            label = "(Pictures Work) <= Pixel";
            path = "${syncthingRootDir}/Pictures/Work/Experian";
            versioning = versioningTrashNoCleanup;
            type = "receiveonly";
            devices = [
              "pixel7"
            ];
          };
          NatureReceivePixels = {
            enable = true;
            label = "Nature <= Pixel";
            path = "${syncthingRootDir}/Pictures/Personal/Nature";
            type = "receiveonly";
            versioning = versioningTrashNoCleanup;
            devices = [
              "pixel7"
            ];
          };

          PicturesPersonalSendPis = {
            enable = true;
            label = "(Pictures Personal) => PI";
            path = "${syncthingRootDir}/Pictures/Personal";
            type = "sendonly";
            devices = [
              "pi"
            ];
          };

          PicturesMomSendPis = {
            enable = true;
            label = "(Pictures Mom) => PI";
            path = "${syncthingRootDir}/Pictures/Mama-Pictures";
            versioning = versioningTrashNoCleanup;
            type = "sendonly";
            devices = [
              "pi"
            ];
          };
          PicturesTuVarnaSendPis = {
            enable = true;
            label = "(Pictures Tu-Varna) => PI";
            path = "${syncthingRootDir}/Pictures/Tu-Varna";
            type = "sendonly";
            devices = [
              "pi"
            ];
          };
          PicturesWorkSendPis = {
            enable = true;
            label = "(Pictures Work) => PI";
            path = "${syncthingRootDir}/Pictures/Work";
            type = "sendonly";
            devices = [
              "pi"
            ];
          };
        };
      };
    };
  };
}
