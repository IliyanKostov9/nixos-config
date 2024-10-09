{ config, ... }:
{
  imports = [
    ../../secrets
    ../../programs/user
  ];

  config.modules = {

    nix-alien.enable = false;

    # API
    postman.enable = false;

    # Browsers
    librewolf.enable = true;
    chromium.enable = true;

    # Cloud
    awscli2.enable = true;
    azure-cli.enable = true;
    rclone.enable = true;

    # DBMS
    dbeaver.enable = false;

    # RDP
    vnc.enable = false;

    # Dev > Command-line
    sops.enable = true;
    bat.enable = true;

    # Dev > Editor
    neovim.enable = true;

    # Dev > Emulator
    alacritty.enable = true;
    tmux.enable = true;

    # Dev > Git
    git.enable = true;
    git.userName = "iliyan-kostov";
    git.userEmail = "iliyan.kostov@email.ikostov.org";

    gh.enable = true;
    git-extras.enable = true;
    gitmoji-cli.enable = true;

    # Dev - > Shells
    bash.enable = true;
    zsh.enable = true;

    # Dev > Langs
    go.enable = true;
    jdk.enable = true;
    lua.enable = true;
    node.enable = true;
    python.enable = true;
    rust.enable = true;
    terraform.enable = true;

    # Dev > Build tools
    maven.enable = false;
    gradle.enable = false;

    # Dev >  Container
    docker.enable = true;
    k8s.enable = false;

    # File compression
    p7zip.enable = true;

    # IoT
    qFlipper.enable = true;

    etcher.enable = true;

    # Media
    gimp.enable = true;
    obs-studio.enable = true;
    vlc.enable = true;
    calibre.enable = true;
    viber.enable = true;
    nomacs.enable = true;

    # Office suuite
    drawio.enable = true;
    libreoffice.enable = true;
    mail.enable = true;

    # Password manager
    keepass.enable = true;

    # Translate
    dialect.enable = true;

    # Virtualisation
    qemu.enable = true;
    virt-manager.enable = true;
    lazydocker.enable = true;

    # VPN
    openvpn3.enable = true;
    cisco-anyconnect.enable = true;

    # Window manager
    i3wm.enable = true;

    # X11- utils
    copyq.enable = true;
    flameshot.enable = true;
    gpick.enable = true;
    normcap.enable = true;
    gtk.enable = true;
  };
}
