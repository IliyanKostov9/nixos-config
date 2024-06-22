{ config, lib, pkgs, ... }:

{
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
  # For Android
  programs.adb.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  services.openssh.enable = true;

}
