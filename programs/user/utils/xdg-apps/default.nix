_: {
  # TODO: add if statements if config modules for librewolf and nomacs exist in usr pkgs
  config = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["pcmanfm.desktop"];
        "x-scheme-handler/http" = ["librewolf.desktop"];
        "x-scheme-handler/https" = ["librewolf.desktop"];
        "text/html" = ["librewolf.desktop"];
        "video/*" = ["vlc.desktop"];
        "image/jpeg" = ["nomacs.desktop"];
        "image/png" = ["nomacs.desktop"];
        "application/x-drawio" = ["drawio.desktop"];
        "application/vnd-visio" = ["drawio.desktop"];
      };
      associations.removed = {
        "image/jpeg" = ["chromium-browser.desktop"];
        "image/png" = ["chromium-browser.desktop"];
      };
    };
  };
}
