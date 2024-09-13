{ config
, ...
}:
{
  imports = [
    ./modules.nix
  ];

  config.modules = {

    # API
    postman.enable = true;

    # Browsers
    librewolf.enable=true;
    chromium.enable=true;

    # Cloud
    awscli2.enable = true;
    azure-cli.enable=true;
    rclone.enable=true;
    
    # DBMS
    dbeaver.enable=true;

    # Dev -> Command-line
    gnupg.enable=true;
    sops.enable=true;

    # Dev -> Command-line
    neovim.enable=true;

    # Dev -> Emulator
    alacritty.enable=true;
    tmux.enable=true;

    # Dev -> Emulator
    gh.enable=true;
    git-extras.enable=true;
    gitmoji-cli.enable=true;

    # File compression
    p7zip.enable=true;

    # IoT
    qFlipper.enable=true;

    # Media
    gimp.enable=true;
    obs-studio.enable=true;
    vlc.enable=true;

    # Office suuite
    drawio.enable=true;
    libreoffice.enable=true;
    mail.enable=true;

    # VPN
    openvpn3.enable=true;
  };
}
