# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
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
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ikostov2";
  # Workaround for GNOME auto:wlogin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;


  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    home-manager
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
  # NixOS version
  system.stateVersion = "24.05";
}
