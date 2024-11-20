{ config, ... }:
{
  imports = [
    # ./overlays.nix
    ../../secrets
    ../../programs/user
  ];

  config.modules = {
    fonts.name = "0xProto";

    nix-alien.enable = true;
    # API
    postman.enable = true;

    # Browsers
    librewolf.enable = true;
    chromium.enable = true;

    # Cloud
    awscli2.enable = true;
    azure-cli.enable = true;
    rclone.enable = false;

    # DBMS
    dbeaver.enable = true;

    # RDP
    vnc.enable = false;

    # Dev > Command-line
    sops.enable = true;
    bat.enable = true;
    ggshield.enable = true;

    # Dev > Editor
    neovim.enable = true;

    # Dev > Emulator
    alacritty.enable = true;
    tmux.enable = true;

    # Dev > Git
    git = {
      enable = true;
      userName = "iliyan-kostov";
      userEmail = "iliyan.kostov@email.ikostov.org";
    };

    gh.enable = true;
    git-extras.enable = true;
    gitmoji-cli.enable = false;

    # Dev - > Shells
    bash.enable = true;
    zsh.enable = true;

    # Dev > Langs
    go.enable = true;
    jdk.enable = true;
    lua.enable = true; # REQUIRED: By nvim jdtls
    node.enable = true;
    python.enable = true;
    rust.enable = true;
    terraform.enable = false;

    # Dev > Build tools
    maven.enable = true;
    gradle.enable = false;

    # Dev >  Container
    docker.enable = true;
    k8s.enable = false;

    # File compression
    p7zip.enable = true;

    # IoT
    qFlipper.enable = true;

    etcher.enable = false;

    # Media
    gimp.enable = true;
    obs-studio.enable = true;
    vlc.enable = true;
    calibre.enable = false;
    nomacs.enable = true;
    okular.enable = true;
    viber.enable = true;

    # Office suite
    drawio.enable = true;
    libreoffice.enable = true;
    mail.enable = true;

    # Password manager
    keepass.enable = true;

    # Translate
    dialect.enable = false;

    # Virtualisation
    qemu.enable = true;
    virt-manager.enable = true;
    lazydocker.enable = true;

    # VPN
    openvpn3.enable = true;

    # Preferences
    red-light.enable = true;

    # Window manager
    i3wm.enable = true;

    # X11- utils
    copyq.enable = true;
    flameshot.enable = true;
    gpick.enable = false;
    normcap.enable = true;
  };
}
