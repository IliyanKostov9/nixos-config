# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-401c9fe6-6316-449a-8a50-2e46ac3a5401".device = "/dev/disk/by-uuid/401c9fe6-6316-449a-8a50-2e46ac3a5401";
  networking.hostName = "blackberry";
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
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ikostov2 = {
    isNormalUser = true;
    description = "ikostov2";
    extraGroups = ["docker" "users" "networkmanager" "wheel" ];
    packages = with pkgs; [
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
      vscodium
      sdkmanager
      azure-cli
      awscli2
      gh
      git-extras
      android-studio
      # Not sure about this one
      indicator-application-gtk3
      gnome.gnome-software
      normcap
      shotwell
      #gnome.gnome-tweaks
      gnomeExtensions.search-light
      gnomeExtensions.dock-from-dash
      gnomeExtensions.zen
      gnomeExtensions.dash-to-dock-toggle
      gnomeExtensions.dock-reloaded
      gnomeExtensions.window-title-is-back
      gnomeExtensions.user-themes
      gnomeExtensions.paperwm
      p7zip
      drawio
      qemu
      qFlipper
      texstudio
      inkscape
      gitmoji-cli
      wineWowPackages.waylandFull
      lazydocker
      xsel
      gnomeExtensions.window-calls
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ikostov2";

  # Workaround for GNOME auto:wlogin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;


  virtualisation.docker.enable = true;
  virtualisation.docker.rootless ={
  enable = true;
  setSocketVariable = true;
};

  # Install firefox.
  programs = {
    firefox.enable = true;
    gpaste.enable = true;
    chromium.enable = true;
  };


  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    chromium = {
      enableWideVine = true;
    };
  };



  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
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
    # broken: unable to install python
    #pyenv
    python3
    nodejs_22
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


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "0xProto" ]; })
  ];



  environment.sessionVariables = {
    PYENV_ROOT = "$HOME/.pyenv";
    CPPFLAGS = "-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl.dev}/include";
    CXXFLAGS = "-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl.dev}/include";
    CFLAGS = "-I${pkgs.openssl.dev}/include";
    LDFLAGS = "-L${pkgs.zlib.out}/lib -L${pkgs.libffi.out}/lib -L${pkgs.readline.out}/lib -L${pkgs.bzip2.out}/lib -L${pkgs.openssl.out}/lib";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    PYENV_VIRTUALENV_DISABLE_PROMPT = "1";
  };

  environment.variables = {
    EDITOR = "nvim";
    JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    PATH = "${pkgs.jdk}/bin:" + builtins.getEnv "PATH";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
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




  # Some programs need SUID wrappers, can be configured further or are started in user sessions. programs.mtr.enable = true; programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  #services.openssh.enable = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall altogether. networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken. It‘s perfectly fine and recommended to leave this value at the 
  # release version of the first install of this system. Before changing this value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
