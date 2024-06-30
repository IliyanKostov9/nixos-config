# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-401c9fe6-6316-449a-8a50-2e46ac3a5401".device = "/dev/disk/by-uuid/401c9fe6-6316-449a-8a50-2e46ac3a5401";
  networking.hostName = "baks";
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary networking.proxy.default = "http://user:password@proxy:port/"; networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Sofia";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "bg_BG.UTF-8";
    LC_IDENTIFICATION = "bg_BG.UTF-8";
    LC_MEASUREMENT = "bg_BG.UTF-8";
    LC_MONETARY = "bg_BG.UTF-8";
    LC_NAME = "bg_BG.UTF-8";
    LC_NUMERIC = "bg_BG.UTF-8";
    LC_PAPER =
      "bg_BG.UTF-8";
    LC_TELEPHONE = "bg_BG.UTF-8";
    LC_TIME = "bg_BG.UTF-8";
  };
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = true;
    # displayManager.defaultSession = "none+i3";
    windowManager.i3 = {
      enable = false;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };
  # I3 support
  environment.pathsToLink = [ "/libexec" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default, no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.libinput.enable = true;
  users.users.ikostov2 = {
    isNormalUser = true;
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

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ikostov2";
  # Workaround for GNOME auto:wlogin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs = {
    firefox.enable = true;
    gpaste.enable = true;
    chromium.enable = true;
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
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    tree
    git
    patchelf
    unzip
    zlib
    libstdcxx5
    bzip2
    xz
    openssl
    readline
    sqlite
    tcl
    tk
    curl
    libffi
    gnumake
    patch
    libuuid
    vim
    neovim
    tmux
    libgccjit
    glibc
    binutils
    gcc
    ncurses
    #pyenv  # broken: unable to install python
    python3
    python311Packages.pip
    python311Packages.pipx
    nodejs_22
    gitmoji-cli
    jdk19
    maven
    gradle
    kubectl
    docker
    terraform
    kotlin
    go
    fzf
    dotnetCorePackages.sdk_8_0_1xx
    rustup
    ripgrep
    lua-language-server
  ];

  # Enable nerd fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "0xProto" ]; })
  ];

  # Needed for compatibility purposes
  environment.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  # Env vars
  environment.variables = {
    EDITOR = "nvim";
    JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    PATH = "${pkgs.jdk}/bin:" + builtins.getEnv "PATH";
  };
  services.openvpn.servers = {
    personalVPN = {
      config = "config /etc/nixos/config/openvpn/personalVPN.ovpn";
      updateResolvConf = true;
      autoStart = true;
    };
  };

  # Garbage collection of old generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-delete-older-than 7d";
  };

  # Enable programs

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    chromium = {
      enableWideVine = true;
    };
  };
  # Quemu
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  # For Android
  programs.adb.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  services.openssh.enable = true;

  # NixOS version
  system.stateVersion = "24.05";
}
