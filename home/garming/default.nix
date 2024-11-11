{ config, ... }:
{
  imports = [
    ../../secrets
    ../../programs/user
  ];

  config.modules = {

    # Browsers
    librewolf.enable = true;
    chromium.enable = true;

    bat.enable = true;

    # Dev > Editor
    neovim.enable = true;

    # Dev > Emulator
    alacritty.enable = true;
    tmux.enable = true;

    # Dev > Git
    git = {
      enable = true;
      userName = "garming";
      userEmail = "garming.@something.com";
    };

    git-extras.enable = true;

    # Dev - > Shells
    bash.enable = true;
    zsh.enable = true;

    # File compression
    p7zip.enable = true;

    # Entertainment
    gaming.enable = true;

    # Media
    vlc.enable = true;
    nomacs.enable = true;

    # Office suuite
    libreoffice.enable = true;

    # VPN
    openvpn3.enable = false;

    # Window manager
    i3wm.enable = true;

    # X11- utils
    copyq.enable = true;
    flameshot.enable = true;
    normcap.enable = true;
  };
}
