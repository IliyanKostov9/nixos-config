{ config, pkgs, ... }:

{
  home = {
    isNormalUser = true;
    homeDirectory = "/home/ikostov2";
    username = "ikostov2";
    description = "ikostov2";
    extraGroups = [ "libvirtd" "adbusers" "kvm" "docker" "users" "networkmanager" "wheel" ];
    packages = with pkgs; [
      postman
      obs-studio
      terminator
      dbeaver-bin
      microsoft-edge
      librewolf
      openvpn3
      rclone
      rclone-browser
      dialect
      keepass
      ungoogled-chromium
      flameshot
      microsoft-edge
      gnome.gpaste
      normcap
      htop
      gpick
      neofetch
      xclip
      # vscodium
      sdkmanager
      azure-cli
      awscli2
      gh
      git-extras
      android-studio
      indicator-application-gtk3
      gnome.gnome-software
      normcap
      shotwell
      gnomeExtensions.dock-from-dash
      gnomeExtensions.zen
      gnomeExtensions.search-light
      gnomeExtensions.window-title-is-back
      gnomeExtensions.user-themes
      p7zip
      drawio
      qemu
      virt-manager
      qFlipper
      texstudio
      inkscape
      wineWowPackages.waylandFull
      lazydocker
      xsel
      vlc
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      i3
    ];
  };

  # Programs
  programs = {
    firefox.enable = true;
    gpaste.enable = true;
    chromium.enable = true;
    virt-manager.enable = true;
    # For Android
    adb.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    # .bashrc
    bash = {
      shellAliases = {
        clip = "xclip -selection clipboard";
        timmy = "tmux new-session '~/.local/bin/tmux-ls-sessionizer'";
        buzz = "cd $(find . -type d | fzf)";
        git-all = "git add . && git commit && ( git push || git push --set-upstream origin master )";
        py-setup-venv = "~/.local/bin/python/python-venv-setup";
      };
    };
  };

  # Environment
  environment = {
    # Needed for compatibility purposes
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };
    # Env vars
    variables = {
      EDITOR = "nvim";
      JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
      PATH = "${pkgs.jdk}/bin:" + builtins.getEnv "PATH";
    };
  };

  # Quemu and Docker
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };

    };
  };

  # Services
  services = {
    openssh.enable = true;
    libinput.enable = true;
    openvpn.servers = {
      personalVPN = {
        config = "config /home/ikostov2/.config/openvpn/personalVPN.ovpn";
        updateResolvConf = true;
        autoStart = true;
      };
    };
  };
  # Enable nerd fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "0xProto" ]; })
  ];


  home.stateVersion = "24.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
